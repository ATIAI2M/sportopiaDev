import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../app_const.dart';
import '../../models/chat.dart';
import '../../models/client.dart';
import '../../providers/data_provider.dart';
import '../matching/peopleProfile_screen.dart';
import '../../widgets/messages_item.dart';
import '../../widgets/people_item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

List<String> titles = <String>[
  'Messages'.toUpperCase(),
  'Vos partenaires'.toUpperCase(),
];

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Client> matchedClients = [];
  List<Client> chatClients = [];
  List<Chat> chats = [];
  late IO.Socket socket;

  Client? client;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client = Provider.of<DataProvider>(context, listen: false).client;
    Provider.of<DataProvider>(context, listen: false).getMatchings();
    Provider.of<DataProvider>(context, listen: false).getChats();
    socket = Provider.of<DataProvider>(context, listen: false).socket;
    Provider.of<DataProvider>(context, listen: false).connectToSocket();
    socket.on(client!.id, (data) {
      print("ok--notif");
      Provider.of<DataProvider>(context, listen: false).getChats();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    socket.off(client!.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        final client = dataProvider.client;
        final matchedClients = dataProvider.matchedClients;
        final chats = dataProvider.chats;
        final chatClients = dataProvider.chatClients;
        return SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                  height: 150,
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                              imageUrl: AppConstants().serverUrl + client!.imgUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'MESSAGERIE'.toUpperCase(),
                                  style: GoogleFonts.teko(
                                    textStyle: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: AppConstants.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Motivez-vous à deux ou plus !',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      color: AppConstants.gray1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                //   child: TextField(
                //     keyboardType: TextInputType.text,
                //     autofocus: false,
                //     style: TextStyle(
                //       color: AppConstants.gray1,
                //     ),
                //     decoration: InputDecoration(
                //       enabledBorder: OutlineInputBorder(
                //         borderSide:
                //             BorderSide(width: 1, color: Color(0xFFEDEDED)),
                //         borderRadius: BorderRadius.circular(45.0),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           width: 1,
                //           color: AppConstants.gray1,
                //         ),
                //         borderRadius: BorderRadius.circular(45.0),
                //       ),
                //       labelStyle: TextStyle(color: Color(0xFFFB3B2B2)),
                //       filled: true,
                //       fillColor: Colors.grey[200],
                //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(45.0),
                //       ),
                //       // prefix: SvgPicture.asset(
                //       //   'assets/images/search.svg',
                //       //   color: Color(0xFF848484),
                //       // ),
                //       prefixIcon: IconButton(
                //         icon: SvgPicture.asset(
                //           'assets/images/search.svg',
                //           color: Color(0xFF848484),
                //         ),
                //         color: AppConstants.gray1,
                //         onPressed: () {},
                //       ),
                //       hintText: 'Recherche ici...',
                //       hintStyle: TextStyle(
                //         color: AppConstants.gray1,
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  height: 60,
                  color: Color(0xFFF3F3F3),
                  child: TabBar(
                    indicatorPadding: EdgeInsets.fromLTRB(28, 8, 28, 8),
                    labelStyle: GoogleFonts.teko(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.black2,
                      ),
                    ),
                    indicator: BoxDecoration(
                      color: Color(0xFF202226),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    unselectedLabelColor: AppConstants.black2,
                    labelColor: Colors.white,
                    tabs: <Widget>[
                      Tab(
                        text: titles[0],
                      ),
                      Tab(
                        text: titles[1],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  //height: 50,
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                      children: <Widget>[
                        chatClients.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: chats.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final id =
                                        client!.id == chats[index].receiverId
                                            ? chats[index].senderId
                                            : chats[index].receiverId;
                                    final cl = chatClients.firstWhere(
                                        (element) => element.id == id);
      
                                    return MessagesItem(
                                      chat: chats[index],
                                      client: cl,
                                    );
                                  },
                                ),
                              )
                            : const SizedBox(),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: matchedClients.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PeopleProfileScreen(
                                                client: matchedClients[index],
                                                isMatched: true,
                                              )));
                                },
                                child: PeopleItem(
                                  client: matchedClients[index],
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      
  });
  }
}
