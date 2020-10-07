
import 'dart:async';
import 'package:chat_app/ApplicationLayer/Services/Chat/ChatListService.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Business/ChatListEvent/ChatListEvent.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/ModelLayer/Common/RemoteDBEvent/RemoteDBEventType.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/NamedRoute.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Screen/ChatScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/ChatList/Screen/ChatListScreenView.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/CreateChat/Screen/CreateChatScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Profile/Screen/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget with NamedRoute {
  static String routeNameStatic = '/chat_list';
  @override final String routeName = routeNameStatic;

  final User user;

  ChatListScreen({@required this.user});

  @override
  State<StatefulWidget> createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ChatListScreen> {

  // Dependencies
  final _chatListService = ChatListService();
  StreamSubscription<ChatListEvent> _chatListUpdatesSubscription;

  // Data
  List<Chat> _chats = [];

  // View
  @override
  Widget build(BuildContext context) {
    return ChatListScreenView(
      chats: _chats,
      userName: widget.user.name,
      onAvatarTap: () { _onAvatarTap(context); },
      onCreateChat: () { _onCreateChat(context); },
      onChatTap: (chat) { _onChatTap(context, chat); },
    );
  }

  // Life cycle
  @override
  void initState() {
    super.initState();
    _loadChatList();
    _setupListeners();
  }

  @override
  void dispose() {
    _stopListeners();
    super.dispose();
  }

  // Setup listeners
  void _setupListeners() {
    _chatListUpdatesSubscription = _chatListService.startListenChatListUpdates(widget.user.id);
    _addChatListUpdatesHandlers(_chatListUpdatesSubscription);
  }

  void _stopListeners() {
    _chatListService.stopListenChatListUpdates();
    _chatListUpdatesSubscription?.cancel();
  }

  // Profile
  void _onAvatarTap(BuildContext context) {
    _navigateToProfile(context);
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ProfileScreen(user: widget.user)
        )
    );
  }

  // Create chat
  void _onCreateChat(BuildContext context) {
    _navigateToCreateChat(context);
  }

  void _navigateToCreateChat(BuildContext context) {
    final targetScreen = CreateChatScreen(currentUser: widget.user);
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => targetScreen,
          settings: RouteSettings(name: CreateChatScreen.routeName)
      )
    );
  }

  // Chat list
  void _loadChatList() {
    _chatListService
        .getChatList()
        .then((value) => _displayChatList(value))
        .catchError((error) => print(error));
  }

  void _displayChatList(List<Chat> chats) {
    setState(() {
      _chats = chats;
    });
  }

  // Chat list updates
  void _addChatListUpdatesHandlers(StreamSubscription<ChatListEvent> subscription) {
    subscription.onData((event) => _handleChatListUpdatesEvent(event));
    subscription.onError((error) => print('Error $error'));
  }

  void _handleChatListUpdatesEvent(ChatListEvent event) {
    switch (event.type) {
      case RemoteDBEventType.created:
        _handleChatListEventCreated(event.data);
        break;
      case RemoteDBEventType.updated:
        _handleChatListEventUpdated(event.data);
        break;
      case RemoteDBEventType.deleted:
        _handleChatListEventDeleted(event.data);
        break;
    }
  }
  
  void _handleChatListEventCreated(Chat chat) {
    final index = _findChatIndex(chat.id);
    if (index != -1) { return; }
    setState(() {
      _chats.insert(0, chat);
    });
  }

  void _handleChatListEventUpdated(Chat chat) {
    final index = _findChatIndex(chat.id);
    if (index == -1) { return; }
    setState(() {
      _chats[index] = chat;
    });
  }
  
  void _handleChatListEventDeleted(Chat chat) {
    final index = _findChatIndex(chat.id);
    if (index == -1) { return; }
    setState(() {
      _chats.removeAt(index);
    });
  }

  // Open chat
  void _onChatTap(BuildContext context, Chat chat) {
    _navigateToChat(context, chat);
  }

  void _navigateToChat(BuildContext context, Chat chat) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>
          ChatScreen(chat: chat, currentUser: widget.user))
    );
  }

  // Find chat
  int _findChatIndex(String chatId) {
    return _chats.indexWhere((element) => element.id == chatId);
  }

}