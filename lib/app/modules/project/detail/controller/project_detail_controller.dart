import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/projects/project_service.dart';
import '../../../../view_models/project_model.dart';

part 'project_detail_state.dart';

final class ProjectDetailController extends Cubit<ProjectDetailState> {
  final ProjectService _service;

  ProjectDetailController({required ProjectService service})
      : _service = service,
        super(const ProjectDetailState.initial());

  void setProject(ProjectModel model) =>
      emit(state.copyWith(model: model, status: ProjectDetailStatus.completed));

  Future<void> updateProject() async {
    final project = await _service.findById(state.model!.id!);
    emit(state.copyWith(model: project, status: ProjectDetailStatus.completed));
  }

  Future<void> finishProject() async {
    try {
      emit(state.copyWith(status: ProjectDetailStatus.loading));
      final projectId = state.model!.id!;
      await _service.finish(projectId);
      updateProject();
    } catch (e) {
      emit(state.copyWith(status: ProjectDetailStatus.failure));
    }
  }
}
