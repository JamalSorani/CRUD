import 'package:flutter/material.dart';
import '../widgets/lists.dart';
import '../widgets/inf.dart';
import '../widgets/my_bar.dart';

class EditUserScreen extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String id1;
  const EditUserScreen(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.mobile,
      required this.id1});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final formkey = GlobalKey<FormState>();
  final emailFocus = FocusNode();
  final mobileFocus = FocusNode();
  bool isLoading = false;
  var edit = const Inf(
    id: 1,
    id1: '',
    name: '',
    email: '',
    m: '',
  );

  @override
  void dispose() {
    emailFocus.dispose();
    mobileFocus.dispose();
    super.dispose();
  }

  void updateForm() async {
    formkey.currentState!.save();
    await updateUser(widget.id1, edit, context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Mybar(co1: Colors.black, co2: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Image(
                      image: AssetImage('images/draw.webp'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Edit User',
                      style: TextStyle(
                        color: Color.fromRGBO(37, 99, 235, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'User Name:',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: widget.name,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The name can\'t be null';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(emailFocus);
                      },
                      onSaved: (newValue) {
                        edit = Inf(
                          id: widget.id,
                          id1: widget.id1,
                          name: newValue!,
                          email: widget.email,
                          m: edit.m,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //////
                    ///
                    const Text(
                      'User Email:',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      initialValue: widget.email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      focusNode: emailFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(mobileFocus);
                      },
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Expected to exist @';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        edit = Inf(
                          id: widget.id,
                          id1: edit.id1,
                          name: edit.name,
                          email: newValue!,
                          m: edit.m,
                        );
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //
                    const Text(
                      'Mobile Phone:',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      focusNode: mobileFocus,
                      initialValue: widget.mobile,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                                .hasMatch(value)) {
                          return 'Enter correct mobile';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        String a = newValue!;
                        edit = Inf(
                          id: widget.id,
                          id1: edit.id1,
                          name: edit.name,
                          email: edit.email,
                          m: a,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.red,
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                updateForm();
                              }
                            },
                            child: const Text('Edit'),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
