import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:icons_plus/icons_plus.dart';

// We have used https://pub.dev/packages/email_validator
//To validate the emails introduced in the Sign Up process

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
  final formKey = GlobalKey<FormState>();
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
        child: Form(
          key: formKey,
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
                "Welcome to the \n Game Searcher!",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.amber,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: "Email"),
                obscureText: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? "Enter a Valid Email"
                        : null,
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: passwordController,
                cursorColor: Colors.amber,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? "Enter a minimum of 6 characters"
                    : null,
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
                  "Sign Up",
                  style: TextStyle(fontSize: 24, color: Colors.amber),
                ),
                onPressed: signUp,
              ),
              const SizedBox(
                height: 24,
              ),
              RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 20),
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
        ),
      );

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}
