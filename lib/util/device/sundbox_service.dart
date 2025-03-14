import 'package:flutter/services.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class SundboxService {
  String appId = "105531";
  String authKey = "ak_ZqXmAANUVyYQL9b";
  String secretKey = "as_m276xpHTanHjUL8";
  String accKey = "ack_PwbqK-MP9y8L-xqL5BJ7";

  void init() async {
    try {
      await QB.settings.init(appId, authKey, secretKey, accKey);
    } on PlatformException catch (e) {
      // Some error occurred, look at the exception message for more details
    }
  }
}