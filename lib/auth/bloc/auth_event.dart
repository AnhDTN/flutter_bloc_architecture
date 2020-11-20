import 'package:equatable/equatable.dart';

import 'package:auth_repository/auth_repository.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AuthStatusChange extends AuthEvent {
  final AuthStatus status;
  AuthStatusChange(this.status);
  @override
  List<Object> get props => [status];
}

class AuthLogoutRequested extends AuthEvent {
}
