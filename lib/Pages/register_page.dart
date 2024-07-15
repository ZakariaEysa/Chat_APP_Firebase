import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../constants.dart';
import '../helper/show_snack_bar.dart';
import 'chat_page.dart';

class RegisterPage extends StatefulWidget {
   const RegisterPage({super.key});

  static String id = "registerpage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  bool indicator = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                    Text("Register",
                        style:
                            TextStyle(fontSize: 30, color: Color(0xffE0E6EB))),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    onChanged: (data) {
                      email = data;
                    },
                    name: "Email"),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                    onChanged: (data) {
                      password = data;
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
                          // //
                          setState(() {
                            indicator = true;
                          });
                          await registerUser();
                          setState(() {
                            indicator = false;
                          });
                          // zakaaria@gmail.cpm
                          //Aa12@asfsf

                          // ShowSnackBar(
                          //
                          //
                          //    context,
                          //    text: "Registration success",
                          //  );
                          Navigator.pushNamed(context, ChatPage.id);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            setState(() {
                              indicator = false;
                            });
                            showSnackBar(
                              context,
                              text:
                                  'The account already exists for that email.',
                            );
                          } else {
                            setState(() {
                              indicator = false;
                            });
                            showSnackBar(
                              context,
                              text:
                                  'There was an error please check your connection',
                            );
                          }
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

  Future<void> registerUser() async {

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
