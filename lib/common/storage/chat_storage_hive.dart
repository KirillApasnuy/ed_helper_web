import 'package:hive/hive.dart';
import '../../data/models/chat_message/chat_message.dart';

class ChatStorageHive {
  late Box<ChatMessage> _box; // Указываем тип Box<ChatMessage>

  // Приватный конструктор
  ChatStorageHive._();

  // Фабричный метод для инициализации
  static Future<ChatStorageHive> create() async {
    final instance = ChatStorageHive._();
    await instance._init(); // Инициализируем коробку
    return instance;
  }

  // Инициализация коробки
  Future<void> _init() async {
    if (!Hive.isBoxOpen('chatMessagesBox')) {
      _box = await Hive.openBox<ChatMessage>('chatMessagesBox');
    } else {
      _box = Hive.box<ChatMessage>('chatMessagesBox');
    }
  }

  // Сохранение сообщения
  Future<void> saveMessage(ChatMessage message) async {
    await _box.add(message);
  }

  // Получение всех сообщений
  Future<List<ChatMessage>> getMessages() async {
    return _box.values.toList();
  }

  // Закрытие коробки (опционально)
  Future<void> close() async {
    await _box.close();
  }
}