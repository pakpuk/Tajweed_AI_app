class Message {
  final String id;
  final String sender;
  final String text;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'].toString(),
      sender: json['sender'],
      text: json['text'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
