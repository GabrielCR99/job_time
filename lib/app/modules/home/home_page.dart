import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../view_models/project_model.dart';
import 'controller/home_controller.dart';
import 'widgets/header_projects_menu.dart';
import 'widgets/project_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final _controller = Modular.get<HomeController>()..loadProjects();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      listener: _showError,
      bloc: _controller,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            scrollBehavior:
                const MaterialScrollBehavior().copyWith(overscroll: false),
            cacheExtent: 4 * 100,
            slivers: [
              const SliverAppBar(
                title: Text('Projetos'),
                centerTitle: true,
                expandedHeight: 100,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                toolbarHeight: 100,
              ),
              SliverPersistentHeader(
                delegate: HeaderProjectsMenu(),
                pinned: true,
              ),
              BlocSelector<HomeController, HomeState, bool>(
                selector: (state) => state.status == HomeStatus.loading,
                builder: (_, showLoader) => SliverVisibility(
                  sliver: const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  ),
                  visible: showLoader,
                ),
                bloc: _controller,
              ),
              BlocSelector<HomeController, HomeState, List<ProjectModel>>(
                selector: (state) => state.projects,
                builder: (_, projects) => SliverList(
                  delegate: SliverChildListDelegate(
                    projects
                        .map((project) => ProjectTile(projectModel: project))
                        .toList(),
                  ),
                ),
                bloc: _controller,
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: ListTile(
              title: const Text('Sair'),
              onTap: _controller.logout,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  void _showError(BuildContext _, HomeState state) {
    if (state.status == HomeStatus.failure) {
      AsukaSnackbar.alert('Erro ao buscar projetos').show();
    }
  }
}
