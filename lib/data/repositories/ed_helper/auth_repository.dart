import 'package:dio/dio.dart';
import 'package:ed_helper_web/data/models/gpt_answer/auth/auth_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRepository {
  final String API_URL = dotenv.env['api_url'] ?? '';
  final Dio dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return true;
        },
      )
  );


  Future<Response> signIn(AuthModel authModel) async {
    final Map<String, dynamic> body = authModel.toJson();
    return await dio.post(
      "$API_URL/v1/auth/login",
      data: body,
    );
  }

  Future<Response> signUp(AuthModel authModel) async {
    final Map<String, dynamic> body = authModel.toJson();
    return await dio.post(
      "$API_URL/v1/auth/register",
      data: body,
    );
  }

  Future<Response> verifyEmail(String code) async {
    print(code);
    print("asdasd");
    return await dio.get(
      "$API_URL/v1/auth/verify?token=$code",
    );
  }
}