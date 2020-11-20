import 'dart:async';

import 'package:demo_login/auth/bloc/auth_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {@required AuthRepository authRepository,
      @required UserRepository userRepository})
      : assert(authRepository != null),
        assert(userRepository != null),
        _authRepository = authRepository,
        _userRepository = userRepository,
        super(AuthState.unknown()) {
    _authStatusSubcription =
        _authRepository.status.listen((event) => add(AuthStatusChange(event)));
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  StreamSubscription<AuthStatus> _authStatusSubcription;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthStatusChange) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthLogoutRequested) {
      _authRepository.logout();
    }
  }

  Future<AuthState> _mapAuthenticationStatusChangedToState(
    AuthStatusChange event,
  ) async {
    switch (event.status) {
      case AuthStatus.unknown:
        final user = await _authRepository.checkAuth();
        return user != null
            ? AuthState.authenticated(user)
            : const AuthState.unauthenticated();
      case AuthStatus.unauthenticated:
        return const AuthState.unauthenticated();
      case AuthStatus.authenticated:
        final user = await _authRepository.checkAuth();
        return user != null
            ? AuthState.authenticated(user)
            : const AuthState.unauthenticated();
      default:
        return const AuthState.unknown();
    }
  }

  void loginSuccess() {
    _authRepository.loginSuccess();
  }

  @override
  Future<void> close() {
    _authStatusSubcription?.cancel();
    _authRepository?.dispose();
    return super.close();
  }
}
