
import 'package:chat_app/ApplicationLayer/Services/Chat/CreateChatService.dart';
import 'package:chat_app/ApplicationLayer/Services/User/FindUserService.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/Routing.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Screen/ChatScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/ChatList/Screen/ChatListScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/CreateChat/Screen/CreateChatScreenView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateChatScreen extends StatefulWidget {
  static String routeName = '/create_chat';

  final User currentUser;

  CreateChatScreen({@required this.currentUser});

  State<StatefulWidget> createState() => CreateChatScreenState();
}

class CreateChatScreenState extends State<CreateChatScreen> {

  // Dependencies
  final _findUserService = FindUserService();
  final _createChatService = CreateChatService();

  // Data
  User _foundUser;
  bool _isSearchingUser = false;
  bool _isNothingFound = false;
  bool _isChatCreatingLoading = false;

  // Search user
  void _onTapSearch(String login) {
    if (login.isEmpty) { return; }
    _userWillStartSearch();
    _findUserService
        .findUser(login)
        .then((user) => _userFound(user))
        .catchError((error) => _userSearchError(error));
  }

  void _userWillStartSearch() {
    setState(() {
      _foundUser = null;
      _isSearchingUser = true;
      _isNothingFound = false;
    });
  }

  void _userFound(User user) {
    setState(() {
      _isSearchingUser = false;
      _foundUser = user;
    });
  }

  void _userSearchError(dynamic error) {
    print(error);
    setState(() {
      _isNothingFound = true;
      _isSearchingUser = false;
    });
  }

  // Start chat
  void _onTapFoundUser(BuildContext context) {
    _startChat(context, _foundUser);
  }

  void _startChat(BuildContext context, User targetUser) {
    _willStartChat();
    _createChatService
        .createChat(targetUser)
        .then((createdChat) {
          _willFinishStartChat();
          _navigateToChat(context, createdChat);
        })
        .catchError((error) {
          print('Start chat error $error');
          _willFinishStartChat();
        });
  }

  void _willStartChat() {
    setState(() {
      _isChatCreatingLoading = true;
    });
  }

  void _willFinishStartChat() {
    setState(() {
      _isChatCreatingLoading = false;
    });
  }

  // Build
  @override
  Widget build(BuildContext context) {
    return CreateChatScreenView(
      onTapSearch: _onTapSearch,
      onTapFoundUser: () { _onTapFoundUser(context); },
      foundUser: _foundUser,
      isSearchingUser: _isSearchingUser,
      isChatCreatingLoading: _isChatCreatingLoading,
      isNothingFound: _isNothingFound,
    );
  }

  // Open chat
  void _navigateToChat(BuildContext context, Chat chat) {
    final targetScreen = ChatScreen(chat: chat, currentUser: widget.currentUser);
    Routing.pushAndRemoveUntil(context: context, targetScreen: targetScreen, removeUntil: ChatListScreen.routeNameStatic);
  }
}