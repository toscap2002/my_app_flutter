class Message {
  final String senderId;
  final String message;

  Message({
    required this.senderId,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
    };
  }

  factory Message.fromMap(Map<dynamic, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      message: map['message'],
    );
  }
}