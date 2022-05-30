import 'dart:io' as io;

import 'package:passmanager_diplom/data/api/api_util.dart';
import 'package:passmanager_diplom/domain/model/files.dart';
import 'package:passmanager_diplom/domain/repository/crud_files_repository.dart';

class CRUDDataFilesRepository extends CRUDFilesRepository {
  final ApiUtil _apiUtil;
  CRUDDataFilesRepository(this._apiUtil);

  @override
  Future<File> create({
    required String fileName,
    required String description,
    required String login,
    required io.File file,
    required int size,
    required int userId,
  }) {
    return _apiUtil.createFile(
        userId: userId,
        fileName: fileName,
        description: description,
        login: login,
        size: size,
        file: file);
  }

  @override
  Future<bool> logicDelete({required int id}) {
   return _apiUtil.filesDelete(id: id);
  }

  @override
  Future<File> update({
    required int id,
    required String fileName,
    required String description,
    required io.File file,
    required int size,
  }) {
    return _apiUtil.updateFile(
        id: id,
        fileName: fileName,
        description: description,
        size: size,
        file: file);
  }

  @override
  Future<List<File>> index({required int userId}) {
    return _apiUtil.indexFile(userId);
  }
}
