
import 'package:chat_app/ApplicationLayer/Services/Chat/ChatMessageEventsService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/SendMessageService.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEvent.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEventType.dart';
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/MessageDateFormatter.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/MessageViewModel.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Screen/ChatScreenView.dart';
import 'package:flutter/cupertino.dart';

class ChatScreen extends StatefulWidget {

  final Chat chat;
  final User currentUser;

  ChatScreen({@required this.chat, @required this.currentUser});

  @override
  State<StatefulWidget> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  // Dependencies
  final _sendMessageService = SendMessageService();
  final _chatMessageEventsService = ChatMessageEventsService();

  final _listController = ScrollController();
  final _messageDateFormatter = MessageDateFormatter();

  // Data
  final List<MessageViewModel> _displayMessages = [];

  // View
  @override
  Widget build(BuildContext context) {
    return ChatScreenView(
      chat: widget.chat,
      onSendTap: _onSendTap,
      displayMessages: _displayMessages,
      listController: _listController,
    );
  }

  // Life cycle
  @override
  void initState() {
    super.initState();
    // setState(() {
    //   _displayMessages.addAll([
    //     MessageViewModel(messageId: 'id', text: '.', time: '12:03 pm', isFromCurrentUser: true, status: MessageViewModelStatus.sending),
    //     MessageViewModel(messageId: 'id', text: '.', time: '03:23 am', isFromCurrentUser: false),
    //     MessageViewModel(messageId: 'id', text: 'Long text asd ahsdh askjda sjkhd kjashdjk ahksd ahskj ahsdj kashdjk ahsd', time: '12:03 pm', isFromCurrentUser: true, status: MessageViewModelStatus.sent),
    //     MessageViewModel(messageId: 'id', text: 'Long text asd ahsdh askjda sjkhd kjashdjk ahksd ahskj ahsdj kashdjk ahsd', time: '03:23 am', isFromCurrentUser: false),
    //     MessageViewModel(messageId: 'id', text: 'Long text asd ahsdh askjda sjkhd', time: '03:23 am', isFromCurrentUser: false),
    //     MessageViewModel(messageId: 'id', text: 'Some text', time: '12:03 pm', isFromCurrentUser: true, status: MessageViewModelStatus.read),
    //     MessageViewModel(messageId: 'id', text: 'Long text asd ahsdh askjda sjkhd kjashdjk ahksd ahskj ahsdj kashdjk ahsd', time: '12:03 pm', isFromCurrentUser: true, status: MessageViewModelStatus.failed),
    //   ]);
    // });

    _startListenChatEvents();
  }

  @override
  void dispose() {
    super.dispose();
    _stopListenChatEvents();
  }

  // Send message
  void _onSendTap(String text) {
    if (text.isEmpty) { return; }
    _sendMessageService
        .sendMessage(widget.chat.id, text)
        .catchError((error) => print(error));
  }

  // Chat events
  void _startListenChatEvents() {
    _chatMessageEventsService
        .startListenChatEvents(widget.chat.id)
        .listen((event) => _handleChatEvent(event))
        .onError((error) => print('Error: $error'));
  }

  void _stopListenChatEvents() {
    _chatMessageEventsService.stopListenChatEvents();
  }

  void _handleChatEvent(ChatEvent event) {
    switch (event.type) {
      case ChatEventType.created:
        _handleMessageCreated(event.message);
        break;
      case ChatEventType.modified:
        _handleMessageModified(event.message);
        break;
      case ChatEventType.removed:
        _handleMessageRemoved(event.message);
        break;
    }
  }

  // Message created
  void _handleMessageCreated(Message message) {
    setState(() {
      _displayMessages.add(
          MessageViewModel(
            messageId: message.id,
            text: message.text,
            time: _messageDateFormatter.format(message.createdAt),
            isFromCurrentUser: message.senderId == widget.currentUser.id,
            status: MessageViewModelStatus.sent
          )
      );
    });
    _scrollToLastMessage();
  }

  // Message modified
  void _handleMessageModified(Message message) {

  }

  // Message removed
  void _handleMessageRemoved(Message message) {

  }

  // Scroll to message
  void _scrollToLastMessage() {
    Future.delayed(Duration(milliseconds: 100), () {
      _listController.animateTo(
          _listController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut
      );
    });
  }
}