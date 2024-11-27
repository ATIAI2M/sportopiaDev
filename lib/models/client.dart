import 'dart:convert';

class Client {
  late String id;
  late String userId;
  late String token;
  late String phoneNumber;
  late String fullName;
  late int age;
  late String gender;
  late String imgUrl;
  late Map<String, String> sports;
  late List<String> items;
  late double rate;
  late List<String> language;
  late String status;
  late String verification;
  late Map<String, dynamic> position;
  late List<String> goal;
  late String frequency;
  late String club;
  late String animal;
  late String level;
  late String country;
  late String region;
  late String city;
  late String bio;
  late String instagram;
  late double height;
  late double weight;

  Client({
    required this.id,
    required this.userId,
    required this.token,
    required this.phoneNumber,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.imgUrl,
    required this.rate,
    required this.status,
    required this.verification,
    required this.position,
    required this.sports,
    required this.items,
    required this.language,
    required this.goal,
    required this.frequency,
    required this.club,
    required this.animal,
    required this.level,
    required this.country,
    required this.region,
    required this.city,
    required this.bio,
    required this.instagram,
    required this.height,
    required this.weight,
  });

  Client.fromJson(Map<String, dynamic> data) {
    id = data['id'].toString();
    userId = data['userId'].toString();
    token = data['token'];
    phoneNumber = data['phoneNumber'];
    fullName = data['fullName'];
    age = int.parse(data['age'].toString());
    gender = data['gender'];
    imgUrl = data['imgurl'];
    rate = double.parse(data['rate'].toString());
    status = data['status'];
    verification = data['verification'];
    position = data['position'];
    sports = _parseMapFromKeyValueString(data['sports']
        .toString()
        .substring(1, data['sports'].toString().length - 1));
    var itemsData = data['items'];
    if (itemsData is String) {
      items = itemsData
          .substring(1, itemsData.length - 1)
          .split(',')
          .map((item) => item.trim())
          .toList();
    } else {
      items = [];
    }

    var languageData = data['language'];
    if (languageData is String) {
      language = languageData
          .substring(1, languageData.length - 1)
          .split(',')
          .map((lang) => lang.trim())
          .toList();
    } else {
      language = [];
    }

    var goalsData = data['goal'];
    if (goalsData is String) {
      goal = goalsData
          .substring(1, goalsData.length - 1)
          .split(',')
          .map((g) => g.trim())
          .toList();
    } else {
      goal = [];
    }
    frequency = data['frequency'] ?? '';
    club = data['club'] ?? '';
    animal = data['animal'] ?? '';
    level = data['level'] ?? '';
    country = data['country'] ?? '';
    region = data['region'] ?? '';
    city = data['city'] ?? '';
    bio = data['bio'] ?? '';
    instagram = data['instagram'] ?? '';
    height = double.parse(data['height'].toString());
    weight = double.parse(data['weight'].toString());
  }

  Map<String, String> _parseMapFromKeyValueString(String data) {
    if (data is String) {
      final map = <String, String>{};
      for (var item in data.split(',')) {
        final parts = item.trim().split(':'); // Split by colon, trim spaces
        if (parts.length == 2) {
          map[parts[0]] = parts[1]; // Add key-value pair
        } else {
          print(
              'Invalid entry in sports data: $item'); // Handle invalid entries
        }
      }
      return map;
    } else {
      return {}; // Empty map by default
    }
  }

  Map<String, String> _parseMapFromString(dynamic data) {
    if (data is String) {
      try {
        final mapData = jsonDecode(data);
        if (mapData is Map<String, dynamic>) {
          return mapData.cast<String, String>();
        } else {
          print('Invalid JSON format for sports data');
          return {};
        }
      } catch (e) {
        if (e is FormatException &&
            e.message.startsWith('Unexpected character')) {
          print('Invalid character in sports data: ${e.message}');
          return {};
        } else {
          print('Error parsing sports data: $e');
          return {};
        }
      }
    } else if (data is Map) {
      return data.cast<String, String>();
    } else {
      return {};
    }
  }
}
