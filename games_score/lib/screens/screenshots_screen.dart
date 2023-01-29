import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

//Aqui es on es redirigeix la pagina per pujar ScreenShoots a Firebase Storage
// ignore: camel_case_types
class screenshots_screen extends StatefulWidget {
  const screenshots_screen({Key? key}) : super(key: key);
  @override
  State<screenshots_screen> createState() => _screenshoots_screenState();
}

String titleGame = "";

// ignore: camel_case_types
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "Upload a Screenshoot of: " + titleGame,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // ignore: prefer_const_constructors
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
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: selectFile,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text(
                    "Select a Screenshoot to upload",
                    style: TextStyle(color: Colors.amber),
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: uploadFile,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text(
                    "Upload the Screenshoot to Firebase Storage",
                    style: TextStyle(color: Colors.amber),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
