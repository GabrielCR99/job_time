import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/loading_button.dart';
import 'controller/project_register_controller.dart';

class ProjectRegisterPage extends StatefulWidget {
  const ProjectRegisterPage({super.key});

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _estimateEC = TextEditingController();
  final _controller = Modular.get<ProjectRegisterController>();

  @override
  void dispose() {
    _nameEC.dispose();
    _estimateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: _controller,
      listener: _projectListener,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: const Text(
            'Criar novo projeto',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _nameEC,
                decoration:
                    const InputDecoration(label: Text('Nome do projeto')),
                validator: Validatorless.required('Nome obrigatório'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _estimateEC,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: Validatorless.multiple([
                  Validatorless.required('Estimativa obrigatória!'),
                  Validatorless.number('Deve conter somente números'),
                ]),
                decoration:
                    const InputDecoration(label: Text('Estimativa de horas')),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 49,
                child: LoadingButton<ProjectRegisterController,
                    ProjectRegisterStatus>(
                  onPressed: _registerTask,
                  label: 'Salvar',
                  bloc: _controller,
                  selector: (state) => state == ProjectRegisterStatus.loading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _projectListener(BuildContext context, ProjectRegisterStatus state) {
    switch (state) {
      case ProjectRegisterStatus.success:
        Navigator.pop(context);
        break;
      case ProjectRegisterStatus.failure:
        AsukaSnackbar.alert('Erro ao salvar projeto').show();
        break;
      case ProjectRegisterStatus.loading:
      case ProjectRegisterStatus.initial:
        break;
    }
  }

  void _registerTask() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      _controller.register(
        name: _nameEC.text,
        estimate: int.parse(_estimateEC.text),
      );
    }
  }
}
