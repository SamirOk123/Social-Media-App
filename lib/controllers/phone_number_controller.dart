import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/authentication/otp_verfication.dart';

class PhoneNumberController extends GetxController {

  //TEXT EDITING CONTROLLERS
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //FIREBASE AUTH INSTANCE
  FirebaseAuth auth = FirebaseAuth.instance;

  
  String verificationId = '';

  Future<void> getOtp(
      BuildContext context) async {
    if (phoneNumberController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumberController.text,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (error) {
            functionsController.showSnackBar(context, error.message!);
          },
          codeSent: (String verificationId, int? resendToken) async {
            this.verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
           Get.to(OtpVerificationPage());
    } else {
      functionsController.showSnackBar(context, 'Please fill all the fields');
    }
  }
}
