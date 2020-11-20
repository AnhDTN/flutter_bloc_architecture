import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/src/model/user.dart';

import 'data_layer/data_provider.dart';

class UserRepository {
  User _user;
  LoginProvider _loginProvider = LoginProvider();
  Future<User> login(String phone, String pass) async {
    _user = await _loginProvider.login(phone, pass);
    if(_user!= null) {
      try{
        await _saveUserToStorage(_user);
      }catch(_){
          print("Save to storage fail");
      }
      return _user;
    }
    return null;
  }

  getUserStorage() async {
    User user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('user') != null ) {
      user = User.fromJson(jsonDecode(prefs.getString('user')));
    }
    return user ?? null;
  }

  _saveUserToStorage(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = user.toJson();
    await prefs.setString('user', json.encode(data));
  }
}
