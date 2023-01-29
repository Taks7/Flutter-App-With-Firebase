import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
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
              height: 60,
            ),
            FlutterLogo(
              size: 120,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome to the \n Game Searcher!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
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
                "Sign Up",
                style: TextStyle(fontSize: 24),
              ),
              onPressed: signUp,
            ),
            SizedBox(
              height: 24,
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    text: "Already have an account? ",
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: "Log In",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary)),
                ]))
          ],
        ),
      );

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}