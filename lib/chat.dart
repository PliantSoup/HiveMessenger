import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:telemind/message_box.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<ChatScreen> createState() => ChatScreenState(username);
}

class ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final String username;

  late var ws;
  late List<Message> messages;
  bool _needsScroll = false;
  bool _enableScrollButton = false;

  @override
  void dispose() {
    super.dispose();
    ws.sink.close();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
  }

  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  ChatScreenState(this.username) {
    ws = WebSocketChannel.connect(Uri.parse("ws://euph.ddns.net:1337"));
    messages = [];
    main();
  }

  main() async {
    ws.sink.add(username);

    ws.stream.listen(
      (m) {
        final decoded = jsonDecode(m.toString());

        if (decoded["type"] == "message") {
          messages.add(Message.fromJson(decoded["data"]));
          _needsScroll = true;
          setState(() {});
        }
        if (decoded["type"] == "history") {
          List? decodedList = decoded["data"];
          for (int i = 0; i < decodedList!.length; i++) {
            messages.add(Message.fromJson(decodedList[i]));
          }
          _needsScroll = true;
          setState(() {});
        }
      },
      onDone: () async {
        Fluttertoast.showToast(msg: "Тост из тостера");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_needsScroll) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
      _needsScroll = false;
    }
    return Scaffold(
        body: Stack(
          children: [
          Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(
              child: Scaffold95(
                title: widget.username,
                body: Container(),
              ),
            ),
            Flexible(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return MessageBox(
                          author: messages[index].author,
                          text: messages[index].text,
                          time: messages[index].time,
                          color: messages[index].color);
                    })),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 2),
                      child: TextField95(
                        height: 70,
                        maxLines: 5,
                        multiline: true,
                        controller: _controller,
                      ),
                    ),
                  ),
                  Button95(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: const Text("Send"),
                    onTap: () {
                      if (_controller.text.isNotEmpty) {
                        if (LineSplitter.split(_controller.text).last.isEmpty) {
                          String newMessage = _controller.text.trim();
                          ws.sink.add(newMessage);
                          _controller.clear();
                          _scrollToEnd();
                        } else {
                          ws.sink.add(_controller.text);
                          _controller.clear();
                          _scrollToEnd();
                        }
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        // Container(
        //   alignment: Alignment.bottomRight,
        //   padding: const EdgeInsets.only(right: 5, bottom: 90),
        //   child: Elevation95(
        //     child: Button95(
        //         onTap: () {
        //           _scrollController
        //               .jumpTo(_scrollController.position.maxScrollExtent);
        //         },
        //         child: const Icon(Icons.navigation)),
        //   ),
        // ),
      ],
    ));
  }
}
