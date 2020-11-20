import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginPhoneChange extends LoginEvent {
  final String phone;
  const LoginPhoneChange(this.phone);
  @override
  List<Object> get props => [phone];
}

class LoginPassChange extends LoginEvent {
  final String pass;
  LoginPassChange(this.pass);

  @override
  List<Object> get props => [pass];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}