
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarView extends StatelessWidget {

  final String title;
  final double side;
  final VoidCallback onTap;
  final Color backgroundColor;

  AvatarView({@required this.title, @required this.side, this.onTap, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          decoration: new BoxDecoration(
              color: this.backgroundColor ?? appearance.background.primary,
              borderRadius: BorderRadius.circular(side / 2)
          ),
          height: side,
          width: side,
          margin: EdgeInsets.all(6),
          child: Center(
            child: Text(this.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: appearance.text.primary)),
          )
      ),
        onTap: this.onTap,
    );
  }
}