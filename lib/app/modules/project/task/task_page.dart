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
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      listener: _taskListener,
      bloc: _controller,
      listenWhen: (_, current) =>
          current == TaskStatus.success || current == TaskStatus.failure,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Criar nova task',
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
              BlocSelector<TaskController, TaskStatus, bool>(
                selector: (state) => state != TaskStatus.loading,
                builder: (_, enabled) => TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome da task'),
                  ),
                  validator: Validatorless.required('Nome obrigatório'),
                  enabled: enabled,
                ),
                bloc: _controller,
              ),
              const SizedBox(height: 10),
              BlocSelector<TaskController, TaskStatus, bool>(
                selector: (state) => state != TaskStatus.loading,
                builder: (_, enabled) => TextFormField(
                  controller: _durationEC,
                  decoration: const InputDecoration(
                    label: Text('Duração da task'),
                  ),
                  keyboardType: TextInputType.number,
                  validator: Validatorless.multiple([
                    Validatorless.required('Duração obrigatória'),
                    Validatorless.required('Somente números'),
                  ]),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  enabled: enabled,
                ),
                bloc: _controller,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 49,
                child: LoadingButton<TaskController, TaskStatus>(
                  onPressed: _saveTask,
                  label: 'Salvar',
                  selector: (state) => state == TaskStatus.loading,
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
    _durationEC.dispose();
    super.dispose();
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
