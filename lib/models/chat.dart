class Chat {
  late String id;
  late String senderId;
  late String receiverId;
  late String updatedAt;
  late String createdAt;
  String? lastReceivedMessage; // Nullable since there may be no messages
  String? lastReceivedMessageTime; // Nullable to handle chats with no messages
  int unseenCount = 0; // Default to 0

  Chat({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.updatedAt,
    required this.createdAt,
    this.lastReceivedMessage,
    this.lastReceivedMessageTime,
    this.unseenCount = 0,
  });

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    senderId = json['senderId'].toString();
    // senderId = json['participants']['senderId'].toString();
    receiverId = json['receiverId'].toString();
    // receiverId = json['participants']['receiverId'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
    lastReceivedMessage = json['lastReceivedMessage']?.toString() ?? "hhh"; // Use null-aware operator
    lastReceivedMessageTime = json['lastReceivedMessageTime']?.toString();
    unseenCount = json['unseenCount'] ?? 0; // Default to 0 if not present
  }
}
