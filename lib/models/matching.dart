class Matching {
  late String id;
  late String clientId1;
  late String clientId2;
  late String createdAt;

  Matching({
    required this.id,
    required this.clientId1,
    required this.clientId2,
    required this.createdAt,
  });

  Matching.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    clientId1 = json['clientId1'].toString();
    clientId2 = json['clientId2'].toString();
    createdAt = json['createdAt'];
  }
}
