part of 'project_detail_controller.dart';

enum ProjectDetailStatus {
  initial,
  loading,
  completed,
  failure;
}

final class ProjectDetailState extends Equatable {
  final ProjectModel? model;
  final ProjectDetailStatus status;

  const ProjectDetailState._({
    required this.status,
    this.model,
  });

  const ProjectDetailState.initial()
      : this._(status: ProjectDetailStatus.initial);

  ProjectDetailState copyWith({
    ProjectModel? model,
    ProjectDetailStatus? status,
  }) =>
      ProjectDetailState._(
        status: status ?? this.status,
        model: model ?? this.model,
      );

  @override
  List<Object?> get props => [model, status];
}
