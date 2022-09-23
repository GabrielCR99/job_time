import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../../services/projects/project_service.dart';
import '../../../../view_models/project_model.dart';
import '../../../../view_models/project_task_model.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
  late final ProjectModel _model;
  final ProjectService _service;

  TaskController({required ProjectService service})
      : _service = service,
        super(TaskStatus.initial);

  set project(ProjectModel model) => _model = model;

  Future<void> register({required String name, required int duration}) async {
    try {
      emit(TaskStatus.loading);
      final task = ProjectTaskModel(duration: duration, name: name);
      await _service.addTask(_model.id!, task);
      emit(TaskStatus.success);
    } catch (e, s) {
      log('Erro ao salvar task', error: e, stackTrace: s);
      emit(TaskStatus.failure);
    }
  }
}
