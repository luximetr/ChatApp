import 'package:chat_app/ApplicationLayer/Services/Auth/SignOutService.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/Routing.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignIn/Screen/SignInScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Profile/Helpers/ConfirmLogoutDialogBuilder.dart';
import 'package:chat_app/PresentationLayer/Screens/Profile/Screen/ProfileScreenView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  final _signOutService = SignOutService();
  final User user;

  ProfileScreen({@required this.user});

  void _onLogout(BuildContext context) {
    ConfirmLogoutDialogBuilder().show(
      context,
      onConfirm: () {
        _logout(context);
      }
    );
  }

  void _logout(BuildContext context) {
    _signOutService.signOut()
      .then((result) {
        _navigateToSignIn(context);
      }).catchError((error) {
        print(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScreenView(
      onLogout: () {
        _onLogout(context);
      },
      userName: user.name,
    );
  }

  void _navigateToSignIn(BuildContext context) {
    final targetScreen = SignInScreen();
    Routing.pushReplacement(context: context, targetScreen: targetScreen);
  }
}
