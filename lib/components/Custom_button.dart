import 'package:flutter/material.dart';

class Custom_button extends StatelessWidget {
  String? text;
  VoidCallback? ontap;

  Custom_button({this.ontap, super.key, this.text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.only(right: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Center(child: Text(text!)),
        // child: ElevatedButton(
        //   onPressed: () {},
        //   style: ElevatedButton.styleFrom(
        //     foregroundColor: Colors.black,
        //     backgroundColor: Colors.white, // Text color
        //   ),
        //   child: Text('Login'),
        // ),
      ),
    );
  }
}
