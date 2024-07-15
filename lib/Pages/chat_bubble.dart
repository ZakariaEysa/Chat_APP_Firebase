import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
   ChatBubble({
    this.message,
    this.messageColor,
    super.key,
  });
    Color? messageColor;
   String? message;

  @override
  Widget build(BuildContext context) {
    messageColor ??= kPrimaryColor;

    message ??= "iam the new user  ";

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(

        padding:
            const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            color: messageColor),
        child: Text(
          message!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class BubbleChatForAfriend extends StatelessWidget {
  BubbleChatForAfriend({
    this.message,
    this.messageColor,
    super.key,
  });
  Color? messageColor;
  String? message;

  @override
  Widget build(BuildContext context) {
    messageColor ??= const Color(0xff006D84);

    message ??= "iam the new user  ";

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // width: 150,
        // height: 65,
        // alignment: Alignment.centerLeft,
        padding:
            const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            color: messageColor),
        child: Text(
          message!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
