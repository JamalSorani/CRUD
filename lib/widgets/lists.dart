import 'dart:convert';
import 'package:crud/widgets/inf.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/list_user.dart';

List<Inf> myList = [];

var noUsers = false;
Future<void> fetshAndSetUsers() async {
  final url =
      Uri.https('crud-ad31e-default-rtdb.firebaseio.com', '/lists.json');
  try {
    final response = await http.get(url);
    final extract = json.decode(response.body) as Map<String, dynamic>;

    List<Inf> loaded = [];
    extract.forEach(
      (userId, userData) {
        loaded.add(Inf(
            id: userData['id'],
            id1: userId,
            name: userData['Name'],
            email: userData['Email'],
            m: userData['m']));
      },
    );
    myList = loaded;
  } catch (error) {
    noUsers = true;
  }

  return;
}

Future<void> addUser(Inf user, context) async {
  final url =
      Uri.https('crud-ad31e-default-rtdb.firebaseio.com', '/lists.json');
  await http
      .post(url,
          body: json.encode({
            'id': user.id,
            'id1': DateTime.now().toString(),
            'Name': user.name,
            'Email': user.email,
            'm': user.m,
          }))
      .then((response) {
    final newUser = Inf(
        id: user.id,
        id1: json.decode(response.body)['name'],
        name: user.name,
        email: user.email,
        m: user.m);
    myList.add(newUser);
    Navigator.of(context).pushReplacementNamed(ListUserScreen.list);
  });
}

Future<void> updateUser(String id, Inf user, context) async {
  final index = myList.indexWhere((val) => val.id1 == id);

  final url =
      Uri.https('crud-ad31e-default-rtdb.firebaseio.com', '/lists/$id.json');
  await http.patch(url,
      body: json.encode({
        'Name': user.name,
        'Email': user.email,
        'm': user.m,
      }));
  myList[index] = user;
  fetshAndSetUsers();
  Navigator.of(context).pushReplacementNamed(ListUserScreen.list);
}

Future<void> deleteUser(String id, context) async {
  final url =
      Uri.https('crud-ad31e-default-rtdb.firebaseio.com', '/lists/$id.json');
  var index = myList.indexWhere((element) => element.id1 == id);
  final deletedUser = myList[index];
  await http.delete(url).then((value) => null).catchError((_) {
    myList.insert(index, deletedUser);
  });
  myList.removeAt(index);
  Navigator.of(context).pushReplacementNamed(ListUserScreen.list);
}
