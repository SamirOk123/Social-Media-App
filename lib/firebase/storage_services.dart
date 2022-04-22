import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/models/post_model.dart' as model;
import 'package:uuid/uuid.dart';

class FirebaseStorageServices {

  //INSTANCES
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? url;

  
  //METHOD FOR UPLOADING IMAGE
  Future<void> uploadFile(String filePath, String fileName,
      BuildContext context, String uploadPath) async {
    File file = File(filePath);

    try {
      await storage.ref(uploadPath + fileName).putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      functionsController.showSnackBar(context, e.message!);
    }
  }
  
  //UPLOAD IMAGE METHOD
  Future<String> uploadImageToStorage(
      String childName, XFile file, bool isPost) async {
    Reference reference =
        storage.ref().child(childName).child(auth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      reference = reference.child(id);
    }
    UploadTask uploadTask = reference.putFile(File(file.path));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

//UPLOAD POST METHOD
  Future<String> uploadPost(
      {required String description,
      required String uid,
      required XFile file,
      required String username,
      required String profImage}) async {
    String result = 'Some error occured!';
    try {
      String photoUrl = await uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      model.Post post = model.Post(
          description: description,
          uid: uid,
          username: username,
          profImage: profImage,
          postUrl: photoUrl,
          postId: postId,
          datePublished: DateTime.now(),
          likes: []);
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .set(post.toJson());
      result = 'success';
    } catch (e) {
      result = e.toString();
    }
    return result;
  }
  
  //LIKE POST METHOD
  Future<void> likePost(String uid, String postId, List likes) async {
    try {
      if (likes.contains(uid)) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
