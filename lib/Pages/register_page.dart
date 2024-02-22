import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/Custom_button.dart';
import '../components/Custom_Text_Field.dart';
import '../constants.dart';
import '../helper/ShowSnackBar.dart';
import 'Chat_Page.dart';

class Register_page extends StatefulWidget {
  Register_page({super.key});

  static String id = "registerpage";

  @override
  State<Register_page> createState() => _Register_pageState();
}

class _Register_pageState extends State<Register_page> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Scholar Chat",
                          style: TextStyle(
                              fontSize: 45,
                              color: Color(0xffE0E6EB),
                              fontFamily: 'pacifico')),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 55,
                ),
                const Row(
                  children: [
                    Text("Register",
                        style:
                            TextStyle(fontSize: 30, color: Color(0xffE0E6EB))),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Custom_Text_Form_Field(
                    Onchanged: (data) {
                      email = data;
                    },
                    name: "Email"),
                const SizedBox(
                  height: 10,
                ),
                Custom_Text_Form_Field(
                    Onchanged: (data) {
                      password = data;
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
                          // //
                          setState(() {
                            Indecator = true;
                          });
                          await RegisterUser();
                          setState(() {
                            Indecator = false;
                          });
                          // zakaaria@gmail.cpm
                          //Aa12@asfsf

                          // ShowSnackBar(
                          //
                          //
                          //    context,
                          //    text: "Registration success",
                          //  );
                          Navigator.pushNamed(context, Chat_Page.id);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            setState(() {
                              Indecator = false;
                            });
                            ShowSnackBar(
                              context,
                              text:
                                  'The account already exists for that email.',
                            );
                          } else {
                            setState(() {
                              Indecator = false;
                            });
                            ShowSnackBar(
                              context,
                              text:
                                  'There was an error please check your connection',
                            );
                          }
                        } catch (e) {
                          print(e);
                        }
                      } else {}

                      //
                      //
                      //
                    },
                    text: "Register"),
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
                          Navigator.pop(context);
                        },
                        child: const Text(
                          " Login",
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

  Future<void> RegisterUser() async {
    UserCredential User =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
