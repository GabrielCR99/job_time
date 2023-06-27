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
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      listener: (_, state) => switch (state) {
        ProjectRegisterStatus.success => Navigator.pop(context),
        ProjectRegisterStatus.failure =>
          AsukaSnackbar.alert('Erro ao salvar projeto').show(),
        ProjectRegisterStatus.loading || ProjectRegisterStatus.initial => null,
      },
      bloc: _controller,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Criar novo projeto',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
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
                decoration: const InputDecoration(
                  label: Text('Estimativa de horas'),
                ),
                keyboardType: TextInputType.number,
                validator: Validatorless.multiple([
                  Validatorless.required('Estimativa obrigatória!'),
                  Validatorless.number('Deve conter somente números'),
                ]),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 49,
                child: LoadingButton<ProjectRegisterController,
                    ProjectRegisterStatus>(
                  onPressed: _registerTask,
                  label: 'Salvar',
                  selector: (state) => state == ProjectRegisterStatus.loading,
                  bloc: _controller,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _estimateEC.dispose();
    super.dispose();
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
