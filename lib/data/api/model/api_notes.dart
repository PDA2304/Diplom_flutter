import 'package:passmanager_diplom/data/api/model/api_validation_notes.dart';

class ApiNotes {
  final int? id;
  final String? notesName;
  final String? content;
  final String? description;
  final String? createAt;
  final bool? isCreator;
  final int? userId;
  final ApiValidationNotes? apiValidationNotes;

  ApiNotes.fromApi(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        notesName = json['notes_name'] ?? '',
        content = json['content'] ?? '',
        description = json['description'] ?? '',
        createAt = json['created_at'] ?? DateTime.now().toIso8601String(),
        isCreator = json['creator'] ?? true,
        userId = json['user_id'] ?? 0,
        apiValidationNotes = json['error'] == null
            ? null
            : ApiValidationNotes.fromApi(json['error']);
}
