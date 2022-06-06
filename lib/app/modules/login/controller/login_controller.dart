import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../services/auth/auth_service.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthService _authService;

  LoginController({required AuthService authService})
      : _authService = authService,
        super(const LoginState.initial());

  Future<void> signIn() async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await _authService.signIn();
    } catch (e) {
      log('Erro ao login');
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Erro ao realizar login $e',
        ),
      );
    }
  }
}
