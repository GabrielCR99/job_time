import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static final _controller = Modular.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocListener<LoginController, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _showLoginError,
      bloc: _controller,
      child: Scaffold(
        appBar: AppBar(title: const Text('')),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0092B9),
                Color(0xFF0167B2),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                SizedBox(height: screenSize.height * 0.1),
                SizedBox(
                  height: 49,
                  width: screenSize.width * 0.8,
                  child: ElevatedButton(
                    onPressed: _controller.signIn,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[200],
                    ),
                    child: Image.asset('assets/images/google.png'),
                  ),
                ),
                BlocSelector<LoginController, LoginState, bool>(
                  bloc: _controller,
                  selector: (state) => state.status == LoginStatus.loading,
                  builder: (_, show) => Visibility(
                    visible: show,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLoginError(BuildContext _, LoginState state) {
    if (state.status == LoginStatus.failure) {
      final message = state.errorMessage ?? 'Erro ao realizar login';
      AsukaSnackbar.alert(message).show();
    }
  }
}
