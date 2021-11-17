import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final String time;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(225, 225, 225, 100),
            border: Border.all(
              color: const Color.fromRGBO(180, 180, 180, 100)
            )
          ),
          margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
          //color: Color.fromRGBO(225, 225, 225, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(author,
                      style: TextStyle(
                        color: color,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      )),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                child: Row(children: <Widget>[
                  LimitedBox(
                    maxWidth: MediaQuery.of(context).size.width - 25,
                    child: Text(
                      text,
                      style: Flutter95.textStyle,
                    ),
                  )
              ]),
            )
          ]),
    ));
  }
}
