import 'package:ed_helper_web/data/models/user/user_model.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/bundle/chat_bubble.dart';
import '../../../data/models/chat_message/chat_message.dart';

class CenterChat extends StatefulWidget {
  CenterChat({
    super.key,
    required this.chatScrollController,
    required this.messages,
  });

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

    double size = screenWidth < screenHeight ? screenWidth : screenHeight;
    return (AUHT_TOKEN != null)
        ? Center(
          child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              margin: const EdgeInsets.only(top: 70),
              child: ListView.builder(
                controller: widget.chatScrollController,
                itemCount: widget.messages.length,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  final message = widget.messages[index];
                  return ChatBubble(
                      message: message,
                      token: AUHT_TOKEN!,
                      userId: user!.id);
                },
              ),
            ),
        )
        : const SizedBox();
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
