import 'package:dio/dio.dart';
import 'package:ed_helper_web/data/models/user/subscription.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscribeRepository {
  final String API_URL = dotenv.env['api_url'] ?? '';
  final Dio dio = Dio(BaseOptions(
    validateStatus: (status) {
      return true;
    },
  ));

  Future<List<Subscription>?> getSubscription() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");
    Response response = await dio.get('$API_URL/v1/subscriptions/',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken"
        }));
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => Subscription.fromJson(e))
          .toList();
    }
    return null;
  }

  Future<Response> subscribe(
      {required int planId, bool autoRenewal = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");
    return await dio.get(
        '$API_URL/v1/subscriptions/subscribe?id=$planId&isAutoRenewal=$autoRenewal',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken"
        }));
  }

  Future<Response> cancelSubscription() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");
    return await dio.post(
        '$API_URL/v1/subscriptions/unsubscribe',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken"
        }));
  }

}
