class User {
  late String id;
  late String email;
  late String roles;
  late String accessToken;

  User({
    required this.id,
    required this.email,
    required this.roles,
    required this.accessToken,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    email = json['email'];
    roles = json['roles'].toString();
    accessToken = json['accessToken'];
  }
}
