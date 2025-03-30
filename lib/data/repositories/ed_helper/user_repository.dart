import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ed_helper_web/data/models/user/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final String API_URL = dotenv.env['api_url'] ?? '';
  final Dio dio = Dio(BaseOptions(
    validateStatus: (status) {
      return true;
    },
  ));

  Future<UserModel?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");
    Response response = await dio.get("${API_URL}/v1/users/me",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken"
        }));

    // Теперь можно использовать UserModel.fromJson
    return UserModel.fromJson(response.data);
  }

  Future<Response> updateUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");
    return await dio.put("${API_URL}/v1/users/update",
        data: jsonEncode(user),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken"
        }));
  }

  Future<Response> deleteUser(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");
    return await dio.delete("${API_URL}/v1/users/?id=$id",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken"
        }));
  }
}
