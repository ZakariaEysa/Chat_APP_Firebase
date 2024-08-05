import 'package:firebase/Pages/chat_page.dart';
import 'package:firebase/Pages/register_page.dart';
import 'package:firebase/cubits/auth/auth_cubit.dart';
import 'package:firebase/cubits/chat/chat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../constants.dart';
import '../helper/show_snack_bar.dart';

class LoginPage extends StatelessWidget {
  static String id = "login_page";

  String? email;

  String? password;

  bool indicator = false;

  GlobalKey<FormState> formKey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          indicator = true;
        } else if (state is LoginSuccess) {
          indicator = false;

          BlocProvider.of<ChatCubit>(context).getMessages();

          Navigator.pushNamed(context, ChatPage.id);
        } else if (state is LoginFailure) {
          indicator = false;
          showSnackBar(context, text: state.error);
        }
      },
      child: ModalProgressHUD(
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
                          style: TextStyle(
                              fontSize: 30, color: Color(0xffE0E6EB))),
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
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            BlocProvider.of<AuthCubit>(context)
                                .loginUser(email: email!, password: password!);
                          } on FirebaseAuthException catch (e) {}
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
                            Navigator.pushNamed(context, RegisterPage.id);
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
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
