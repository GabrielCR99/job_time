import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/auth/auth_service.dart';

part 'login_state.dart';

final class LoginController extends Cubit<LoginState> {
  final AuthService _authService;

  LoginController({required AuthService authService})
      : _authService = authService,
        super(const LoginState.initial());

  Future<void> signIn() async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _authService.signIn();
    } catch (e) {
      log('Erro ao realizar login', error: e);
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Erro ao realizar login $e',
        ),
      );
    }
  }
}
