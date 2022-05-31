import 'dart:html';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:developer';
import 'dart:async';
import 'dart:convert';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

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
  late var storage = LocalStorage("chat");
  String? _token;
  String? _login;

  @override
  void initState() {
    super.initState();
    storage;
    _token = storage.getItem('jwt');
    _login = storage.getItem('login');
    _addHistory();
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/chatapp/websocket',
        onConnect: (StompFrame frame) async {
          stompClient.subscribe(
              destination: '/topic/messages',
              callback: (frame) {
                Map<String, dynamic> result = json.decode(frame.body!);
                String messageType = 'sender';
                if (result['receiver'] != _login) {
                  messageType = 'receiver';
                }
                _showMessage(
                    result['content'], messageType, _login.toString());
              });
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
      ),
    );
    stompClient.activate();
  }

  void _showMessage(String text, String messageType, String receiver) {
    messages.add(ChatMessage(
        messageContent: text, messageType: messageType, receiver: receiver));
    setState(() {
      _inputController.text = "";
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: Duration(microseconds: 500),
          curve: Curves.ease);
    });
  }

  Future<void> _addMessage(String text) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/send-message'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': _token.toString(),
      },
      body: jsonEncode(<String, String>{'messageContent': text}),
    );
    if (response.statusCode != 200) {
      _showMessage('message don\'t send', "notification", _login.toString());
    }
  }

  Future<void> _addHistory() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/api/v1/message'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': _token.toString(),
      },
    );
    if (response.statusCode == 200) {
      List messagesDict = jsonDecode(response.body);
      for (var item in messagesDict) {
        var messageType = 'receiver';
        if (item['user']['login'] == _login) {
          messageType = 'sender';
        }
        _showMessage(item['content'], messageType, item['user']['login']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
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
                        child: Column(
                          children: [
                            Text(
                              messages[index].receiver,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    (messages[index].messageType == "receiver"
                                        ? Colors.grey.shade200
                                        : Colors.blue[200]),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(
                                messages[index].messageContent,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        )),
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
                    // button for add file to message
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //     height: 30,
                    //     width: 30,
                    //     decoration: BoxDecoration(
                    //       color: Colors.lightBlue,
                    //       borderRadius: BorderRadius.circular(30),
                    //     ),
                    //     child: const Icon(
                    //       Icons.add,
                    //       color: Colors.white,
                    //       size: 20,
                    //     ),
                    //   ),
                    // ),
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
