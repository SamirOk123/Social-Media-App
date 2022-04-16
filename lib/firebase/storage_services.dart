import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/models/user_model.dart';

class FirebaseStorageServices {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String? url;

//Method for uploading image
  Future<void> uploadFile(String filePath, String fileName,BuildContext context) async {
    File file = File(filePath);

    try {
      await storage.ref('profile/profilePic.jpg').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      functionsController.showSnackBar(context,e.message!);
    }
  }

//Methods for retrieving image

  Stream getImage(BuildContext context) async* {
    try {
      await getUrl();
      yield url;
    } catch (e) {
      functionsController.showSnackBar(context,'Something went wrong!');
      yield null;
    }
  }

  Future<void> getUrl() async {
    url = await storage
        .ref()
        .child('profile/profilePic.jpg')
        .getDownloadURL();
    debugPrint(url.toString());
  }

  // Method for creating a user

  Future createUser(User newUser) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final json = newUser.toJson();
    await docUser.set(json);
  }
}
