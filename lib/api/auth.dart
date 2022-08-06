import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

const String allowCORSEndPoint = "https://api.allorigins.win/raw?url=";

class User {
  final String username;
  final String email;
  final String token;

  const User(
      {required this.username, required this.email, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      token: json['token'],
    );
  }
}

Future<User> register(String email, String username, String password) async {
  final response = await http.post(
    Uri.parse(
        '${allowCORSEndPoint}https://log-reg.herokuapp.com/api/users/register.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    Fluttertoast.showToast(
        msg: "REGISTRATION SUCCESSFUL",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    print('Registered');
    return User.fromJson(jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(
        msg: "REGISTRATION FAILED",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    throw Exception('Failed to create user.');
  }
}

Future<User> login(String email, String password) async {
  final response = await http.post(
    Uri.parse(
        '${allowCORSEndPoint}https://log-reg.herokuapp.com/api/users/login.php'),
    // Uri.parse('http://localhost:80/log_reg_api/api/users/login.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    Fluttertoast.showToast(
        msg: "LOGGED IN",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    print('Logged in');
    return User.fromJson(jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(
        msg: "LOG IN FAILED",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    throw Exception('Failed to login.');
  }
}
