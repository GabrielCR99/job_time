import 'dart:developer';

import 'package:isar/isar.dart';

import '../../core/database/database.dart';
import '../../core/exceptions/failure.dart';
import '../../entities/project.dart';
import '../../entities/project_status.dart';
import '../../entities/project_task.dart';
import 'project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _database;

  const ProjectRepositoryImpl({required Database database})
      : _database = database;

  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _database.openConnection();

      await connection.writeTxn(
        () async => project.id = await connection.projects.put(project),
      );
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
    try {
      final connection = await _database.openConnection();

      return await connection.projects.filter().statusEqualTo(status).findAll();
    } catch (e, s) {
      log('Erro ao buscar projetos!', error: e, stackTrace: s);
      Error.throwWithStackTrace(
        Failure(message: 'Erro ao buscar projetos $e'),
        s,
      );
    }
  }

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    try {
      final connection = await _database.openConnection();

      final project = await findById(projectId);

      project.tasks.add(task);
      await connection
          .writeTxn(() async => await connection.projectTasks.put(task));

      await connection.writeTxn(() async => await project.tasks.save());

      return project;
    } on IsarError catch (e, s) {
      log('Erro ao cadastrar task!', error: e, stackTrace: s);
      Error.throwWithStackTrace(
        const Failure(message: 'Error creating task!'),
        s,
      );
    }
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _database.openConnection();
    final project = await connection.projects.get(projectId);
    if (project == null) {
      throw const Failure(message: 'Error finding project!');
    }

    return project;
  }

  @override
  Future<void> finish(int projectId) async {
    try {
      final connection = await _database.openConnection();
      final project = await findById(projectId);
      project.status = ProjectStatus.finished;
      await connection.writeTxn(
        () async => await connection.projects.put(project),
      );
    } on IsarError catch (e, s) {
      log('Erro ao finalizar projeto', error: e, stackTrace: s);
      Error.throwWithStackTrace(
        const Failure(message: 'Erro ao finalizar projeto'),
        s,
      );
    }
  }
}
