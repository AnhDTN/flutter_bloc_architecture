
import 'package:user_repository/src/model/user.dart';

import '../data_provider.dart';

class LoginRepository{
  LoginProvider _loginProvider = LoginProvider();
  Future<User> loginResponse(String phone,String pass) {
      var user = _loginProvider.login(phone, pass);
      return user;
  }
}