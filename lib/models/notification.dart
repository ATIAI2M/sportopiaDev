class Notif {
  late String id;
  late String clientId;
  late String title;
  late String body;
  late String createdAt;

  Notif({
    required this.id,
    required this.clientId,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  Notif.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    clientId = json['clientId'].toString();
    title = json['title'];
    body = json['body'];
    createdAt = json['createdAt'];
  }
}
