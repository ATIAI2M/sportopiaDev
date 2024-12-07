import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testapp/models/chat.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/models/matching.dart';
import 'package:testapp/models/message.dart';
import 'package:testapp/models/notification.dart';
import 'package:testapp/models/user.dart';
import 'package:path/path.dart';
import "package:async/async.dart";
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:firebase_messaging/firebase_messaging.dart';

class DataProvider with ChangeNotifier {
  final String serverUrl = "https://server.sportopia.tn";
  final String socketUrl = "https://server.sportopia.tn/websocket";

  // final String serverUrl = "http://192.168.100.33:3000";
  // final String socketUrl = "http://192.168.100.14:3000/websocket";

  late User user;
  Client? client;
  List<Matching> matchings = [];
  List<Client> clients = [];
  List<Client> matchedClients = [];
  List<Client> likedClients = [];
  List<Client> chatClients = [];
  Map<Client, double> sortedClients = {};
  List<Chat> chats = [];
  List<Notif> notifications = [];

  String gender = '';
  String activity = '';
  double minAge = 18;
  double maxAge = 80;
  double distance = 500;
  List<String> goal = [];

  String frequency = '';
  String club = '';
  String animal = '';
  List<String> language = [];
  String level = '';
  List<String> selectedsport = [];
  List<String> selectedItems = [];
  late IO.Socket socket;

  DataProvider() {
    connectToSocket();
  }

  void sendMessageSocket(String id) {
    if (socket.disconnected) {
      connectToSocket();
    }
    socket.emit('send_message', {"clientId": id});
  }

