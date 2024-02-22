import 'package:flutter/material.dart';

import '../constants.dart';

class BubbleChat extends StatelessWidget {
  BubbleChat({
    this.message,
    this.messageColor,
    super.key,
  });
  Color? messageColor;
  String? message;

  @override
  Widget build(BuildContext context) {
    if (messageColor == null) {
      messageColor = kPrimaryColor;
    }

    if (message == null) {
      message = "iam the new user  ";
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // width: 150,
        // height: 65,
        // alignment: Alignment.centerLeft,
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
    if (messageColor == null) {
      messageColor = const Color(0xff006D84);
    }

    if (message == null) {
      message = "iam the new user  ";
    }

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
