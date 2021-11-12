import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:telemind/chat.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold95(
      title: widget.title,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 110, right: 110, top: 250),
              child: TextField95(
                controller: _controller,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 80),
                child: Button95(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 35, vertical: 4),
                    onTap: () {
                      _controller.text.isNotEmpty
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(username: _controller.text)))
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text("Введите никнейм"),
                                );
                              });
                    },
                    child: const Text("Войти")))
            //Container(
            //child: TextButton(onPressed: null, child: Text("Login")),
            //)
          ],
        ),
      ),
    );
  }
}
