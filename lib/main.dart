import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Pages/chat_page.dart';
import 'Pages/login_page.dart';
import 'Pages/register_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      LoginPage.id: (context) => const LoginPage(),
      RegisterPage.id: (context) => const RegisterPage(),
      ChatPage.id: (context) => const ChatPage(),
    }, debugShowCheckedModeBanner: false, initialRoute: LoginPage.id);
  }
}
