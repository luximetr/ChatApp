
import 'package:chat_app/ApplicationLayer/Services/User/FindUserService.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/CreateChat/Screen/CreateChatScreenView.dart';
import 'package:flutter/cupertino.dart';

class CreateChatScreen extends StatefulWidget {
  State<StatefulWidget> createState() => CreateChatScreenState();
}

class CreateChatScreenState extends State<CreateChatScreen> {

  final _findUserService = FindUserService();
  User _foundUser;
  bool _isSearchingUser = false;

  // Search user
  void _onTapSearch(String login) {
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
      _isSearchingUser = false;
    });
  }

  // Start chat
  void _onTapFoundUser() {
    print('Start chat with ${_foundUser.name}');
  }

  // Build
  @override
  Widget build(BuildContext context) {
    return CreateChatScreenView(
      onTapSearch: _onTapSearch,
      onTapFoundUser: _onTapFoundUser,
      foundUser: _foundUser,
      isSearchingUser: _isSearchingUser,
    );
  }
}