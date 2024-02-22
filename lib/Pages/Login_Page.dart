import 'package:firebase/Pages/Chat_Page.dart';
import 'package:firebase/Pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/Custom_button.dart';
import '../components/Custom_Text_Field.dart';
import '../constants.dart';
import '../helper/ShowSnackBar.dart';

class login_page extends StatefulWidget {
  login_page({super.key});

  static String id = "login_page";
  // String  GGMAIL= "zakaria@gmail.cpm";
  // String Passsword="Aa12@asfsf";

  @override
  State<login_page> createState() => _Register_pageState();
}

class _Register_pageState extends State<login_page> {
  String? email;

  String? password;

  bool Indecator = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Indecator,
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
                Custom_Text_Form_Field(
                    Onchanged: (data) {
                      email = data.trim();
                    },
                    name: "Email"),
                const SizedBox(
                  height: 10,
                ),
                Custom_Text_Form_Field(
                    Onchanged: (data) {
                      password = data;
                      //password=password!.replaceAll(" ","" );
                    },
                    name: "Password"),
                const SizedBox(
                  height: 20,
                ),
                Custom_button(
                    // ontap:(){
                    //   email="sdfsdf";
                    // },
                    ontap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          //
                          setState(() {
                            Indecator = true;
                          });
                          await LoginUser();
                          setState(() {
                            Indecator = false;
                          });
                          //     zakaaria@gmail.cpm
                          //    Aa12@asfsf

                          //   zakaria@gmail.cpmm

                          ShowSnackBar(
                            context,
                            text: "Login success",
                          );
                          Navigator.pushNamed(context, Chat_Page.id,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            Indecator = false;
                          });
                          if (e.code == 'user-not-found') {
                            ShowSnackBar(
                              context,
                              text: 'No user found for that email.',
                            );
                          } else if (e.code == 'wrong-password') {
                            ShowSnackBar(
                              context,
                              text: 'Wrong password provided for that user.',
                            );
                          } else if (e.code == 'invalid-credential') {
                            ShowSnackBar(
                              context,
                              text: ' Please check your email and password.',
                            );
                          } else {
                            ShowSnackBar(
                              context,
                              text:
                                  'An error occurred. Please check your connection.',
                            );
                          }
                          print(e.code);
                          print("************************");
                        } catch (e) {
                          print(e);
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
                          Navigator.pushNamed(context, Register_page.id);
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

  Future<void> LoginUser() async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
