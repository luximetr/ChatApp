
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';

class SentMessageView extends StatefulWidget {

  final String text;
  final String time;

  SentMessageView({
    @required this.text,
    @required this.time,
  });

  @override
  State<StatefulWidget> createState() => SentMessageViewState();
}

class SentMessageViewState extends State<SentMessageView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Column(
          children: [
            Container(
              color: appearance.background.tertiary,
              padding: EdgeInsets.all(5),
              child: Text(widget.text, style: TextStyle(fontSize: 18, color: appearance.text.primary), maxLines: 3,),
            )
          ])
    );
  }
}