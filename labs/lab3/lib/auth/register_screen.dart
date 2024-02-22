import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static const String id = "registerScreen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<Register> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  Future _register() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((value) =>
              // print("Created new account");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage())));
    } on FirebaseAuthException catch (e) {
      print("ERROR!");
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "Sign Up",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                child: Column(children: <Widget>[
                  const SizedBox(height: 40),
                  TextField(
                    controller: _emailTextController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: "Enter Email"),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _passwordTextController,
                    textInputAction: TextInputAction.done,
                    decoration:
                        const InputDecoration(labelText: "Enter Password"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    icon: const Icon(
                      Icons.lock_open,
                      size: 32,
                    ),
                    label: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: _register,
                  ),
                ]))));
  }
}
