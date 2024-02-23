import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab3/auth/register_screen.dart';

import '../screens/home_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const String id = "signinScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  bool passwordError = false;
  bool emailError = false;
  String loginErrorMessage = "test";
  bool loginFail = false;

  Future _login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((value) =>
              // print("User signed in successfully!");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage())));
    } on FirebaseAuthException catch (e) {
      print("ERROR");
      print(e.message);
      loginFail = true;
      loginErrorMessage = e.message!;

      if (loginErrorMessage ==
          "There is no user record corresponding to this identifier. The user may have been deleted.") {
        emailError = true;
        loginErrorMessage = "User does not exist, please create new account";
      } else {
        passwordError = true;
        loginErrorMessage = "Password is incorrect";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                child: Column(children: <Widget>[
                  const SizedBox(height: 40),
                  const Text(
                    "Welcome",
                    style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _emailTextController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Email",
                        errorText: emailError ? loginErrorMessage : null),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _passwordTextController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelText: "Password",
                        errorText: passwordError ? loginErrorMessage : null),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    icon: const Icon(
                      Icons.lock_open_sharp,
                      size: 30,
                    ),
                    label: const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 22),
                    ),
                    onPressed: _login,
                  ),
                  const SizedBox(height: 20),
                  signUpOption()
                ]))));
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Create new Account:"),
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Register()));
            },
            child: const Text(
              " Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
