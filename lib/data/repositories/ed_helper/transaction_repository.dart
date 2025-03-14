import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/transaction.dart'; // Импортируйте вашу модель Transaction

class TransactionRepository {
  final String API_URL = dotenv.env['api_url'] ?? '';
  final Dio dio = Dio(BaseOptions(
    validateStatus: (status) {
      return true;
    },
  ));

  // Получение всех транзакций
  Future<List<Transaction>?> getTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");

    Response response = await dio.get(
      '$API_URL/v1/transactions/by_user',
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $authToken"
      }),
    );

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => Transaction.fromJson(e))
          .toList();
    }
    return null;
  }

  // Создание новой транзакции
  Future<Response> createTransaction(Transaction transaction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");

    return await dio.post(
      '$API_URL/v1/transactions/',
      data: transaction.toJson(),
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $authToken"
      }),
    );
  }

  // Удаление транзакции по ID
  Future<Response> deleteTransaction(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");

    return await dio.delete(
      '$API_URL/v1/transactions/$id',
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $authToken"
      }),
    );
  }
}
