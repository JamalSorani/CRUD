import 'package:flutter/material.dart';

import '../screens/create_user_screen.dart';
import '../screens/list_user.dart';

class Mybar extends StatelessWidget {
  final Color co1;
  final Color co2;

  const Mybar({super.key, required this.co1, required this.co2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(CreateUserScreen.create);
                },
                child: const Text(
                  'ums',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(CreateUserScreen.create);
                  co2 == Colors.blue ? Navigator.of(context).pop() : co2;
                },
                child: Text(
                  'Create User',
                  style: TextStyle(color: co1),
                )),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ListUserScreen.list);
              },
              child: Text(
                'List users',
                style: TextStyle(color: co2),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
