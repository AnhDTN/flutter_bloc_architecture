import 'package:dio/dio.dart';
import 'package:user_repository/src/model/user.dart';

import '../api/Api.dart';

class LoginProvider{
    Future<User> login(String phone,String pass) async{
        try{
            var body = {
                "user_id": phone,
                "password": pass,
                "type": "driver"
            };
            var response = await Dio().post(Api.loginUrl,data: body);
            return User.fromJson(response.data["data"]);
        } catch(_) {
            print("Exception");
        }
        return null;
    }
}