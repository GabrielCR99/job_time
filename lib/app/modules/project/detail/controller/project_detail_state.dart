part of 'project_detail_controller.dart';

enum ProjectDetailStatus { initial, loading, completed, failure }

class ProjectDetailState extends Equatable {
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
  }) {
    return ProjectDetailState._(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [model, status];
}
