import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/projects/project_service.dart';
import '../../../../view_models/project_model.dart';
import '../../../../view_models/project_task_model.dart';

part 'task_state.dart';

final class TaskController extends Cubit<TaskStatus> {
  late final ProjectModel project;
  final ProjectService _service;

  TaskController(this._service) : super(TaskStatus.initial);

  Future<void> register({required String name, required int duration}) async {
    try {
      emit(TaskStatus.loading);
      final task = ProjectTaskModel(duration: duration, name: name);
      await _service.addTask(project.id!, task);
      emit(TaskStatus.success);
    } catch (e, s) {
      log('Erro ao salvar task', error: e, stackTrace: s);
      emit(TaskStatus.failure);
    }
  }
}
