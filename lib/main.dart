import 'package:firebase/cubits/chat/chat_cubit.dart';
import 'package:firebase/cubits/register/register_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/chat_page.dart';
import 'Pages/login_page.dart';
import 'Pages/register_page.dart';
import 'cubits/login/login_cubit.dart';
import 'firebase_options.dart';

// qqq@gmail.com
// Aa12@asfsf
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],

      // qqwweerr
      //Aa@1122

      child: MaterialApp(routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(),
      }, debugShowCheckedModeBanner: false, initialRoute: LoginPage.id),
    );
  }
}
