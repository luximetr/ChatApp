
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/AppBarBuilder.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/TextInput.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/CreateChat/Helpers/FindUserResultView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateChatScreenView extends StatefulWidget {

  final Function(String name) onTapSearch;
  final User foundUser;
  final bool isSearchingUser;
  final bool isNothingFound;
  final VoidCallback onTapFoundUser;

  CreateChatScreenView({
    @required this.onTapSearch,
    this.foundUser,
    this.isSearchingUser,
    this.isNothingFound,
    this.onTapFoundUser,
  });

  @override
  State<StatefulWidget> createState() => CreateChatScreenViewState();
}

class CreateChatScreenViewState extends State<CreateChatScreenView> {

  final _loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.build(title: 'Create chat'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      color: appearance.background.primary,
        padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          _buildLoginInput(),
          _buildSearchResult()
        ],
      )
    );
  }

  Widget _buildLoginInput() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextInput(
        controller: _loginController,
        placeholder: 'Search login',
        suffixIcon: _buildSearchButton(),
      ),
    );
  }

  Widget _buildSearchButton() {
    return GestureDetector(
      child: Icon(
        Icons.search,
        color: appearance.text.secondary,
      ),
      onTap: () { widget.onTapSearch(_loginController.text); },
    );
  }

  Widget _buildSearchResult() {
    return Container(
      margin: EdgeInsets.only(top: 22),
      child:  FindUserResultView(
        onFoundUserTap: widget.onTapFoundUser,
        user: widget.foundUser,
        isLoading: widget.isSearchingUser,
        isNothingFound: widget.isNothingFound,
      ),
    );
  }
}