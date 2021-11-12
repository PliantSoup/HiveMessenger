import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:telemind/message_box.dart';
import 'package:web_socket_channel/io.dart';
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
  final String username;

  @override
  void dispose(){
    super.dispose();
    ws.sink.close();
  }
  @override
  void initState(){
    super.initState();
  }

  var ws = WebSocketChannel.connect(Uri.parse("ws://euph.ddns.net:1337"));
  List<Message> messages = [];

  ChatScreenState(this.username){
    ws = WebSocketChannel.connect(Uri.parse("ws://euph.ddns.net:1337"));
    messages = [];
    main();
  }

  main() async{
    ws.sink.add(username);

    ws.stream.listen((m) {
      final decoded = jsonDecode(m.toString());
      print(decoded);

      if (decoded["type"] == "message"){
        messages.add(Message.fromJson(decoded["data"]));
        setState(() {

        });
      }
      if (decoded["type"] == "history"){
        List? decodedList = decoded["data"];
        for (int i = 0; i<decodedList!.length; i++){
          messages.add(Message.fromJson(decodedList[i]));
        }
        setState(() {

        });
      }
    },
      onDone: () async {
        Fluttertoast.showToast(msg: "Тост из тостера");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return MessageBox(author: messages[index].author, text: messages[index].text, time: messages[index].time, color: messages[index].color);
                }
              )
            ),
            Align(
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
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
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Text("Send"),
                      onTap: (){
                        ws.sink.add(_controller.text);
                        _controller.clear();
                        setState(() {

                        });
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
