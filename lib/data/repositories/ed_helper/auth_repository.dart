import 'package:dio/dio.dart';
import 'package:ed_helper_web/data/models/gpt_answer/auth/auth_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRepository {
  final String _API_URL = dotenv.env['api_url'] ?? '';
  final Dio _dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return true;
        },
      )
  );


  Future<Response> signIn(AuthModel authModel) async {
    final Map<String, dynamic> body = authModel.toJson();
    return await _dio.post(
      "$_API_URL/v1/auth/login",
      data: body,
    );
  }

  Future<Response> signUp(AuthModel authModel) async {
    final Map<String, dynamic> body = authModel.toJson();
    return await _dio.post(
      "$_API_URL/v1/auth/register",
      data: body,
    );
  }

  Future<Response> verifyEmail(String code) async {
    return await _dio.get(
      "$_API_URL/v1/auth/verify?token=$code",
    );
  }

  Future<Response> verifyResetEmail(String email) async {
    return await _dio.get(
      "$_API_URL/v1/auth/get_verification_code?email=$email",
    );
  }
  Future<Response> getVerifyToken(String code) async {
    return await _dio.get(
      "$_API_URL/v1/auth/verify_reset_email?code=$code",
    );
  }
  Future<Response> resetPassword(String password, String token) async {
    return await _dio.get(
      "$_API_URL/v1/auth/reset_password?password=$password&token=$token",
    );
  }
}