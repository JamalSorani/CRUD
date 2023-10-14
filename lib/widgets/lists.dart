import 'dart:convert';
import 'package:crud/widgets/inf.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/list_user.dart';

List<inf> myList = [];

class Lists with ChangeNotifier {
  String id2;
  String Name;
  final String Email;
  final int Mobile;
  Lists(this.id2, this.Name, this.Email, this.Mobile);
}

var noUsers = false;
Future<void> fetshAndSetUsers() async {
  final url =
      Uri.https('crud-ad31e-default-rtdb.firebaseio.com', '/lists.json');
  try {
    final response = await http.get(url);
    final extract = json.decode(response.body) as Map<String, dynamic>;

    List<inf> loaded = [];
    extract.forEach(
      (userId, userData) {
        loaded.add(inf(
            id: userData['id'],
            id1: userId,
            Name: userData['Name'],
            Email: userData['Email'],
            m: userData['m']));
      },
    );
    myList = loaded;
  } catch (error) {
    noUsers = true;
  }

  return;
}

Future<void> addUser(inf user, context) async {
  final url =
      Uri.https('crud-ad31e-default-rtdb.firebaseio.com', '/lists.json');
  await http
      .post(url,
          body: json.encode({
            'id': user.id,
            'id1': DateTime.now().toString(),
            'Name': user.Name,
            'Email': user.Email,
            'm': user.m,
          }))
      .then((response) {
    final newUser = inf(
        id: user.id,
        id1: json.decode(response.body)['name'],
        Name: user.Name,
        Email: user.Email,
        m: user.m);
    myList.add(newUser);
    Navigator.of(context).pushNamed(ListUserScreen.list);
  });
}

Future<void> updateUser(String id, inf user, context) async {
  final index = myList.indexWhere((val) => val.id1 == id);

  final url =
      Uri.https('crud-ad31e-default-rtdb.firebaseio.com', '/lists/$id.json');
  await http.patch(url,
      body: json.encode({
        'Name': user.Name,
        'Email': user.Email,
        'm': user.m,
      }));
  myList[index] = user;
  fetshAndSetUsers();
  Navigator.of(context).pushNamed(ListUserScreen.list);
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
  Navigator.of(context).pushNamed(ListUserScreen.list);
}
