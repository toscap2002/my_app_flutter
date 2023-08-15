class Message {
  final String senderId;
  final String text;

  Message({
    required this.senderId,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
    };
  }

  factory Message.fromMap(Map<dynamic, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      text: map['text'],
    );
  }
}