import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/models/comment_model.dart';
import 'package:social_media/models/post_model.dart' as model;
import 'package:social_media/models/story_model.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageServices {
  //INSTANCES
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? url;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //METHOD FOR UPLOADING AN IMAGE
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
      String childName, File file, bool isPost) async {
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
      required File file,
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
      _firestore.collection('posts').doc(postId).set(post.toJson());
      result = 'success';
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }
  

  //UPLOAD STORY
  Future<String> uploadStory(
      {required String uid,
      required File file,
      required String username,
      required String profImage}) async {
    String result = 'Some error occured!';
    try {
      String photoUrl = await uploadImageToStorage('stories', file, true);
      String storyId = const Uuid().v1();
      Story story = Story(
          datePublished: DateTime.now(),
          profImage: profImage,
          storyId: storyId,
          storyUrl: photoUrl,
          uid: uid,
          username: username);
      _firestore.collection('stories').doc(storyId).set(story.toJson());
      result = 'success';
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  //LIKE POST METHOD
  Future<void> likePost(String uid, String postId, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //LIKE COMMENT METHOD
  Future<void> likeComment(
      String uid, String postId, List likes, String commentId) async {
    try {
      if (likes.contains(uid)) {
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //POST COMMENT METHOD
  Future<String> postComment(
      {required String username,
      required String uid,
      required String profPic,
      required String text,
      required String postId,
      required BuildContext context}) async {
    String result = 'Some error occured!';
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        Comment comment = Comment(
            comment: text,
            datePublished: DateTime.now(),
            postId: postId,
            profPic: profPic,
            uid: uid,
            likes: [],
            commentId: commentId,
            username: username);
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set(comment.toJson());
        result = 'success';
      } else {
        debugPrint('Type something!!!!!!!!!!!!!!!!!!!');
      }
    } catch (e) {
      functionsController.showSnackBar(context, e.toString());
    }
    return result;
  }

  // //DELETE POST
  // Future<void> deletePost(String postId) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  //FOLLOW / UNFOLLOW
  Future<void> followUser(
      {required String uid,
      required String followId,
      required BuildContext context}) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(uid).get();
      List following = (snapshot.data()! as dynamic)['following'];
      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid]),
        });

        await _firestore.collection('users').doc(followId).update({
          'following': FieldValue.arrayRemove([followId]),
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid]),
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId]),
        });
      }
    } catch (e) {
      functionsController.showSnackBar(context, e.toString());
    }
  }
}
