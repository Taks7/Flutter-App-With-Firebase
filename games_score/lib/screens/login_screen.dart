import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter/material.dart';
import 'package:games_score/screens/auth_screen.dart';
import 'package:google_fonts/google_fonts.dart';

//We have used https://pub.dev/packages/flutter_animated_button
//for the animated button and we have also used
//https://pub.dev/packages/google_fonts for the different font

class login_screen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<login_screen>
    with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Sign In")),
      backgroundColor: Colors.white,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Align(
              alignment: Alignment.center,
              child: AnimatedButton.strip(
                animatedOn: AnimatedOn.onHover,
                width: 400,
                height: 140,
                text: 'TAP',
                isReverse: true,
                selectedTextColor: Colors.white,
                stripTransitionType: StripTransitionType.LEFT_TO_RIGHT,
                selectedBackgroundColor: Colors.black,
                textStyle: GoogleFonts.nunito(
                    fontSize: 48,
                    letterSpacing: 5,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
                onPress: () {
                  setState(() {
                    Navigator.of(context).pushNamed(
                      '/search-games',
                    );
                  });
                },
              ),
            );
          } else {
            return AuthPage();
          }
        }),
      ),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}
