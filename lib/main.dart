import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/firebase_options.dart';
import 'package:testapp/providers/data_provider.dart';
import 'package:testapp/screens/chat/messages_screen.dart';
import 'package:testapp/screens/launch/splash_screen.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "sportopia-74ea2",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
   alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (Platform.isAndroid) {
    await FirebaseMessaging.instance.requestPermission();
  }

  // Check permission status
  if (settings.authorizationStatus == AuthorizationStatus.denied) {
    await Permission.notification.request();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          'Message received in the foreground: ${message.notification?.title}');
      _showInAppNotification(message);
    });

    // Handle when the app is opened from the background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked! Message: ${message.notification?.title}');
      _handleNotificationClick(message);
    });

    // Handle when the app is launched from a terminated state via notification
    _getInitialMessage();
  }

  // Show the notification in-app when received in the foreground
  void _showInAppNotification(RemoteMessage message) {
    print(message.data);
    print("---------------data --- ");
    Flushbar(
      title: message.notification?.title ?? 'Notification',
      message: message.notification?.body ?? 'You have received a new message.',
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: AppConstants.black,
      titleColor: Colors.white,
      icon: const Icon(
        Icons.notification_important,
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(8.0),
      borderRadius: BorderRadius.circular(8.0),
      onTap: (flushbar) {
        _handleNotificationClick(message);
        flushbar.dismiss();
      },
    ).show(navigatorKey.currentState!.overlay!.context);
  }

  // Handle notification click to navigate to the appropriate screen
  Future<void> _handleNotificationClick(RemoteMessage message) async {

    String chatId = message.data['chatId'];
    String clientId = message.data['receiverId'];
    var chat;
    // Access the data provider using navigatorKey's context
    final BuildContext context = navigatorKey.currentState!.overlay!.context;
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    await dataProvider.getChats().then((value) async {
      print("chat fetched");
      chat = dataProvider.chats.firstWhere((chat) => chat.id == chatId);
      print("object");

      await dataProvider.getChatClients().then((value) {
        try {
          print("chat clients fetched");
          final id =
              clientId == chat.receiverId ? chat.senderId : chat.receiverId;
          final cl = dataProvider.chatClients
              .firstWhere((element) => element.id == id);
          Navigator.of(navigatorKey.currentState!.context)
              .push(MaterialPageRoute<void>(
            builder: (BuildContext context) => MessagesScreen(
              chat: chat,
              client: cl,
            ),
          ));
        } catch (e) {
          print(e);
        }
      });
    });

    print("---------------click1 --- ");
    // final chat=dataProvider.chats.firstWhere((chat) => chat.id == chatId) ;
    // print(chat.id) ;
    // final client = dataProvider.chatClients.map((client) => print(client.id) ) ;
    print("---------------click2 --- ");

    // final chat = chats.firstWhere((chat) => chat.id == chatId);
    // final client = chatClients.map((client) => print(client.id));
    // final client = chatClients.firstWhere((client) => client.id == clientId);

    // if (chat != null && client != null) {
    //   Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute<void>(
    //     builder: (BuildContext context) => MessagesScreen(
    //       chat: chat,
    //       client: client,
    //     ),
    //   ));
    // } else {
    //   print('Chat or client not found.');
    // }
  }

  // Handle the initial message if the app was opened from a terminated state
  void _getInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print(
          'App opened from terminated state with notification: ${initialMessage.notification?.title}');
      _handleNotificationClick(initialMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider()),
      ],
      child: MaterialApp(
        
        navigatorKey: navigatorKey,
        title: 'Sportopia',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red , useMaterial3: false),
        home: SplashScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
