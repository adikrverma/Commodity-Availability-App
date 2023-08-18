import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Sadminpage.dart';
import 'stationery_page.dart';
import 'knadminpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    final email = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Check if email and password are correct
    if (email == 'admin@gmail.com' && password == 'admin123' ||
        email == 'user@gmail.com' && password == 'user123') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(
              key: Key('my_home_page'), title: 'Commodity Management')));
    } else if (email == 'kn1@gmail.com' && password == 'kn123' ||
        email == 'kn2@gmail.com' && password == 'kn456') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => KnAdminPage(
              key: Key('kn_admin_page'), title: 'KN Foods Management')));
    } else {
      // Show an error message if email or password is incorrect
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Login Error'),
          content: Text('Incorrect email or password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Email', filled: true)),
            SizedBox(height: 16.0),
            TextField(
                controller: _passwordController,
                decoration:
                    InputDecoration(labelText: 'Password', filled: true),
                obscureText: true),
            SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: _login,
                child: Text('Admin Login'),
                style: ElevatedButton.styleFrom(primary: Colors.blueAccent)),
          ])),
    );
  }
}
