import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memechat/screens/auth_screen.dart';
import 'package:memechat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meme Chat',
        theme: ThemeData(
          backgroundColor: Colors.brown,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.grey,
            brightness: Brightness.dark,
          ).copyWith(
              secondary: Color.fromARGB(255, 139, 90, 72),
              brightness: Brightness.dark),
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.blueGrey,
            textTheme: ButtonTextTheme.accent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, userSnap) {
              if (userSnap.hasData) {
                return ChatScreen();
              }
              return AuthScreen();
            }));
  }
}
