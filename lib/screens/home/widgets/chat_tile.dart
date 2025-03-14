import 'package:dio/dio.dart';
import 'package:ed_helper_web/common/widgets/dialog/done_dialog.dart';
import 'package:ed_helper_web/common/widgets/dialog/error_dialog.dart';
import 'package:ed_helper_web/common/widgets/pictures/svg_icons.dart';
import 'package:ed_helper_web/data/models/chat_message/chat_model.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';

class ChatTile extends StatefulWidget {
  const ChatTile({
    super.key,
    required this.chatModel, this.deleteChat, this.onSelectChat,
  });
  final void Function(ChatModel)? onSelectChat;
  final Function(int)? deleteChat;
  final ChatModel chatModel;

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  bool isHover = false;
  ChatRepository chatRepository = ChatRepository();

  String formatDate(DateTime date) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime twoDaysAgo = today.subtract(Duration(days: 2));

    if (date.isAfter(today)) {
      return S.of(context).today;
    } else if (date.isAfter(yesterday)) {
      return S.of(context).yesterday;
    } else if (date.isAfter(twoDaysAgo)) {
      return S.of(context).yesterday;
    } else {
      return DateFormat('dd.MM').format(date);
    }
  }

  void deleteChat() async {
    Response response = await chatRepository.deleteChat(widget.chatModel.id);
    if (response.statusCode == 200) {
      widget.deleteChat!(widget.chatModel.id);
      showDialog(
        context: context,
        builder: (context) {
          return DoneDialog(title: S.of(context).deleteSuccessfully,);
        }
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(title: S.of(context).thereWasAnError,);
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHover = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.onSelectChat!(widget.chatModel);
        },
        child: Container(
          padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
          margin: const EdgeInsets.only(
            top: 10,
          ),
          decoration: BoxDecoration(

          color: isHover ? Colors.blue[50] : Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDate(widget.chatModel.createdAt),
                    style: GoogleFonts.montserrat(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Transform.translate(
                    offset: Offset(10, 0),
                    child: IconButton(onPressed: () {
                      deleteChat();
                    }, icon:
                    const SvgIcons(path: "assets/svg/delete_chat.svg", size: 20)),
                  )
                ],
              ),
              Text(
                widget.chatModel.title,
                style: GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.w400),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
