import 'package:passmanager_diplom/domain/model/validation_notes.dart';

class Notes {
  final int id;
  final String notesName;
  final String content;
  final String description;
  final DateTime createAt;
  final bool isCreator;
  final int userId;
  final ValidationNotes? validationNotes;

  Notes({
    required this.id,
    required this.notesName,
    required this.content,
    required this.description,
    required this.createAt,
    required this.isCreator,
    required this.userId,
    this.validationNotes,
  });
}
