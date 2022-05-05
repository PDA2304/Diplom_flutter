class RequestNotesUpdate {
  final String? notesName;
  final String? content;
  final String? description;

  RequestNotesUpdate({
    required this.notesName,
    required this.content,
    required this.description,
  });

  Map<String, dynamic> toApi() {
    return {
      'notes_name': notesName,
      'content': content,
      'description': description
    };
  }
}
