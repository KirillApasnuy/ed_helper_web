import 'package:dio/dio.dart';

class DeviceRepository {
  static const GET_IP_URL = "https://api.ipify.org?format=json";
  final Dio dio = Dio(BaseOptions(
    validateStatus: (status) {
      return true;
    },
  ));
  Future<String> getDeviceIp() async {
    print("Getting IP");
    return await dio.get(GET_IP_URL).then((res) => res.data["ip"]);
  }
}