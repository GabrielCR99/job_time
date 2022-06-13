import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../entities/project_status.dart';
import '../../../../view_models/project_model.dart';
import '../controller/project_detail_controller.dart';

class ProjectDetailAppbar extends SliverAppBar {
  ProjectDetailAppbar({
    required ProjectModel model,
    super.expandedHeight = 100,
    super.pinned = true,
    super.toolbarHeight = 100,
    super.centerTitle = true,
    super.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
    ),
    super.key,
  }) : super(
          title: Text(model.name),
          flexibleSpace: Stack(
            children: [
              Align(
                alignment: const Alignment(0, 1.8),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    elevation: 2,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${model.tasks.length} tasks'),
                          Visibility(
                            visible: model.status != ProjectStatus.finished,
                            replacement: const Text('Projeto finalizado'),
                            child: _NewTasks(model: model),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
}

class _NewTasks extends StatelessWidget {
  final ProjectModel model;

  const _NewTasks({required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await _getAllProjectTasks(),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Text('Adicionar task'),
        ],
      ),
    );
  }

  Future<void> _getAllProjectTasks() async {
    await Modular.to.pushNamed('/project/task/', arguments: model);
    await Modular.get<ProjectDetailController>().updateProject();
  }
}
