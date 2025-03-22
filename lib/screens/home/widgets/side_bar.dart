import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/common/widgets/button/side_bar_button.dart';
import 'package:ed_helper_web/common/widgets/form_fields/form_field_type_one.dart';
import 'package:ed_helper_web/common/widgets/pictures/svg_icons.dart';
import 'package:ed_helper_web/data/models/chat_message/chat_model.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/chat_repository.dart';
import 'package:ed_helper_web/util/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/button/text_button_type_one.dart';
import '../../../generated/l10n.dart';
import 'chat_tile.dart';

class HomeSideBar extends StatefulWidget {
  HomeSideBar({
    super.key,
    required this.isExpanded,
    required this.onSelectChat,
    this.isHomeRoute,
  });

  bool isExpanded;
  final isHomeRoute;
  final Function(ChatModel) onSelectChat;

  @override
  State<HomeSideBar> createState() => _HomeSideBarState();
}

class _HomeSideBarState extends State<HomeSideBar> {
  ChatRepository chatRepository = ChatRepository();
  TextEditingController searchController = TextEditingController();
  String? selectedAssistant;
  String? token;
  bool isSearching = false;
  List<ChatModel> chatHistory = [];
  List<ChatModel> searchResults = [];

  @override
  void initState() {
    _loadChatHistory();
    super.initState();
  }

  Future<void> _loadChatHistory() async {
    isAuth();
    final history = await chatRepository.getChatHistory();
    setState(() {
      chatHistory = history ?? [];
    });

    if (history.isNotEmpty) {
      widget.onSelectChat(history.first);
    }
  }

  void _createChat() async {
    ChatModel newChat = ChatModel(
      id: 0,
      createdAt: DateTime.now(),
      title: "",
      messages: [],
    );

    setState(() {
      chatHistory.insert(0, newChat);
      widget.onSelectChat(newChat);
    });
  }

  void _handleSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = []; // Сбросить результаты поиска
        isSearching = false;
      });
    }

    searchResults = chatHistory
        .where((chat) => chat.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    isSearching = true;
    setState(() {});
  }

  // Метод для удаления чата
  Future<void> deleteChat(int chatId) async {
    setState(() {
      chatHistory.removeWhere((chat) => chat.id == chatId);
    });
  }

  void isAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double size = screenWidth < screenHeight
        ? screenWidth
        : screenHeight; // Выбираем меньший размер
    double logoSize =
        size * 0.8 >= 800 ? 800 : (size * 0.8 <= 200 ? 200 : size * 0.8);
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
        width: 300,
        height: screenHeight,
        child: Column(
          children: [
            if (widget.isHomeRoute)
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context).replace(const WelcomeRoute());
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SvgPicture.asset(
                        "assets/logo/title_logo.svg",
                        height: 50,
                      ),
                    ),
                  ),
                ],
              ),
            if (widget.isHomeRoute) const SizedBox(height: 20),
            SizedBox(
              width: 230,
              height: 50,
              child: SideBarButton(
                  text: S.of(context).createChat,
                  prefixIcon:
                      const SvgIcons(path: "assets/svg/add.svg", size: 25),
                  onPressed: () {
                    _createChat();
                  }),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                S.of(context).history,
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              // trailing: SvgPicture.asset(
              //   !widget.isExpanded
              //       ? "assets/svg/arrow_down.svg"
              //       : "assets/svg/arrow_up.svg",
              // ),
              onTap: () {
                setState(() {
                  widget.isExpanded = !widget.isExpanded;
                });
              },
            ),
            Expanded(child:
            chatHistory.isNotEmpty
                  ? Expanded(
                child: Column(
                  children: [
                    FormFieldTypeOne(
                      controller: searchController,
                      onChanged: _handleSearch,
                      maxLines: 1,
                      hintText: "Search...",
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: isSearching
                            ? searchResults.length
                            : chatHistory.length,
                        itemBuilder: (context, index) {
                          final chat = isSearching
                              ? searchResults[index]
                              : chatHistory[index];
                          return ChatTile(
                            onSelectChat: (chatModel) {
                              widget.onSelectChat(chatModel);
                              setState(() {
                                isSearching = false;
                                searchController.clear();
                              });
                            },
                            chatModel: chat,
                            deleteChat: deleteChat,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
                  : Column(
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: token == null
                        ? TextButtonTypeOne(
                      text: S.of(context).logInAcc,
                      onPressed: () {
                        AutoRouter.of(context)
                            .push(AuthorizationRoute());
                      },
                    )
                        : Text(
                      S.of(context).noChatHistory,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}
