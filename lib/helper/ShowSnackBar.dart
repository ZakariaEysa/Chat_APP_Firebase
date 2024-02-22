import 'package:flutter/material.dart';

  void ShowSnackBar(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          text!,
          style: TextStyle(color: Colors.purple),
        )));
  }

