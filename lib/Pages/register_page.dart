import 'package:firebase/Pages/login_page.dart';
import 'package:firebase/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../constants.dart';
import '../cubits/chat/chat_cubit.dart';
import '../helper/show_snack_bar.dart';
import 'chat_page.dart';

class RegisterPage extends StatelessWidget {
  static String id = "RegisterPage";

  String? email;

  String? password;

  bool indicator = false;

  GlobalKey<FormState> formKey = GlobalKey();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            indicator = true;
          } else if (state is RegisterSuccess) {
            indicator = false;
            BlocProvider.of<ChatCubit>(context).getMessages();

            Navigator.pushReplacementNamed(context, ChatPage.id);
          } else if (state is RegisterFailure) {
            indicator = false;
            showSnackBar(context, text: state.error);
          }
        },
        builder: (context, state) => ModalProgressHUD(
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
                                style: TextStyle(
                                    fontSize: 30, color: Color(0xffE0E6EB))),
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
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthCubit>(context)
                                    .registerUser(
                                        email: email, password: password);
                              } else {}
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
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, LoginPage.id);
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
            ));
  }
}
