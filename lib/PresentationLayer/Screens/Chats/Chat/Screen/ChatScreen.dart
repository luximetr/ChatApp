
import 'dart:async';
import 'package:chat_app/ApplicationLayer/Services/Chat/BlockChatService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/BlockMessageService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/ChatListService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/ChatMessageEventsService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/GetMessagesHistoryService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/MessagingService.dart';
import 'package:chat_app/ApplicationLayer/Services/Chat/UpdateChatLastReadMessageService.dart';
import 'package:chat_app/DataLayer/Calculation/DateCalculator.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEvent.dart';
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/ModelLayer/Common/RemoteDBEvent/RemoteDBEventType.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/NamedRoute.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/ToastBuilder.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/ChatOptionsActionsSheetBuilder.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/MessageDateFormatter.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/ReceivedMessageOptionsActionsSheetBuilder.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/MessageViewModel.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/MessageViewModelStatus.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Screen/ChatScreenView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget with NamedRoute {
  @override final String routeName = '/chat';

  final Chat chat;
  final User currentUser;

  ChatScreen({@required this.chat, @required this.currentUser});

  @override
  State<StatefulWidget> createState() => ChatScreenState(chat: chat);
}

class ChatScreenState extends State<ChatScreen> {

  // Dependencies
  final _messagingService = MessagingService();
  final _chatMessageEventsService = ChatMessageEventsService();
  final _chatUpdatesService = ChatListService();
  StreamSubscription<Chat> _chatUpdatesSubscription;
  final _updateChatLastReadMessageService = UpdateChatLastReadMessageService();
  final _getMessagesHistoryService = GetMessagesHistoryService();
  final _blockChatService = BlockChatService();
  final _blockMessageService = BlockMessageService();

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
      onMoreTap: () { _onMoreTap(context); },
      onReceivedMessageLongPress: (message) => _onReceivedMessageLongPress(context, message),
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
    _messagingService
        .sendMessage(widget.chat.id, text)
        .catchError((error) => print(error));
  }
  
  // Chat events
  void _startListenChatUpdates() {
    _chatUpdatesSubscription = _chatUpdatesService.startListenChatUpdates(widget.currentUser.id, widget.chat.id);
    _chatUpdatesSubscription.onData((update) => _handleChatUpdate(update));
    _chatUpdatesSubscription.onError((error) => print('Error $error'));
  }
  
  void _stopListenChatUpdates() {
    _chatUpdatesSubscription?.cancel();
  }
  
  void _handleChatUpdate(Chat updatedChat) {
    setState(() {
      _chat = updatedChat;
    });
  }

  // Chat message events
  void _startListenChatMessageEvents() {
    _chatMessageEventsService
        .startListenChatMessageEvents(widget.chat.id, widget.currentUser.id)
        .listen((event) => _handleChatMessageEvent(event))
        .onError((error) => print('Error: $error'));
  }

  void _stopListenChatMessageEvents() {
    _chatMessageEventsService.stopListenChatMessageEvents();
  }

  void _handleChatMessageEvent(ChatEvent event) {
    switch (event.type) {
      case RemoteDBEventType.created:
        _handleMessageCreated(event.data);
        break;
      case RemoteDBEventType.updated:
        _handleMessageModified(event.data);
        break;
      case RemoteDBEventType.deleted:
        _handleMessageRemoved(event.data);
        break;
    }
  }

  // Message created
  void _handleMessageCreated(Message message) {
    if (_isMessageAlreadyDisplaying(message.id)) {
      _handleMessageModified(message);
    } else {
      _displayMessageCreated(message);
      _markMessageAsReadIfNeeded(message);
    }
  }

  void _displayMessageCreated(Message message) {
    final viewModel = _createMessageViewModel(message);
    setState(() {
      _displayMessages.insert(0, viewModel);
    });
  }

  // Message modified
  void _handleMessageModified(Message message) {
    final index = _findMessageViewModelIndex(message.id);
    if (index == -1) { return; }
    final viewModel = _createMessageViewModel(message);
    setState(() {
      _displayMessages[index] = viewModel;
    });
  }

  // Message removed
  void _handleMessageRemoved(Message message) {
    final index = _findMessageViewModelIndex(message.id);
    if (index == -1) { return; }
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

  // Message actions
  void _onReceivedMessageLongPress(BuildContext context, MessageViewModel message) {
    ReceivedMessageOptionsActionsSheetBuilder.show(
      context,
      isBlocked: message.message.isBlockedForYou,
      onBlock: () { _blockReceivedMessage(message.message); },
      onUnblock: () { _unblockReceivedMessage(message.message); },
      onReport: () { _reportReceivedMessage(message.message); }
    );
  }

  void _blockReceivedMessage(Message message) {
    _blockMessageService
      .blockMessage(_chat.id, message.id, widget.currentUser.id)
      .then((value) {})
      .catchError((error) => print('Message block error $error'));
  }

  void _unblockReceivedMessage(Message message) {
    _blockMessageService
      .unblockMessage(_chat.id, message.id, widget.currentUser.id)
      .then((value) {})
      .catchError((error) => print('Message unblock error $error'));

  }

  void _reportReceivedMessage(Message message) {

  }

  // Find message
  int _findMessageViewModelIndex(String messageId) {
    return _displayMessages.indexWhere((element) => element.message.id == messageId);
  }

  bool _isMessageAlreadyDisplaying(String messageId) {
    final index = _findMessageViewModelIndex(messageId);
    return index != -1;
  }

  // History
  void _loadMessagesHistoryNextPage() {
    if (_isLoadingHistory == true) { return; }
    final startAfterMessageId = _getLastHistoryMessageId();
    _isLoadingHistory = true;
    _getMessagesHistoryService
        .getMessagesHistory(_chat.id, widget.currentUser.id, startAfterMessageId)
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
    if (messages.isNotEmpty) {
      _markMessageAsReadIfNeeded(messages.first);
    }
  }

  // Options
  void _onMoreTap(BuildContext context) {
    ChatOptionsActionsSheetBuilder.show(
      context,
      isBlockedByYou: _chat.isBlockedByYou,
      onBlockTap: () { _blockChat(context); },
      onUnblockTap: () { _unblockChat(context); }
    );
  }

  // Block user
  void _blockChat(BuildContext context) {
    _blockChatService
      .blockChat(_chat.id, widget.currentUser.id)
      .then((result) => ToastBuilder.show(context, 'User blocked'))
      .catchError((error) => ToastBuilder.show(context, 'Error $error'));
  }

  // Unblock user
  void _unblockChat(BuildContext context) {
    _blockChatService
      .unblockChat(_chat.id, widget.currentUser.id)
      .then((result) => ToastBuilder.show(context, 'User unblocked'))
      .catchError((error) => ToastBuilder.show(context, 'Error $error'));
  }
}