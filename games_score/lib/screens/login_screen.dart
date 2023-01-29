import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter/material.dart';
import 'package:games_score/screens/auth_screen.dart';
import 'package:games_score/screens/search_games.dart';
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
      backgroundColor: Colors.white,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasData){

            return search_games();
          }
          else {

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
