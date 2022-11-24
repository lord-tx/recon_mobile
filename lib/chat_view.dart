import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recon_mobile/user_model.dart';
import 'package:recon_mobile/utils.dart';
import 'package:web_socket_channel/io.dart';

import 'chat_model.dart';

class ChatView extends StatefulWidget {
  /// This variable would be moved to the ViewModel
  final User currentUser;

  const ChatView({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

  final thisUserId = 1;
  late int roomId;
  late final IOWebSocketChannel _channel;
  final _controller = TextEditingController();
  late final StreamSubscription<dynamic> socketStream;
  late List<ChatModel>? messageList;

  String getValue(bool state){
    return state ? "online" : "offline";
  }

  Widget profileHeader(BuildContext context, {String? imageLink, String? name, bool? state}){
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageLink ?? ""),
      ),
      title: Text(name.toString(), style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),
      subtitle: Text(getValue(state ?? false), style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),
      trailing: const Icon(Icons.phone),
    );
  }

  @override
  void initState() {
    super.initState();
    messageList = [];
    setupChannel();
  }

  void setupChannel() async {
    String baseUrl = 'ws://192.168.0.106:3000/ws/';
    roomId = thisUserId + widget.currentUser.id!;
    if (kDebugMode) {
      print(baseUrl+roomId.toString());
    }
    _channel = IOWebSocketChannel.connect(Uri.parse(baseUrl+roomId.toString()));
    socketStream = _channel.stream.listen((event) {
      /// Get New Model and Map to new bubble
      ChatModel? newMessage = parseMessage(event);
      addMessage(newMessage);

      /// Ensure uniqueness
      setState(() {
        print("MessageList: $messageList");
      });
    });
  }

  bool addMessage(ChatModel? newMessage){
    print(newMessage);


    /// Shortcut method
    if (messageList?.isEmpty ?? false){
      newMessage != null ? messageList?.add(newMessage) : null;
    } else if (messageList?.last.messageId != newMessage?.messageId){
      newMessage != null ? messageList?.add(newMessage) : null;
    }

    /// Slow method
    // for (ChatModel message in messageList!){
    //   if (message.messageId == newMessage?.messageId){
    //     return false;
    //   }
    // }
    //
    // /// Add item if not found;
    // newMessage ?? messageList?.add(newMessage!);

    return true;
  }

  String generateMessageId(){
    return DateTime.now().toString();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      ChatModel message = createMessage(
        roomId: roomId,
        senderId: thisUserId,
        receiverId: widget.currentUser.id ?? 0,
        message: _controller.text,
        /// For now, text only
        messageType: "text",
        messageId: generateMessageId()
      );

      var jsonMessage = message.toJson();
      var jsonEncoding = json.encode(jsonMessage);

      if (kDebugMode) {
        print("This is the jsonMessage $jsonEncoding");
      }
      // _channel.sink.add(_controller.text);
      _channel.sink.add(jsonEncoding);
    }
    // setState(() {
    //   _controller.clear();
    // });
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: profileHeader(
          context,
          imageLink: widget.currentUser.profilePic,
          name: widget.currentUser.name,
          state: widget.currentUser.state
        ),
      ),
      body: ListView.builder(
        itemCount: messageList?.length,
        itemBuilder: (context, index){
          return createBubble(messageList![index], thisUserId);
        },
      ),
      floatingActionButton: Container(
        color: const Color.fromRGBO(217, 217, 217, 1),
        padding: const EdgeInsets.all(15.0),
        height: 100,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                      hintText: "Type Something...",
                      hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(width: 15),
            IconButton(
              splashColor: Colors.green,
              color: Theme.of(context).primaryColor,
              onPressed: (){
                _sendMessage();
              },
              icon: const Icon(Icons.send,),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

