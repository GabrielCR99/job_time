import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../view_models/project_model.dart';
import 'controller/home_controller.dart';
import 'widgets/header_projects_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final _controller = Modular.get<HomeController>()..loadProjects();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      bloc: _controller,
      listener: _showError,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Drawer(
          child: SafeArea(
            child: ListTile(
              title: Text('Sair'),
            ),
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Projetos'),
                expandedHeight: 100,
                toolbarHeight: 100,
                centerTitle: true,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
              ),
              SliverPersistentHeader(
                delegate: HeaderProjectsMenu(),
                pinned: true,
              ),
              BlocSelector<HomeController, HomeState, bool>(
                bloc: _controller,
                selector: (state) => state.status == HomeStatus.loading,
                builder: (_, showLoader) => SliverVisibility(
                  visible: showLoader,
                  sliver: const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  ),
                ),
              ),
              BlocSelector<HomeController, HomeState, List<ProjectModel>>(
                bloc: _controller,
                selector: (state) => state.projects,
                builder: (_, projects) {
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      projects
                          .map(
                            (e) => ListTile(
                              title: Text(e.name),
                              subtitle: Text('${e.estimate} horas'),
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showError(_, state) {
    if (state.status == HomeStatus.failure) {
      AsukaSnackbar.alert('Erro ao buscar projetos').show();
    }
  }
}
