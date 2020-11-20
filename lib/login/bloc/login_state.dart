import 'package:equatable/equatable.dart';

enum LoginStatus{validated, phoneInvalidated, passInvalidated, invalidated, inProgress, fail, done}
class LoginState extends Equatable {
  final LoginStatus status;
  final String phone;
  final String pass;

  const LoginState( {this.phone = "", this.pass = "",this.status = LoginStatus.validated});

  LoginState copyWith({
    String phone,
    String pass,
    LoginStatus status,
  }) {
    return LoginState(
        phone: phone ?? this.phone,
        pass: pass ?? this.pass,
        status: status ??this.status);
  }

  @override
  List<Object> get props => [status,phone,pass];
}
