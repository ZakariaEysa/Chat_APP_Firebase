import 'package:firebase/Pages/chat_page.dart';
import 'package:firebase/Pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../constants.dart';
import '../helper/show_snack_bar.dart';

class LoginPage extends StatefulWidget {
   const LoginPage({super.key});

  static String id = "login_page";
  // String  GGMAIL= "zakaria@gmail.cpm";
  // String Passsword="Aa12@asfsf";
   //   zzzz@gmail.com
  // Aa12@asfsf

  @override
  State<LoginPage> createState() => _Register_pageState();
}

class _Register_pageState extends State<LoginPage> {
  String? email;

  String? password;

  bool indicator = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext _context) {
    return ModalProgressHUD(
      inAsyncCall: indicator,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  kLogo,
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Scholar Chat",
                        style: TextStyle(
                            fontSize: 45,
                            color: Color(0xffE0E6EB),
                            fontFamily: 'pacifico')),
                  ],
                ),
                const SizedBox(
                  height: 55,
                ),
                const Row(
                  children: [
                    Text("Login",
                        style:
                            TextStyle(fontSize: 30, color: Color(0xffE0E6EB))),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    onChanged: (data) {
                      email = data.trim();
                    },
                    name: "Email"),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                    onChanged: (data) {
                      password = data;
                      //password=password!.replaceAll(" ","" );
                    },
                    name: "Password"),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    // ontap:(){
                    //   email="sdfsdf";
                    // },
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          //
                          setState(() {
                            indicator = true;
                          });
                          await loginUser();
                          setState(() {
                            indicator = false;
                          });
                          //     zakaaria@gmail.cpm
                          //    Aa12@asfsf

                          //   zakaria@gmail.cpmm

                          showSnackBar(
                            _context,
                            text: "Login success",
                          );
                          Navigator.pushNamed(_context, ChatPage.id,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            indicator = false;
                          });
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                              _context,
                              text: 'No user found for that email.',
                            );
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(
                              context,
                              text: 'Wrong password provided for that user.',
                            );
                          } else if (e.code == 'invalid-credential') {
                            showSnackBar(
                              _context,
                              text: ' Please check your email and password.',
                            );
                          } else {
                            showSnackBar(
                              _context,
                              text:
                                  'An error occurred. Please check your connection.',
                            );
                          }

                        }
                      } else {}
                    },
                    text: "Login"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "don't have an account ? ",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(_context, RegisterPage.id);
                        },
                        child: const Text(
                          " Register",
                          style: TextStyle(color: Color(0xffC7EDE6)),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
     await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
