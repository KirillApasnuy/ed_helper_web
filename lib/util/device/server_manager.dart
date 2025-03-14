import 'dart:convert';
import 'dart:io';

class ServerManager {
  static final ServerManager _instance = ServerManager._internal();
  factory ServerManager() => _instance;
  ServerManager._internal();

  HttpServer? _server;
  bool isRunning = false;

  Future<void> startServer(Function listener) async {
    if (isRunning) {
      print("⚡ Сервер уже запущен.");
      return;
    }

    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 13022, shared: true);
    isRunning = true;
    print('✅ HTTP сервер работает на http://localhost:13022');

    _listenRequests(() => listener());
  }

  void _listenRequests(Function listener) async {
    await for (HttpRequest request in _server!) {
      if (request.method == 'GET' || request.method == 'POST') {
        listener();
        // Здесь можно вызывать методы из HomeScreen
      }

      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.json
        ..write(json.encode({'status': 'ok'}))
        ..close();
    }
  }

  void stopServer() {
    _server?.close();
    _server = null;
    isRunning = false;
    print("🛑 Сервер остановлен.");
  }
}
