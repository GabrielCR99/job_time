import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../entities/project_status.dart';
import '../controller/home_controller.dart';

class HeaderProjectsMenu extends SliverPersistentHeaderDelegate {
  final _controller = Modular.get<HomeController>();

  final _dropdownBorderRadius = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  );

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return LayoutBuilder(
      builder: (_, constraints) => Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        height: constraints.maxHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.5,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: DropdownButtonFormField<ProjectStatus>(
                  items: ProjectStatus.values
                      .map(
                        (e) => DropdownMenuItem(value: e, child: Text(e.label)),
                      )
                      .toList(),
                  value: ProjectStatus.inProgress,
                  onChanged: (status) {
                    if (status != null) {
                      _controller.filter(status);
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    focusedBorder: _dropdownBorderRadius,
                    enabledBorder: _dropdownBorderRadius,
                    border: _dropdownBorderRadius,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            BlocSelector<HomeController, HomeState, bool>(
              selector: (state) =>
                  state.projectStatus == ProjectStatus.inProgress,
              builder: (_, visible) => Visibility(
                replacement: const Spacer(),
                visible: visible,
                child: SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await Modular.to.pushNamed('/project/register/');
                      _controller.loadProjects();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Novo projeto'),
                  ),
                ),
              ),
              bloc: _controller,
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
