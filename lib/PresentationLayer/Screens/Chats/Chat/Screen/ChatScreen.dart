
import 'package:chat_app/ApplicationLayer/Services/Chat/ChatEventsService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/ChatMessageEventsService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/GetMessagesHistoryService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/SendMessageService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/UpdateChatLastReadMessageService.dart';
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
  final _updateChatLastReadMessageService = UpdateChatLastReadMessageService();
  final _getMessagesHistoryService = GetMessagesHistoryService();

  final _messageDateFormatter = MessageDateFormatter();
  final _dateCalculator = DateCalculator();

  // Data
  Chat _chat;
  final List<MessageViewModel> _displayMessages = [];
  bool _isLoadingHistory = false;

  // View
  @override
  Widget build(BuildContext context) {
    return ChatScreenView(
      chat: _chat,
      onSendTap: _onSendTap,
      displayMessages: _displayMessages,
      getMessageStatusCallback: (messageVM) => _getMessageViewModelStatus(messageVM.message),
      onReachedScrollEnd: _onReachedScrollEnd,
    );
  }

  // Life cycle
  ChatScreenState({@required Chat chat}) {
    _chat = chat;
  }
  
  @override
  void initState() {
    super.initState();
    _loadMessagesHistoryNextPage();
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
      _displayMessages.insert(0, viewModel);
    });
    _markMessageAsReadIfNeeded(message);
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

  // Read message
  void _markMessageAsReadIfNeeded(Message message) {
    if (_getIsFromCurrentUser(message)) { return; }
    _updateChatLastReadMessageService.updateChatLastReadMessage(
        _chat.id,
        widget.currentUser.id,
        message
    );
  }

  // MessageViewModel
  MessageViewModel _createMessageViewModel(Message message) {
    return MessageViewModel(
      message: message,
      text: message.text,
      time: _messageDateFormatter.format(message.createdAt),
      isFromCurrentUser: _getIsFromCurrentUser(message),
      status: _getMessageViewModelStatus(message),
    );
  }

  bool _getIsFromCurrentUser(Message message) {
    return message.senderId == widget.currentUser.id;
  }

  MessageViewModelStatus _getMessageViewModelStatus(Message message) {
    if (_chat.lastReadMessageCreatedAt == null ||
        _dateCalculator.isGreaterThan(message.createdAt, _chat.lastReadMessageCreatedAt)) {
      return MessageViewModelStatus.sent;
    } else {
      return MessageViewModelStatus.read;
    }
  }

  // Find message
  int _findMessageViewModelIndex(String messageId) {
    return _displayMessages.indexWhere((element) => element.message.id == messageId);
  }

  // History
  void _loadMessagesHistoryNextPage() {
    if (_isLoadingHistory == true) { return; }
    final startAfterMessageId = _getLastHistoryMessageId();
    _isLoadingHistory = true;
    _getMessagesHistoryService
        .getMessagesHistory(_chat.id, startAfterMessageId)
        .then((messages) {
          _isLoadingHistory = false;
          _displayMessagesHistory(messages);
        })
        .catchError((error) {
          _isLoadingHistory = false;
          print('Error $error');
        });
  }

  String _getLastHistoryMessageId() {
    if (_displayMessages.isEmpty) { return null; }
    return _displayMessages.last.message.id;
  }

  void _onReachedScrollEnd() {
    _loadMessagesHistoryNextPage();
  }

  void _displayMessagesHistory(List<Message> messages) {
    final viewModels = messages.map((message) => _createMessageViewModel(message));
    setState(() {
      _displayMessages.addAll(viewModels);
    });
  }
}