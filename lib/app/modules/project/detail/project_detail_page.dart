import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../view_models/project_model.dart';
import 'controller/project_detail_controller.dart';
import 'widgets/loaded_project_page.dart';

class ProjectDetailPage extends StatelessWidget {
  ProjectDetailPage({super.key});

  final _controller = Modular.get<ProjectDetailController>()
    ..setProject(Modular.args.data as ProjectModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
        builder: (_, state) {
          final projectModel = state.model;
          switch (state.status) {
            case ProjectDetailStatus.initial:
              return const Center(child: Text('Carregando projeto'));
            case ProjectDetailStatus.loading:
              return const Center(child: CircularProgressIndicator.adaptive());
            case ProjectDetailStatus.completed || ProjectDetailStatus.failure:
              if (projectModel != null) {
                final totalTasks = projectModel.tasks.fold<int>(
                  0,
                  (totalValue, task) => totalValue += task.duration,
                );

                return LoadedProjectPage(
                  projectModel: projectModel,
                  totalTasks: totalTasks,
                  onPressed: _confirmFinish,
                );
              }
          }

          return const Center(child: Text('Erro ao carregar projeto'));
        },
        listener: (_, state) => state.status == ProjectDetailStatus.failure
            ? AsukaSnackbar.alert('Erro interno')
            : null,
        bloc: _controller,
      ),
    );
  }

  void _confirmFinish() => Asuka.showDialog<void>(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (context) => AlertDialog(
          title: const Text('Deseja finalizar esse projeto?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => _onPressedConfirmFinish(context),
              child:
                  const Text('Confirmar', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );

  void _onPressedConfirmFinish(BuildContext context) {
    Navigator.pop(context);
    _controller.finishProject();
  }
}
