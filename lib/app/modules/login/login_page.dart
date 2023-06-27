import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller;

  const LoginPage({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return BlocListener<LoginController, LoginState>(
      listener: (_, state) =>
          AsukaSnackbar.alert(state.errorMessage ?? 'Erro ao realizar login')
              .show(),
      bloc: controller,
      listenWhen: (_, current) => current.status == LoginStatus.failure,
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0092B9), Color(0xFF0167B2)],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                SizedBox(height: screenSize.height * 0.1),
                SizedBox(
                  width: screenSize.width * 0.8,
                  height: 49,
                  child: ElevatedButton(
                    onPressed: controller.signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    child: Image.asset('assets/images/google.png'),
                  ),
                ),
                BlocSelector<LoginController, LoginState, bool>(
                  selector: (state) => state.status == LoginStatus.loading,
                  builder: (_, show) => Visibility(
                    visible: show,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  bloc: controller,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
