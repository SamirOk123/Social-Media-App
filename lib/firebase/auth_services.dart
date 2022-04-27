import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/models/user_model.dart' as model;

class FirebaseAuthServices {
  //INSTANCES
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //METHOD FOR SIGNING IN WITH GOOGLE
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      functionsController.showSnackBar(context, e.message!);
    } catch (e) {
      functionsController.showSnackBar(context, 'Please select an account!');
    }
  }

  //SIGN OUT
  Future<void> signOut() async {
    await _auth.signOut();
    // await _googleSignIn.signOut();
  }

  //SIGN UP WITH EMAIL AND PASSWORD

  // Future<String> signupUser(
  //     {required String email,
  //     required String password,
  //     BuildContext? context}) async {
  //   String res = 'Something went wrong!';
  //   try {
  //     if (email.isNotEmpty || password.isNotEmpty) {
  //       await _auth.createUserWithEmailAndPassword(
  //           email: email, password: password);

  //       res = 'Success';

  //       // await sendEmailVerification(context);
  //     } else {
  //       res = 'Please fill all the fields!';
  //     }
  //   } catch (e) {
  //     res = 'Invalid email or password!';
  //   }
  //   return res;
  // }

  //EMAIL VERIFICATION

  // Future<void> sendEmailVerification(BuildContext? context) async {
  //   try {
  //     _auth.currentUser!.sendEmailVerification();
  //     functionsController.showSnackBar(
  //         context!, 'Email verification has been sent!');
  //   } on FirebaseAuthException catch (e) {
  //     functionsController.showSnackBar(context!, e.message!);
  //   }
  // }

  //LOGIN WITH USERNAME AND PASSWORD
  Future<String> loginUser(
      {required String username,
      required String password,
      required BuildContext context}) async {
    String res = 'Something went wrong!';

    try {
      if (username.isNotEmpty || password.isNotEmpty) {
        QuerySnapshot snap = await _firestore
            .collection('users')
            .where('userName', isEqualTo: username)
            .get();
        await _auth.signInWithEmailAndPassword(
            email: snap.docs[0]['email'], password: password);
        res = 'Success!';
      } else {
        res = 'Please fill all the fields';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        functionsController.showSnackBar(context, 'User not found!');
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //FACEBOOK SIGNIN
  Future<void> signinWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential fbAthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _auth.signInWithCredential(fbAthCredential);
    } on FirebaseAuthException catch (e) {
      functionsController.showSnackBar(context, e.message!);
    }
  }

  //GETTING CURRENT USER DETAILS
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    return model.User.fromSnap(documentSnapshot);
  }
}
