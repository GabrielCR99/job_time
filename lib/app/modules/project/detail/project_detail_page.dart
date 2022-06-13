import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:asuka/asuka.dart' as asuka;

import 'controller/project_detail_controller.dart';
import 'widgets/loaded_project_page.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final _controller = Modular.get<ProjectDetailController>();

  @override
  void initState() {
    super.initState();
    _controller.setProject(Modular.args.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
        bloc: _controller,
        listener: (_, state) => state.status == ProjectDetailStatus.failure
            ? AsukaSnackbar.alert('Erro interno')
            : null,
        builder: (_, state) {
          final projectModel = state.model;

          switch (state.status) {
            case ProjectDetailStatus.initial:
              return const Center(child: Text('Carregando projeto'));
            case ProjectDetailStatus.loading:
              return const Center(child: CircularProgressIndicator.adaptive());
            case ProjectDetailStatus.completed:
              final totalTasks = projectModel?.tasks.fold<int>(
                0,
                (totalValue, task) => (totalValue += task.duration),
              );
              return LoadedProjectPage(
                totalTasks: totalTasks!,
                projectModel: projectModel!,
                onPressed: _confirmFinish,
              );
            case ProjectDetailStatus.failure:
              if (projectModel != null) {
                final totalTasks = projectModel.tasks.fold<int>(
                  0,
                  (totalValue, task) => (totalValue += task.duration),
                );

                return LoadedProjectPage(
                  totalTasks: totalTasks,
                  projectModel: projectModel,
                  onPressed: _confirmFinish,
                );
              }
          }

          return const Center(child: Text('Erro ao carregar projeto'));
        },
      ),
    );
  }

  void _confirmFinish() => asuka.showDialog(
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
