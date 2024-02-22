import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Pages/Chat_Page.dart';
import 'Pages/Login_Page.dart';
import 'Pages/register_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  //
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
      login_page.id: (context) => login_page(),
      Register_page.id: (context) => Register_page(),
      Chat_Page.id: (context) => Chat_Page(),
    }, debugShowCheckedModeBanner: false, initialRoute: login_page.id);
  }
}
