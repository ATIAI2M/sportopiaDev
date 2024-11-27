import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testapp/models/chat.dart';
import 'package:testapp/models/client.dart';

class ChatUtils {
  final String serverUrl;
  final String accessToken;

  ChatUtils({required this.serverUrl, required this.accessToken});

  Future<List<Chat>> fetchChats(String clientId) async {
    final url = '$serverUrl/api/chats/$clientId';

    final response = await http.get(Uri.parse(url), headers: {
      "x-access-token": accessToken,
    });

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        return data.map((element) => Chat.fromJson(element)).toList();
      } else {
        print('Failed to fetch chats: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error parsing chats: $e');
      return [];
    }
  }

  Future<List<Client>> fetchChatClients(String clientId) async {
    final url = '$serverUrl/api/chats/clients/$clientId';

    final response = await http.get(Uri.parse(url), headers: {
      "x-access-token": accessToken,
    });

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        return data.map((element) => Client.fromJson(element)).toList();
      } else {
        print('Failed to fetch chat clients: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error parsing chat clients: $e');
      return [];
    }
  }
}
