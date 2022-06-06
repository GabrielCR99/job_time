import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../../entities/project_status.dart';
import '../../../../services/projects/project_service.dart';
import '../../../../view_models/project_model.dart';
part 'project_register_state.dart';

class ProjectRegisterController extends Cubit<ProjectRegisterStatus> {
  final ProjectService _service;

  ProjectRegisterController({required ProjectService service})
      : _service = service,
        super(ProjectRegisterStatus.initial);

  Future<void> register({
    required String name,
    required int estimate,
  }) async {
    try {
      emit(ProjectRegisterStatus.loading);
      final project = ProjectModel(
        name: name,
        estimate: estimate,
        status: ProjectStatus.inProgress,
        tasks: [],
      );
      await _service.register(project);
      emit(ProjectRegisterStatus.success);
    } catch (e, s) {
      log('Erro ao salvar projeto', error: e, stackTrace: s);
      emit(ProjectRegisterStatus.failure);
    }
  }
}
