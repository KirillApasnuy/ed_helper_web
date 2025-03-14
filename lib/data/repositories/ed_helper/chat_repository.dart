import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/chat_message/chat_model.dart';

class ChatRepository {
  final String API_URL = dotenv.env['api_url'] ?? '';
  final Dio dio = Dio(BaseOptions(
    validateStatus: (status) {
      return true;
    },
  ));

  Future<List<ChatModel>> getChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");
    final response = await dio.get(API_URL + '/v1/chats/all',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        }));
    if (response.statusCode == 200) {
      final data = response.data;
      if (data is List) {
        return data.map((e) {
          return ChatModel.fromJson(e);}).toList();
      } else {
        throw FormatException('Expected a list but got ${data.runtimeType}');
      }
    } else {
      throw Exception('Failed to load chat history: ${response.statusCode}');
    }
  }

  Future<Response> deleteChat(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");
    return await dio.delete('$API_URL/v1/chats/?chatId=$id',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        }));

  }
}
