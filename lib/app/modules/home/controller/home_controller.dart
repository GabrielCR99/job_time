import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/exceptions/failure.dart';
import '../../../entities/project_status.dart';
import '../../../services/auth/auth_service.dart';
import '../../../services/projects/project_service.dart';
import '../../../view_models/project_model.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProjectService _service;
  final AuthService _authService;

  HomeController({
    required ProjectService service,
    required AuthService authService,
  })  : _service = service,
        _authService = authService,
        super(const HomeState.initial());

  var _projectStatus = ProjectStatus.inProgress;

  ProjectStatus get projectStatus => _projectStatus;

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
    _projectStatus = status;
    final projects = await _service.findByStatus(status);
    emit(
      state.copyWith(
        status: HomeStatus.complete,
        projects: projects,
        projectStatus: status,
      ),
    );
  }

  Future<void> updateList() => filter(state.projectStatus);

  Future<void> logout() => _authService.signOut();
}
