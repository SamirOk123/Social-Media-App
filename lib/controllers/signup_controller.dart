import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/models/user_model.dart' as model;
import 'package:social_media/views/main/home_screen.dart';

class SignupController extends GetxController {

  //INSTANCES
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;


  //METHOD FOR SIGNUP
  Future<String> signupUser(
      {required String username,
      required String email,
      required String password,
      required String bio,
      required String location,
      required XFile file,
      required BuildContext context}) async {
    String result = 'Some error occured!';
    try {
      if (username.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          location.isNotEmpty) {
        isLoading.value = true;

        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await firebaseStorageServices.uploadImageToStorage(
            'ProfilePics', file, false);

        model.User user = model.User(
            bio: bio,
            uid: credential.user!.uid,
            followers: [],
            following: [],
            photoUrl: photoUrl,
            userName: username,
            location: location);

        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
        result = 'success';

        Get.offAll(const HomeScreen());
      }
    } catch (e) {
      isLoading.value = false;
      functionsController.showSnackBar(context, 'Please fill all the fields!');
      result = e.toString();
    }
    return result;
  }
}
