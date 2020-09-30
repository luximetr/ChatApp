
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Common/Alias/AliasMixin.dart';
import 'package:chat_app/ModelLayer/Common/RemoteDBEvent/RemoteDBEvent.dart';

class ChatListEvent = RemoteDBEvent<Chat> with ToAlias;