  void connectToSocket() {
    try {
      // Configure socket transports must be sepecified
      socket = IO.io(socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true
      });

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.on('connect_error', (e) => print(e));
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

  void setFilters(
    String genderVal,
    double distanceVal,
    double minAgeVal,
    double maxAgeVal,
    String frequencyVal,
    List<String> goalVal,
    String clubVal,
    String animalVal,
    List<String> languageVal,
    String levelVal,
    List<String> selectedsportVal,
    List<String> selectedItemsVal,
  ) {
    gender = genderVal;
    distance = distanceVal;
    minAge = minAgeVal;
    maxAge = maxAgeVal;
    frequency = frequencyVal;
    goal = goalVal;
    club = clubVal;
    animal = animalVal;
    language = languageVal;
    level = levelVal;
    selectedsport = selectedsportVal;
    selectedItems = selectedItemsVal;
  }

  Future<void> load() async {
    await getMatchings();
    await getClients();
  }

  Future<void> getChats() async {
    final url = '$serverUrl/api/chats/' + client!.id;

    final response = await http.get(Uri.parse(url), headers: {
      "x-access-token": user.accessToken,
    });
    print(user.accessToken);
    print("--------") ; 
    print('$serverUrl/api/chats/' + client!.id);


    try {
      print("response.body");
      print(response.body);
      final data = json.decode(response.body) as List<dynamic>;

      if (response.statusCode == 200) {
        chats = [];

        data.forEach((element) {
          final chat = Chat.fromJson(element);

          chats.add(chat);
        });
        await getChatClients();
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

 Future<void> getChatClients() async {
    final url = '$serverUrl/api/chats/clients/' + client!.id;

    final response = await http.get(Uri.parse(url), headers: {
      "x-access-token": user.accessToken,
    });
    

    try {
      final data = json.decode(response.body) as List<dynamic>;

      if (response.statusCode == 200) {
        chatClients = [];

        data.forEach((element) {
          print("chatClients");
          print(element);
          final chatclient = Client.fromJson(element);

          chatClients.add(chatclient);
        });
      }
    } catch (e) {
      print(e.toString());
    }
    //notifyListeners();
  }

  Future<List<Message>> getMessages(String id) async {
    List<Message> messages = [];
    final url = '$serverUrl/api/messages/' + id;

    final response = await http.get(Uri.parse(url), headers: {
      "x-access-token": user.accessToken,
    });

    try {
      print("response.body");
      print(response.body);
      final data = json.decode(response.body) as List<dynamic>;

      if (response.statusCode == 200) {
        data.forEach((element) {
                    final message = Message.fromJson(element);

          messages.add(message);
        });
      }
    } catch (e) {
      print(e.toString());
    }
    return messages;
  }

  Future<void> getClients() async {
    final url = '$serverUrl/api/clients/position/';
    
    final response = await http.post(Uri.parse(url),
        headers: {
          "x-access-token": user.accessToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "latitude": client!.position["coordinates"][1],
          "longitude": client!.position["coordinates"][0],
          "maxDistance": distance.round(),
          "gender": gender,
          "minAge": minAge.round(),
          "maxAge": maxAge.round(),
          "id": client!.id,
          "goal": goal, 
          "level": level,
          "frequency": frequency,
          "animal": animal,
          "club": club,
          "sports": selectedsport.isEmpty ? null : selectedsport,
          "items": selectedItems,
          "language": language
        }));
       print("r------");
       print(jsonEncode({
          "latitude": client!.position["coordinates"][1],
          "longitude": client!.position["coordinates"][0],
          "maxDistance": distance.round(),
          "gender": gender, //iwant to uppercase the first letter
          
          
          "minAge": minAge.round(),
          "maxAge": maxAge.round(),
          "id": client!.id,
          "goal": goal,
          "level": level,
          "frequency": frequency,
          "animal": animal,
          "club": club,
          "sports": selectedsport.isEmpty ? null : selectedsport,
          "items": selectedItems,
          "language": language
        }));
      

    try {
     
      final data = json.decode(response.body) as List<dynamic>;

      if (response.statusCode == 200) {
        sortedClients.clear();
        clients.clear();
        print(data);

        data.forEach((element) {
         
  
          final client = Client.fromJson(element["client"]);

          final distance = double.parse(element["distance"].toString());

          clients.add(client);
          sortedClients.putIfAbsent(client, () => distance);
        });
      }
      notifyListeners();
      
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> getMatchings() async {
    final url = '$serverUrl/api/matchings/' + client!.id;

    final response = await http.get(Uri.parse(url), headers: {
      "x-access-token": user.accessToken,
    });

    try {
      final data = json.decode(response.body) as List<dynamic>;

      if (response.statusCode == 200) {
        matchedClients = [];
        print(data.length);
        data.forEach((element) {
          print("matchedClients");
          print(element);
          final matching = Client.fromJson(element);

          matchedClients.add(matching);
        });
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
Future<void> deleteLike(String id) async {
    final url = serverUrl + '/api/likes/';

    try {
      final res = await http.delete(Uri.parse(url), headers: {
        "x-access-token": user.accessToken,
      }, body: {
        "clientId1": id,
        "clientId2": client!.id,
      });
      print(res.body);
      await getMatchings();
            notifyListeners();

    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getLikes() async {
    final url = '$serverUrl/api/likes/' + client!.id;

    final response = await http.get(Uri.parse(url), headers: {
      "x-access-token": user.accessToken,
    });

    try {
      final data = json.decode(response.body) as List<dynamic>;

      if (response.statusCode == 200) {
        likedClients = [];

        data.forEach((element) {
          final liked = Client.fromJson(element);

          likedClients.add(liked);
        });
      }
            notifyListeners();

    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<int> getLikesToday() async {
    final url = '$serverUrl/api/likes/todayLikes/' + client!.id;
    int likesCount = 0;

    final response = await http.get(Uri.parse(url), headers: {
      "x-access-token": user.accessToken,
    });

    try {
      final data = json.decode(response.body) as Map<String, dynamic>;
      print(data);

      if (response.statusCode == 200) {
        final likesToday = data['likesToday'];
        final limitReached = data['limitReached'];

        likesCount = likesToday;

        if (limitReached) {
          print('You have reached your daily like limit of 20 likes.');
        } else {
          print(
              'You have sent $likesToday likes today. You can send ${20 - likesToday} more.');
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return likesCount;
  }

  Future<void> deleteMatch(String id, String id2) async {
    final url = serverUrl + '/api/matchings/unmatch';

    try {
      final res = await http.delete(Uri.parse(url), headers: {
        "x-access-token": user.accessToken,
      }, body: {
        "clientId1": id,
        "clientId2": id2,
      });
      print(res.body);
      await getMatchings();
      await getChatClients();
      notifyListeners();

    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> login(String email, String password) async {
    bool res = false;
    final url = serverUrl + '/api/users/login';
    final response = await http
        .post(Uri.parse(url), body: {"email": email, "password": password});

    try {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      print(response.statusCode);

      if (response.statusCode == 200) {
        user = User.fromJson(extractedData);

        res = true;
        await getClient(user.id);
        await updateUserToken();
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<void> createUser(String email, String password) async {
    final url = serverUrl + '/api/users/';
    final response = await http
        .post(Uri.parse(url), body: {"email": email, "password": password});

    try {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      print(response.statusCode);

      if (response.statusCode == 200) {
        await login(email, password);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createOTP(String otp) async {
    final url = serverUrl + '/api/emailVerifications/';

    final response = await http.post(Uri.parse(url), headers: {
      "x-access-token": user.accessToken,
    }, body: {
      "userId": user.id,
      "otp": otp
    });
  }

  Future<void> getClient(String id) async {
    final url = serverUrl + '/api/clients/$id';
    final response = await http.get(Uri.parse(url), headers: {
      "x-access-token": user.accessToken,
    });

    try {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
     

      if (response.statusCode == 200) {
        client = Client.fromJson(extractedData);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> createClient(
  //   Client client,
  //   String lat,
  //   String lng,
  // ) async {
  //   final url = serverUrl + '/api/clients/';
  //   final response = await http.post(Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({
  //         'userId': user.id,
  //         'fullName': client.fullName,
  //         "phoneNumber": client.phoneNumber,
  //         "age": client.age.toString(),
  //         "gender": client.gender,
  //         'latitude': lat,
  //         'longitude': lng,
  //         "status": client.status,
  //         "verification": client.verification,
  //         "token": client.token,
  //         "sports": client.sports.toString(),
  //         "items": client.items.toString(),
  //         "language": client.language.toString(),
  //         "goal": client.goal,
  //         "frequency": client.frequency,
  //         "club": client.club,
  //         "animal": client.animal,
  //         "level": client.level,
  //         "country": client.country,
  //         "region": client.region,
  //         "city": client.city,
  //         "bio": client.bio,
  //         "instagram": client.instagram,
  //         "height": client.height.toString(),
  //         "weight": client.weight.toString()
  //       }));

  //   try {
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;

  //     if (response.statusCode == 200) {
  //       //client = Client.fromJson(extractedData["client"]);
  //       // extractedData.forEach((element) {
  //       //   print(element);
  //       //
  //       // });
  //       await getClient(user.id);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<void> createClient(
    Client client,
    String lat,
    String lng,
    XFile image,
  ) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(serverUrl + '/api/clients'));
      request.fields.addAll({
        'userId': user.id,
        'fullName': client.fullName,
        "phoneNumber": client.phoneNumber,
        "age": client.age.toString(),
        "gender": client.gender,
        'latitude': lat,
        'longitude': lng,
        "status": client.status,
        "verification": client.verification,
        "token": client.token,
        "sports": client.sports.toString(),
        "items": client.items.toString(),
        "language": client.language.toString(),
        "goal": client.goal.toString(),
        "frequency": client.frequency,
        "club": client.club,
        "animal": client.animal,
        "level": client.level,
        "country": client.country,
        "region": client.region,
        "city": client.city,
        "bio": client.bio,
        "instagram": client.instagram,
        "height": client.height.toString(),
        "weight": client.weight.toString()
      });
      request.headers.addAll({
        'Connection': 'keep-alive',
        'Accept': '*/*',
        'Content-Type': 'multipart/form-data'
      });
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      http.StreamedResponse response = await request.send();

      final extractedData = await response.stream.bytesToString();
      print(extractedData);
      if (response.statusCode == 200) {
        print("Uploaded");

        // final data = json.decode(extractedData) as Map<String, dynamic>;

        // client = Client.fromJson(data["client"]);
        await getClient(user.id);
      
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateClientImage(
    XFile image,
  ) async {
    try {
      var request = http.MultipartRequest(
          'PUT', Uri.parse(serverUrl + '/api/clients/updateimg/' + client!.id));

      request.headers.addAll({
        'x-access-token': user.accessToken,

        // 'Content-Type': 'multipart/form-data'
      });
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      http.StreamedResponse response
       = await request.send();

      final extractedData = await response.stream.bytesToString();
      print(extractedData);
      if (response.statusCode == 200) {
        print("Uploaded");

        // final data = json.decode(extractedData) as Map<String, dynamic>;

        // client = Client.fromJson(data["client"]);
        await getClient(user.id).then((value) => notifyListeners());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Matching?> like(String id) async {
    Matching? matching;
    final url = serverUrl + '/api/likes/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "x-access-token": user.accessToken,
        },
        body: {
          "clientId1": client!.id,
          "clientId2": id,
        },
      );
      print({
          "clientId1": client!.id,
          "clientId2": id,
        }) ; 
      print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      if (extractedData["matched"] != null) {
        matching = Matching.fromJson(extractedData["matched"]);
        await addNotification("Nouveau Match", "Quelqu'un fait un match", id);
        await load();
      } else {
        await addNotification(
            "Nouveau Like", "Quelqu'un vous fait une like", id);
      }
      await getLikes();
    } catch (e) {
      print(e.toString());
    }
    return matching;
  }

  // Future<void> getLikes() async {
  //   final url = '$serverUrl/api/likes/' + user.id;

  //   final response = await http.get(Uri.parse(url), headers: {
  //     "x-access-token": user.accessToken,
  //   });

  //   try {
  //     final data = json.decode(response.body) as List<dynamic>;

  //     if (response.statusCode == 200) {
  //       likes = [];

  //       data.forEach((element) {
  //         final like = Like.fromJson(element);

  //         likes.add(like);
  //       });
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   notifyListeners();
  // }

  Future<void> claim(String reportedId, String reason, String details) async {
    final url = serverUrl + '/api/claims/';

    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {
          "x-access-token": user.accessToken,
        },
        body: {
          "clientId1": client!.id,
          "clientId2": reportedId,
          "reason": reason,
          "details": details,
        },
      );
      print(res.body);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updatePosition(Map<String, Object> position) async {
    print(position);
    final url = serverUrl + '/api/clients/' + client!.id;

    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            "x-access-token": user.accessToken,
          },
          body: jsonEncode({
            "position": position,
          }));

      print(response.body);
      await getClient(user.id);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteAccount() async {
    final url = serverUrl + '/api/clients/' + client!.id;

    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            "x-access-token": user.accessToken,
          },
          body: jsonEncode({
            "status": "deleted",
          }));

      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> socialLogin(String email, String password) async {
    bool res = false;
    final url = serverUrl + '/api/users/social';
    final response = await http
        .post(Uri.parse(url), body: {"email": email, "password": password});

    try {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print("socialLogin");
      print(extractedData);
      print(response.statusCode);

      if (response.statusCode == 200) {
        user = User.fromJson(extractedData);
        print("user.id");
        print(user.id);
        res = true;
        await getClient(user.id);
        await updateUserToken();
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<void> sendMessage(
      String chatId, String receiverId, String text, String name) async {
    final url = serverUrl + '/api/messages/';
          print(chatId) ; 
          print(receiverId) ;
          print(text) ;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            "x-access-token": user.accessToken,
          },
          body: jsonEncode({
            "senderId": client!.id,
            "chatId": chatId,
            "receiverId": receiverId,
            "text": text,
          }));

      await addNotificationMessage(name, text, receiverId,client!.id, chatId );
      await getChats();
    } catch (e) {
      print(e.toString());
    }
  }
   Future<void> addNotificationMessage(
      String title, String body, String receiverId ,String senderId ,String chatId ) async {
    final url = serverUrl + '/api/notifications/';

    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            "x-access-token": user.accessToken,
          },
          body:
              jsonEncode({"title": title, "body": body, "clientId": receiverId , "senderId" : senderId , "chatId": chatId , "type": "message"}));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addNotification(
      String title, String body, String clientId ,{ String chatId=""}) async {
    final url = serverUrl + '/api/notifications/';

    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            "x-access-token": user.accessToken,
          },
          body:
              jsonEncode({"title": title, "body": body, "clientId": clientId , "chatId": chatId}));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getNotifications() async {
    final url = '$serverUrl/api/notifications/' + client!.id;

    final response = await http.get(Uri.parse(url), headers: {
      "x-access-token": user.accessToken,
    });

    try {
      final data = json.decode(response.body) as List<dynamic>;

      if (response.statusCode == 200) {
        notifications = [];

        data.forEach((element) {
          final notification = Notif.fromJson(element);

          notifications.add(notification);
        });
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> addReview(int rate, String comment, String clientId) async {
    final url = serverUrl + '/api/reviews/';

    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            "x-access-token": user.accessToken,
          },
          body: jsonEncode({
            "rate": rate,
            "comment": comment,
            "clientId": clientId,
            "reviewerId": client!.id
          }));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateProfile(
    String fullName,
    String phoneNumber,
    String bio,
    String instagram,
  ) async {
    final url = serverUrl + '/api/clients/' + client!.id;
    final response = await http.put(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          "x-access-token": user.accessToken,
        },
        body: jsonEncode({
          'fullName': fullName,
          "phoneNumber": phoneNumber,
          "bio": bio,
          "instagram": instagram
        }));

    try {
      print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        //client = Client.fromJson(extractedData["client"]);
        // extractedData.forEach((element) {
        //   print(element);
        //
        // });
        await getClient(user.id);
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> updateClient(Client cl) async {
    final url = serverUrl + '/api/clients/' + client!.id;
    final response = await http.put(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          "x-access-token": user.accessToken,
        },
        body: jsonEncode({
          "age": cl.age.toString(),
          "gender": cl.gender,
          "sports": cl.sports.toString(),
          "items": cl.items.toString(),
          "language": cl.language.toString(),
          "goal": cl.goal,
          "frequency": cl.frequency,
          "club": cl.club,
          "animal": cl.animal,
          "level": cl.level,
          "country": cl.country,
          "region": cl.region,
          "city": cl.city,
          "height": cl.height.toString(),
          "weight": cl.weight.toString()
        }));

    try {
      print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        //client = Client.fromJson(extractedData["client"]);
        // extractedData.forEach((element) {
        //   print(element);
        //
        // });
        await getClient(user.id);
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<bool> updatePass(String oldPassword, String newPassword) async {
    bool ischanged = false;
    final url = serverUrl + '/api/users/changePass/';
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          "x-access-token": user.accessToken,
        },
        body: jsonEncode({
          "oldPassword": oldPassword,
          "userId": user.id,
          "newPassword": newPassword,
        }));

    try {
      print(response.body);

      if (response.statusCode == 200) {
        ischanged = true;
      }
    } catch (e) {
      print(e.toString());
    }
    return ischanged;
  }

  Future<void> updateUserToken() async {
    try {
      String token = "";
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      //token = await messaging.getToken();
      if (Platform.isIOS) {
        FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
        NotificationSettings settings =
            await FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          final tempToken = await messaging.getToken();
          token = tempToken ?? "";
        }
      } else {
        final tempToken = await messaging.getToken();
        token = tempToken ?? "";
      }

      final url = '$serverUrl/api/clients/' + client!.id;

      await http.put(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            "x-access-token": user.accessToken,
          },
          body: jsonEncode({
            "token": token,
          }));
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> markMessagesAsSeen(String receiverId, String chatId) async {
  final url = '$serverUrl/api/chats/messages/mark-seen/${client!.id}/$chatId';
  print(url);
  try {
    final response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "x-access-token": user.accessToken,  // Add the JWT token if required
      },
    );

    if (response.statusCode == 200) {
      // Successfully marked messages as seen
      print("Messages marked as seen successfully");
      getChats();
      notifyListeners();

      
    } else {
      // Handle error if response status code is not 200
      print("Failed to mark messages as seen: ${response.body}");
    }
  } catch (e) {
    print("Error marking messages as seen: ${e.toString()}");
  }
}

  // Future<String> getToken(String userId) async {
  //   String token = "";

  //   final url = '$serverUrl/api/consultants/' + userId;

  //   final response = await http.get(
  //     Uri.parse(url),
  //   );

  //   try {
  //     final data = json.decode(response.body) as Map<String, dynamic>;

  //     if (response.statusCode == 200) {
  //       final consultant = Consultant.fromJson(data);
  //       token = consultant.fcmtoken;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return token;
  // }
}
