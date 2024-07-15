import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
 final  String? text;
  final VoidCallback? onTap;

  const  CustomButton({this.onTap, super.key, this.text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.only(right: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Center(child: Text(text!)),

      ),
    );
  }
}
