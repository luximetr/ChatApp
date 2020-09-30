
import 'package:chat_app/ModelLayer/Common/RemoteDBEvent/RemoteDBEventType.dart';
import 'package:flutter/cupertino.dart';

class RemoteDBEvent<DataType> {
  DataType data;
  RemoteDBEventType type;

  RemoteDBEvent({
    @required this.data,
    @required this.type
  });
}