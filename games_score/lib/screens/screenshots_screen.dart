import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

//Aqui es on es redirigeix la pagina per pujar ScreenShoots a Firebase Storage
class screenshots_screen extends StatefulWidget {
  const screenshots_screen({Key? key}) : super(key: key);
  @override
  State<screenshots_screen> createState() => _screenshoots_screenState();
}

String titleGame = "";

class _screenshoots_screenState extends State<screenshots_screen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void didChangeDependencies() {
    final string = ModalRoute.of(context)!.settings.arguments;
    titleGame = string.toString();
    super.didChangeDependencies();
  }

  PlatformFile? pickedFile;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = "/${user.email!}/$titleGame/screenshots";
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(title: Text("Upload a Screenshoot of " + titleGame)),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          if (pickedFile != null)
            Expanded(
                child: Container(
              color: Colors.blueGrey,
              child: Image.file(
                File(pickedFile!.path!),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: selectFile,
                  child: Text("Select a Screenshoot to upload")),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: uploadFile,
                  child: Text("Upload the Screenshoot to Firebase Storage")),
            ],
          ),
        ],
      ),
    );
  }
}
