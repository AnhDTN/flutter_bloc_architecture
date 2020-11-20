import 'package:equatable/equatable.dart';

import 'package:auth_repository/auth_repository.dart';
import 'package:user_repository/user_repository.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final User user;

  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user = User.empty,
  });
  @override
  List<Object> get props => [status, user];

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user)
      : this._(status : AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);
}