
import 'package:chat_app/PresentationLayer/Helpers/Components/AvatarView.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';

class ProfileMainInfoView extends StatelessWidget {

  final String initials;
  final String name;

  ProfileMainInfoView({@required this.initials, @required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _buildAvatarView(),
          _buildNameView(),
        ],
      ),
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(vertical: 10),
      color: appearance.background.primary,
    );
  }

  Widget _buildAvatarView() {
    return AvatarView(
        title: this.initials,
        side: 50,
        backgroundColor: appearance.background.secondary
    );
  }

  Widget _buildNameView() {
    return Text(
      this.name,
      style: TextStyle(
          fontSize: 16,
          color: appearance.text.primary
      ),
    );
  }
}