import 'package:crud/widgets/lists.dart';
import 'package:flutter/material.dart';

import '../screens/edit_user_screen.dart';

class Inf extends StatefulWidget {
  final int id;
  final String id1;
  final String name;
  final String email;
  final String m;
  const Inf({
    super.key,
    required this.id,
    required this.id1,
    required this.name,
    required this.email,
    required this.m,
  });

  @override
  State<Inf> createState() => _InfState();
}

// ignore: camel_case_types
class _InfState extends State<Inf> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double x1 = mediaQuery.size.width * 0.05;
    double x2 = (mediaQuery.size.width - x1) * 0.13;
    double x3 = (mediaQuery.size.width - x2) * 0.33;
    double x4 = (mediaQuery.size.width - x3) * 0.28;
    double x5 = (mediaQuery.size.width - x4) * 0.1;
    double x6 = (mediaQuery.size.width - x5) * 0.12;
    return Dismissible(
      key: ValueKey(widget.id1),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        deleteUser(widget.id1, context);
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: x1,
                  child: Text(
                    textAlign: TextAlign.center,
                    '${widget.id}',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: x2,
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.name,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: x3,
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.email,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: x4,
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.m,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => EditUserScreen(
                              id: widget.id,
                              id1: widget.id1,
                              name: widget.name,
                              email: widget.email,
                              mobile: widget.m,
                            )));
                  },
                  child: Container(
                    height: 30,
                    color: Colors.blue,
                    width: x6,
                    child: const Center(
                      child: Text(
                        'Edit',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await deleteUser(widget.id1, context);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Container(
                    height: 30,
                    color: Colors.red,
                    width: x6,
                    child: Center(
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Delete',
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
