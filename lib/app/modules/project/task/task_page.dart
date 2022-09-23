import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/loading_button.dart';
import '../../../view_models/project_model.dart';
import 'controller/task_controller.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _controller = Modular.get<TaskController>();
  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.project = Modular.args.data as ProjectModel;
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _durationEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: _controller,
      listener: _taskListener,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Criar nova task',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              BlocSelector<TaskController, TaskStatus, bool>(
                bloc: _controller,
                selector: (state) => state != TaskStatus.loading,
                builder: (_, enabled) => TextFormField(
                  enabled: enabled,
                  decoration:
                      const InputDecoration(label: Text('Nome da task')),
                  controller: _nameEC,
                  validator: Validatorless.required('Nome obrigatório'),
                ),
              ),
              const SizedBox(height: 10),
              BlocSelector<TaskController, TaskStatus, bool>(
                selector: (state) => state != TaskStatus.loading,
                bloc: _controller,
                builder: (_, enabled) => TextFormField(
                  enabled: enabled,
                  decoration:
                      const InputDecoration(label: Text('Duração da task')),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  controller: _durationEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Duração obrigatória'),
                    Validatorless.required('Somente números'),
                  ]),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 49,
                child: LoadingButton<TaskController, TaskStatus>(
                  bloc: _controller,
                  label: 'Salvar',
                  selector: (state) => state == TaskStatus.loading,
                  onPressed: _saveTask,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTask() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      _controller.register(
        name: _nameEC.text,
        duration: int.parse(_durationEC.text),
      );
    }
  }

  void _taskListener(BuildContext context, TaskStatus state) {
    if (state == TaskStatus.success) {
      Navigator.pop(context);
    } else if (state == TaskStatus.failure) {
      AsukaSnackbar.alert('Erro ao salvar task').show();
    }
  }
}
