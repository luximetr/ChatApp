
import 'package:chat_app/ApplicationLayer/Services/Chat/ChatEventsService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/ChatMessageEventsService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/SendMessageService.dart';
import 'package:chat_app/DataLayer/Calculation/DateCalculator.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEvent.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEventType.dart';
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/MessageDateFormatter.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/MessageViewModel.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/MessageViewModelStatus.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Screen/ChatScreenView.dart';
import 'package:flutter/cupertino.dart';

class ChatScreen extends StatefulWidget {

  final Chat chat;
  final User currentUser;

  ChatScreen({@required this.chat, @required this.currentUser});

  @override
  State<StatefulWidget> createState() => ChatScreenState(chat: chat);
}

class ChatScreenState extends State<ChatScreen> {

  // Dependencies
  final _sendMessageService = SendMessageService();
  final _chatMessageEventsService = ChatMessageEventsService();
  final _chatUpdatesService = ChatEventsService();

  final _listController = ScrollController();
  final _messageDateFormatter = MessageDateFormatter();
  final _dateCalculator = DateCalculator();

  // Data
  Chat _chat;
  final List<MessageViewModel> _displayMessages = [];

  // View
  @override
  Widget build(BuildContext context) {
    return ChatScreenView(
      chat: _chat,
      onSendTap: _onSendTap,
      displayMessages: _displayMessages,
      listController: _listController,
      getMessageStatusCallback: (messageVM) => _getMessageViewModelStatus(messageVM.message),
    );
  }

  // Life cycle
  ChatScreenState({@required Chat chat}) {
    _chat = chat;
  }
  
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

    _startListenChatMessageEvents();
    _startListenChatUpdates();
  }

  @override
  void dispose() {
    super.dispose();
    _stopListenChatMessageEvents();
    _stopListenChatUpdates();
  }

  // Send message
  void _onSendTap(String text) {
    if (text.isEmpty) { return; }
    _sendMessageService
        .sendMessage(widget.chat.id, text)
        .catchError((error) => print(error));
  }
  
  // Chat events
  void _startListenChatUpdates() {
    _chatUpdatesService
        .startListenChatUpdates(widget.chat.id, widget.currentUser.id)
        .listen((update) => _handleChatUpdates(update))
        .onError((error) => print('Error $error'));
  }
  
  void _stopListenChatUpdates() {
    _chatUpdatesService.stopListenChatUpdates();
  }
  
  void _handleChatUpdates(Chat updatedChat) {
    setState(() {
      _chat = updatedChat;
    });
  }

  // Chat message events
  void _startListenChatMessageEvents() {
    _chatMessageEventsService
        .startListenChatMessageEvents(widget.chat.id)
        .listen((event) => _handleChatMessageEvent(event))
        .onError((error) => print('Error: $error'));
  }

  void _stopListenChatMessageEvents() {
    _chatMessageEventsService.stopListenChatMessageEvents();
  }

  void _handleChatMessageEvent(ChatEvent event) {
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
    final viewModel = _createMessageViewModel(message);
    setState(() {
      _displayMessages.add(viewModel);
    });
    _scrollToLastMessage();
  }

  // Message modified
  void _handleMessageModified(Message message) {
    final index = _findMessageViewModelIndex(message.id);
    if (index == null) { return; }
    final viewModel = _createMessageViewModel(message);
    setState(() {
      _displayMessages[index] = viewModel;
    });
  }

  // Message removed
  void _handleMessageRemoved(Message message) {
    final index = _findMessageViewModelIndex(message.id);
    if (index == null) { return; }
    setState(() {
      _displayMessages.removeAt(index);
    });
  }

  // MessageViewModel
  MessageViewModel _createMessageViewModel(Message message) {
    return MessageViewModel(
      message: message,
      text: message.text,
      time: _messageDateFormatter.format(message.createdAt),
      isFromCurrentUser: message.senderId == widget.currentUser.id,
      status: _getMessageViewModelStatus(message),
    );
  }

  MessageViewModelStatus _getMessageViewModelStatus(Message message) {
    if (_chat.lastReadMessageCreatedAt == null ||
        _dateCalculator.isLessOrEqual(_chat.lastReadMessageCreatedAt, message.createdAt)) {
      return MessageViewModelStatus.sent;
    } else {
      return MessageViewModelStatus.read;
    }
  }

  // Find message
  int _findMessageViewModelIndex(String messageId) {
    return _displayMessages.indexWhere((element) => element.message.id == messageId);
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