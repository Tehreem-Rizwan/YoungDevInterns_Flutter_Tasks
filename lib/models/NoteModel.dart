class Note {
  String id;
  String bookTitle;
  String content;
  DateTime timestamp;

  Note({
    required this.id,
    required this.bookTitle,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookTitle': bookTitle,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      bookTitle: map['bookTitle'],
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
