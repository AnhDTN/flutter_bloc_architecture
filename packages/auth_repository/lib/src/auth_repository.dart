import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

enum AuthStatus {unknown, authenticated, unauthenticated}
class AuthRepository  {
  final _controller = StreamController<AuthStatus>();
  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unknown;
    yield* _controller.stream;
  }

  Future<User> checkAuth() async{
      UserRepository userRepository = UserRepository();
      var user = await userRepository.getUserStorage();
      if(user!= null) {
        await Future.delayed(const Duration(milliseconds: 300), ()=> _controller.add(AuthStatus.authenticated));
      }
      return user;
  }

  Future<void> loginSuccess() async{
    await Future.delayed(const Duration(milliseconds: 300), ()=> _controller.add(AuthStatus.authenticated));
  }

  void logout() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
    } catch(_) {
        print("remove user fail");
    }
    await Future.delayed(const Duration(milliseconds: 300), ()=> _controller.add(AuthStatus.unauthenticated));
  }

  void dispose() => _controller.close();

}