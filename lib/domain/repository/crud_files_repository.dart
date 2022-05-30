import 'dart:io' as io;

import 'package:passmanager_diplom/domain/model/files.dart';

abstract class CRUDFilesRepository {
  Future<File> create({
    required String fileName,
    required String description,
    required String login,
    required io.File file,
    required int size,
    required int userId,
  });
  Future<File> update({
    required int id,
    required String fileName,
    required String description,
    required io.File file,
    required int size,
  });
  Future<List<File>> index({required int userId});
  Future<bool> logicDelete({required int id});
}
