import 'dart:async';

import 'package:demo_login/auth/bloc/auth_bloc.dart';
import 'package:demo_login/login/bloc/login_event.dart';
import 'package:demo_login/login/bloc/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({@required UserRepository userRepository, @required AuthBloc authBloc})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _authBloc = authBloc,
        super(const LoginState());
  AuthBloc _authBloc;
  UserRepository _userRepository;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is LoginPhoneChange) {
      yield _mapPhoneChangedToState(event, state);
    }else if(event is LoginPassChange) {
      yield _mapPassChangedToState(event, state);
    } else if(event is LoginSubmitted) {
      yield* _mapSubmittedToState(event, state);
    }
  }

  LoginState _mapPhoneChangedToState(
    LoginPhoneChange event,
    LoginState state,
  ) {
    final phone = event.phone;
    return state.copyWith(
      phone: phone,
      status: _validatePhone(phone) && _validatePass(state.pass) 
          ? LoginStatus.validated 
          : _validatePhone(phone)  ? LoginStatus.passInvalidated : LoginStatus.phoneInvalidated,
    );
  }

  LoginState _mapPassChangedToState(
    LoginPassChange event,
    LoginState state,
  ) {
    final pass = event.pass;
    return state.copyWith(
      pass: pass,
      status: _validatePhone(state.phone) && _validatePass(pass)
          ? LoginStatus.validated
          : _validatePass(pass)  ? LoginStatus.phoneInvalidated : LoginStatus.passInvalidated,
    );
  }

  Stream<LoginState> _mapSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async*{
    if(state.status ==  LoginStatus.validated) {
      yield state.copyWith(status: LoginStatus.inProgress);
      try {
        var user = await _userRepository.login(state.phone, state.pass);
        if(user!= null) {
          _authBloc.loginSuccess();
          yield state.copyWith(status: LoginStatus.done);
        } else {
          yield state.copyWith(status: LoginStatus.fail);
        }
      } on Exception catch (_) {
        yield state.copyWith(status: LoginStatus.fail);
      }
    }
  }

  bool _validatePhone(String phone) {
    if (phone.isNotEmpty && phone.length == 10) {
      return true;
    } else {
      return false;
    }
  }

  bool _validatePass(String pass) {
    if (pass.isNotEmpty && pass.length >= 6) {
      return true;
    } else {
      return false;
    }
  }
  @override
  Future<void> close() {
    _authBloc.close();
    return super.close();
  }
}
