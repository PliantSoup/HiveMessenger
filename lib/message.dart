import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Message {
  final String text;
  final String author;
  final Color color;
  final DateTime time;

  static const Map<String, dynamic> colors = {
    "blue": Colors.blue,
    "yellow": Colors.yellow,
    "red": Colors.red,
    "green": Colors.green,
    "purple": Colors.purple,
  };

  const Message(this.text, this.author, this.color, this.time);

  Message.fromJson(Map<String, dynamic> json)
      : text = json["text"],
        author = json["author"],
        time = DateTime.fromMillisecondsSinceEpoch(json["time"]),
        color = colors[json["color"]];
}
