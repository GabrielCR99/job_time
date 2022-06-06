part of 'home_controller.dart';

enum HomeStatus {
  inital,
  loading,
  complete,
  failure;
}

class HomeState extends Equatable {
  final List<ProjectModel> projects;
  final HomeStatus status;
  final ProjectStatus projectStatus;

  const HomeState._({
    required this.projects,
    required this.status,
    required this.projectStatus,
  });

  const HomeState.initial()
      : this._(
          projects: const [],
          status: HomeStatus.inital,
          projectStatus: ProjectStatus.inProgress,
        );

  @override
  List<Object?> get props => [projectStatus, projects, status];

  HomeState copyWith({
    List<ProjectModel>? projects,
    HomeStatus? status,
    ProjectStatus? projectStatus,
  }) {
    return HomeState._(
      projects: projects ?? this.projects,
      status: status ?? this.status,
      projectStatus: projectStatus ?? this.projectStatus,
    );
  }
}
