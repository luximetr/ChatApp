
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';
import 'package:chat_app/ModelLayer/Common/Alias/AliasMixin.dart';
import 'package:chat_app/ModelLayer/Common/RemoteDBEvent/RemoteDBEvent.dart';

class ChatEvent = RemoteDBEvent<Message> with ToAlias;
