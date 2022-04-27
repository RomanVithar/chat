import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer';
import 'dart:async';
import 'dart:convert';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'dart:developer';

import '../models/chatMessageModel.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatMessage> messages = [];
  final _inputController = TextEditingController();
  var stompClient;
  final ScrollController _scrollController = ScrollController();

  Future<String?> _getToken() async {
    final storage = new FlutterSecureStorage();
    String? test = await storage.read(key: 'jwt');
    return test;
  }

  void showToken() async {
    print(await _getToken());
  }

  @override
  void initState() {
    showToken();
    super.initState();
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/chatapp/websocket',
        onConnect: (StompFrame frame) {
          stompClient.subscribe(
              destination: '/topic/messages',
              callback: (frame) {
                Map<String, dynamic> result = json.decode(frame.body!);
                _addMessage(result['content']);
              });
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
        stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
        webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
      ),
    );
    stompClient.activate();
    messages.addAll([
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(
          messageContent: "How have you been?", messageType: "receiver"),
      ChatMessage(
          messageContent: "Hey Kriss, I am doing fine dude. wbu?",
          messageType: "sender"),
      ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
      ChatMessage(
          messageContent: "Is there any thing wrong?", messageType: "sender")
    ]);
  }

  void _addMessage(String text) {
    setState(() {
      messages.add(ChatMessage(messageContent: text, messageType: "sender"));
      _inputController.text = "";
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: Duration(microseconds: 500),
          curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat Detail"),
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              controller: _scrollController,
              child: ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 70),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType == "receiver"
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          messages[index].messageContent,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _inputController,
                        autofocus: false,
                        decoration: const InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                        onSubmitted: (text) {
                          if (text.isNotEmpty) {
                            _addMessage(text);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        if (_inputController.text.isNotEmpty) {
                          _addMessage(_inputController.text);
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
