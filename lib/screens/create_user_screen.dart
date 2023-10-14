import 'package:crud/widgets/lists.dart';
import 'package:crud/widgets/inf.dart';
import 'package:flutter/material.dart';
import '../widgets/my_bar.dart';

class CreateUserScreen extends StatefulWidget {
  static const String create = '/create_user';
  const CreateUserScreen({Key? key}) : super(key: key);
  static int id = 2;
  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final formkey = GlobalKey<FormState>();
  final emailFocus = FocusNode();
  final mobileFocus = FocusNode();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool isLoading = false;
  var edit = Inf(
    id: 2,
    id1: DateTime.now().toString(),
    name: '',
    email: '',
    m: '0912345678',
  );
  @override
  void dispose() {
    emailFocus.dispose();
    mobileFocus.dispose();
    super.dispose();
  }

  void saveForm() async {
    formkey.currentState!.save();

    await addUser(
        Inf(
          id: CreateUserScreen.id++,
          id1: edit.id1,
          name: edit.name,
          email: edit.email,
          m: edit.m,
        ),
        context);
    setState(() {
      isLoading = false;
    });
    usernameController.clear();
    emailController.clear();
    mobileController.clear();
  }

  @override
  Widget build(BuildContext c) {
    return Builder(builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'Do you want to leave?',
                  textAlign: TextAlign.center,
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('NO'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('YES'),
                  ),
                ],
              );
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Mybar(co1: Colors.blue, co2: Colors.black),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
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
                            'Create User',
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
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'user name',
                            ),
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
                                id: CreateUserScreen.id,
                                id1: edit.id1,
                                name: newValue!,
                                email: edit.email,
                                m: edit.m,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          const Text(
                            'User Email:',
                            style: TextStyle(fontSize: 20),
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'email address'),
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
                                id: CreateUserScreen.id,
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
                            controller: mobileController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            focusNode: mobileFocus,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'mobile phone'),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                                      .hasMatch(value) ||
                                  value.length < 10) {
                                return 'Enter correct mobile';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              edit = Inf(
                                id: CreateUserScreen.id,
                                id1: edit.id1,
                                name: edit.name,
                                email: edit.email,
                                m: newValue!,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.red)
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(),
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      saveForm();
                                    }
                                  },
                                  child: const Text('SAVE'),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
