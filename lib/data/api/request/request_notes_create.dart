class RequestNotesCreate {
  final String? notesName;
  final String? content;
  final String? description;
  final int? userId;

  RequestNotesCreate({
    required this.notesName,
    required this.content,
    required this.description,
    required this.userId,
  });

  Map<String, dynamic> toApi() {
    return {
      'user_id': userId,
      'notes_name': notesName,
      'content': content,
      'description': description
    };
  }
}
