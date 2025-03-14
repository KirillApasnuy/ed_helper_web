import 'package:ed_helper_web/data/models/user/user_model.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/user_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/bundle/chat_bubble.dart';
import '../../../data/models/chat_message/chat_message.dart';

class CenterChat extends StatefulWidget {
  CenterChat({super.key, required this.chatScrollController, required this.messages,});
  final ScrollController chatScrollController;
  List<ChatMessage> messages;

  @override
  State<CenterChat> createState() => _CenterChatState();
}

class _CenterChatState extends State<CenterChat> {
  final UserRepository _userRepository = UserRepository();
  String? AUHT_TOKEN;
  UserModel? user;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double size = screenWidth < screenHeight
        ? screenWidth
        : screenHeight; // Выбираем меньший размер
    double logoSize =
    size * 0.8 >= 800 ? 800 : (size * 0.8 <= 200 ? 200 : size * 0.8);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox.shrink(),
            if (AUHT_TOKEN != null)SizedBox(
              // Используем SizedBox с фиксированной высотой
              height: screenHeight - 150,
              width: screenWidth < 900 ? 550 : screenWidth * 0.6, // Задайте нужную высоту
              child: ListView.builder(
                controller: widget.chatScrollController,
                itemCount: widget.messages.length,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  final message = widget.messages[index];
                  return ChatBubble(message: message, token: AUHT_TOKEN!, userId: user!.id);
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }
  void initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    user = await _userRepository.getUser();
    setState(() {

      AUHT_TOKEN = authToken;
    });
  }
}
