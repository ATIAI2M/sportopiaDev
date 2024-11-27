class Message {
  late String id;
  late String text;
  late String senderId;
  late String receiverId;
  late String chatId;

  Message({
    required this.id,
    required this.text,
    required this.senderId,
    required this.receiverId,
    required this.chatId,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    text = json['text'];
    senderId = json['senderId'].toString();
    receiverId = json['receiverId'].toString();
    chatId = json['chatId'].toString();
  }
}
