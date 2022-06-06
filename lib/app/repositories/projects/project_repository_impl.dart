import 'dart:developer';

import 'package:isar/isar.dart';

import '../../core/database/database.dart';
import '../../core/exceptions/failure.dart';
import '../../entities/project.dart';
import '../../entities/project_status.dart';
import './project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _database;

  const ProjectRepositoryImpl({required Database database})
      : _database = database;

  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _database.openConnection();

      connection.writeTxn((isar) => isar.projects.put(project));
    } on IsarError catch (e, s) {
      log('Erro ao cadastrar projeto!', error: e, stackTrace: s);
      Error.throwWithStackTrace(
        const Failure(message: 'Erro ao cadastrar projeto!'),
        s,
      );
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    final connection = await _database.openConnection();

    return await connection.projects.filter().statusEqualTo(status).findAll();
  }
}
