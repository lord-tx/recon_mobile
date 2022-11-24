import 'package:flutter/material.dart';
import 'package:recon_mobile/chat_view.dart';

import 'dummy_data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'ReCon';
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(0, 128, 183, 1),
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        cardColor: const Color.fromRGBO(217, 217, 217, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(0, 128, 183, 1),
          foregroundColor: Color.fromRGBO(255, 255, 255, 1),
          titleTextStyle: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: ""
          )
        )
      ),
      title: title,
      home: ChatView(
        currentUser: users.first,
      ),
    );
  }
}