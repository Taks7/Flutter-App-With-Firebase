import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

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
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            const Icon(
              BoxIcons.bxs_game,
              color: Colors.amber,
              size: 120,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Hey There, \n Welcome Back!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              controller: emailController,
              cursorColor: Colors.amber,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Email"),
              obscureText: false,
            ),
            const SizedBox(height: 6),
            TextField(
              controller: passwordController,
              cursorColor: Colors.amber,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.black,
              ),
              icon: const Icon(
                Icons.lock_outline,
                size: 32,
                color: Colors.amber,
              ),
              label: const Text(
                "Sign In",
                style: TextStyle(fontSize: 24, color: Colors.amber),
              ),
              onPressed: signIn,
            ),
            const SizedBox(
              height: 24,
            ),
            RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    text: "No Account? ",
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: "Sign Up",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary)),
                ]))
          ],
        ),
      );

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}
