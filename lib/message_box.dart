import 'package:flutter/cupertino.dart';
import 'package:flutter95/flutter95.dart';

class MessageBox extends StatelessWidget {
  const MessageBox(
      {Key? key,
      required this.author,
      required this.text,
      required this.time,
      required this.color})
      : super(key: key);

  final String author;
  final String text;
  final Color color;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(author, style: TextStyle(fontSize: 20, color: color)),
                Text(time.toString()),
              ]),
            Container(
              margin: const EdgeInsets.only(top: 10,bottom: 10),
              child: Row(children: <Widget>[Text(text, style: const TextStyle(fontSize: 15))]),
            )
          ]
      ),
    );
  }
}
