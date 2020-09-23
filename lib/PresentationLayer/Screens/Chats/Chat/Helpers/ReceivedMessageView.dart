
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';

class ReceivedMessageView extends StatefulWidget {

  final String text;
  final String time;

  ReceivedMessageView({
    @required this.text,
    @required this.time
  });

  @override
  State<StatefulWidget> createState() => ReceivedMessageViewState();
}

class ReceivedMessageViewState extends State<ReceivedMessageView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: FittedBox(
        child: Column(
          children: [
            Container(
              color: appearance.background.secondary,
              padding: EdgeInsets.all(5),
              child: Text(widget.text, style: TextStyle(fontSize: 18, color: appearance.text.primary))
            )
          ],
        ),
      )
    );
  }
}