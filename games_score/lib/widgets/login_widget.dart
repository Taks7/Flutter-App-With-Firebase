import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: emailController,
              cursorColor: Colors.amber,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Email"),
              obscureText: true,
            ),
            SizedBox(height: 6),
            TextField(
              controller: passwordController,
              cursorColor: Colors.amber,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(
                Icons.lock_outline,
                size: 32,
              ),
              label: Text(
                "Sign In",
                style: TextStyle(fontSize: 24),
              ),
              onPressed: signIn,
            )
          ],
        ),
      );

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}
