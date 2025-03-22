import 'package:dio/dio.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/gpt_answer/auth/auth_model.dart';
import '../repositories/device_repository.dart';

class UserService {
  final DeviceRepository _deviceRepository = DeviceRepository();
  final AuthRepository _authRepository = AuthRepository();

  Future<String> newUserWithIp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response;
    String userIp = await _deviceRepository.getDeviceIp();
    print(userIp);
    if (userIp == "") throw "Cannot retrieve IP Address";
    AuthModel newUser =
        AuthModel(email: "$userIp@edhelper.ai", password: userIp);
    response = await _authRepository.signUp(newUser);
    print(response.statusCode);
    if (response.statusCode != 200) {
      response = await _authRepository.signIn(newUser);
    }
    String authToken = response.data;
    prefs.setString("token", authToken);
    prefs.setBool("notAuth", true);
    return authToken;
  }
}
