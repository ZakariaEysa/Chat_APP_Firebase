import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        text,
        style: const TextStyle(color: Colors.purple),
      )));
}