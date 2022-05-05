class ApiValidationNotes {
  final List<dynamic> notesName;
  final List<dynamic> content;
  final List<dynamic> description;

  ApiValidationNotes.fromApi(Map<String, dynamic> json)
      : notesName = json['notes_name'] ?? <dynamic>[],
        content = json['content'] ?? <dynamic>[],
        description = json['description'] ?? <dynamic>[];
}
