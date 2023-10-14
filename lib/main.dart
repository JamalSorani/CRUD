import '/screens/list_user.dart';
import '/screens/create_user_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CreateUserScreen(),
      routes: {
        CreateUserScreen.create: (context) => const CreateUserScreen(),
        ListUserScreen.list: (context) => const ListUserScreen(),
      },
    );
  }
}
