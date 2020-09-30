
import 'package:chat_app/DataLayer/Calculation/ShortNameGenerator.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/AppBarBuilder.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:chat_app/PresentationLayer/Screens/Profile/Helpers/ProfileMainInfoView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreenView extends StatelessWidget {

  final VoidCallback onLogout;
  final String userName;
  
  final _shortNameGenerator = ShortNameGenerator();

  ProfileScreenView({@required this.onLogout, @required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: ListView(
          children: [
            ProfileMainInfoView(initials: _shortNameGenerator.createShortName(this.userName), name: this.userName)
          ],
        ),
        color: appearance.background.secondary,
      )
    );
  }

  Widget _buildAppBar() {
    return AppBarBuilder.build(
      title: 'Profile',
      trailing: Container(
        padding: EdgeInsets.only(right: 14),
        child: GestureDetector(
          child: Icon(Icons.logout),
          onTap: this.onLogout,
        ),
      )
    );
  }
}