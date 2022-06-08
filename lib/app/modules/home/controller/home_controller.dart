import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/exceptions/failure.dart';
import '../../../entities/project_status.dart';
import '../../../services/projects/project_service.dart';
import '../../../view_models/project_model.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProjectService _service;

  HomeController({required ProjectService service})
      : _service = service,
        super(const HomeState.initial());

  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final projects = await _service.findByStatus(state.projectStatus);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } on Failure catch (e, s) {
      log('Erro ao buscar projetos ${e.message}', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    emit(
      state.copyWith(
        status: HomeStatus.loading,
        projects: const <ProjectModel>[],
      ),
    );
    final projects = await _service.findByStatus(status);
    emit(
      state.copyWith(
        status: HomeStatus.complete,
        projects: projects,
        projectStatus: status,
      ),
    );
  }
}
