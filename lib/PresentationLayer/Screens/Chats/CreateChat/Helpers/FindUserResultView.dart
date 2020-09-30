
import 'package:chat_app/DataLayer/Calculation/ShortNameGenerator.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/AvatarView.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindUserResultView extends StatefulWidget {

  final VoidCallback onFoundUserTap;
  final User user;
  final bool isLoading;
  final bool isNothingFound;
  final bool isChatCreatingLoading;

  FindUserResultView({
    @required this.onFoundUserTap,
    @required this.user,
    @required this.isLoading,
    @required this.isNothingFound,
    @required this.isChatCreatingLoading,
  });

  @override
  State<StatefulWidget> createState() => FindUserResultViewState();

}

class FindUserResultViewState extends State<FindUserResultView> {

  final _shortNameGenerator = ShortNameGenerator();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(),
      height: 54,
    );
  }

  Widget _buildBody() {
    if (widget.user != null) {
      return _buildUserFoundState();
    } else if (widget.isLoading) {
      return _buildInProgressState();
    } else if (widget.isNothingFound) {
      return _buildNothingFoundState();
    } else {
      return _buildPlaceholderState();
    }
  }

  // In progress state
  Widget _buildInProgressState() {
    return Row(
      children: [
        _buildLoader(),
        _buildLoaderText()
      ],
    );
  }

  Widget _buildLoader() {
    return Container(
      height: 15,
      width: 15,
      margin: EdgeInsets.only(left: 13),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(appearance.text.primary),
        strokeWidth: 1,
      ),
    );
  }

  Widget _buildLoaderText() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Text(
          'Searching in progress',
          style: TextStyle(color: appearance.text.primary, fontSize: 16)
      ),
    );
  }

  // Just text state
  Widget _buildJustText(String text) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 12),
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: appearance.text.primary),
          ),
        )
      ],
    );
  }

  // Placeholder state
  Widget _buildPlaceholderState() {
    return _buildJustText('Here will be a result');
  }

  // Nothing found state
  Widget _buildNothingFoundState() {
    return _buildJustText('Nothing found');
  }

  // Success result state
  Widget _buildUserFoundState() {
    return InkWell(
      onTap: () {
        if (!widget.isChatCreatingLoading) {
          this.widget.onFoundUserTap();
        }
      },
      child: Row(
        children: [
          AvatarView(title: _shortNameGenerator.createShortName(widget.user.name), side: 44, backgroundColor: appearance.background.secondary),
          Container(
            child: Text(widget.user.name, style: TextStyle(color: appearance.text.primary, fontSize: 16)),
            margin: EdgeInsets.only(left: 4),
          ),
          if (widget.isChatCreatingLoading) _buildLoader(),
          Spacer(),
          Icon(Icons.keyboard_arrow_right, color: appearance.text.secondary, size: 26)
        ].where((object) => object != null).toList()
      ),
    );
  }

}