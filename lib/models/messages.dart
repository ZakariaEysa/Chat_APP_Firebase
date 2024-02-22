import 'package:flutter/material.dart';

import '../constants.dart';

class Message {
  Message(this.message, this.id);

  final String message;
  final String id;

  factory Message.fromjson(Jsondata) {
    return Message(Jsondata[kMessage], Jsondata['id']);
  }
}
