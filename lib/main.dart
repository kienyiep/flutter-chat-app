import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     body1: TextStyle(color: Colors.black54),
      //   ),
      // ),
      initialRoute: WelcomeScreen.id,
      routes: {
        //THIS WONT WORKS UNLESS THE navigator put the exact say key.
        // '/': (context) => WelcomeScreen(),
        // '/Login': (context) => LoginScreen(),
        // '/Registration': (context) => RegistrationScreen(),
        // '/Chat': (context) => ChatScreen(),

        //this will works
        // 'WelcomeScreen': (context) => WelcomeScreen(),
        // 'LoginScreen': (context) => LoginScreen(),
        // 'RegistrationScreen': (context) => RegistrationScreen(),
        // 'ChatScreen': (context) => ChatScreen(),

        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
