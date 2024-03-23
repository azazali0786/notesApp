class Note {
  String? id;
  String? userId;
  String? title;
  String? content;
  DateTime? dateadded;
  Note({
    this.id,
    this.userId,
    this.title,
    this.content,
    this.dateadded,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'dateadded': dateadded!.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      dateadded: DateTime.tryParse(map["dateadded"]),
    );
  }

}
