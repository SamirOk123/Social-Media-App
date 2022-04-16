import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/main/home_screen.dart';
import 'package:social_media/widgets/custom_button.dart';
import 'package:social_media/widgets/gradient.dart';

class OtpVerificationPage extends StatelessWidget {
  OtpVerificationPage({Key? key}) : super(key: key);

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomGradient(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                   
                    Center(
                      child: Text(
                        'Twitch!',
                        style: TextStyle(fontSize: 35.sp, fontFamily: 'Samir'),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'A six digit code has been sent to \n${phoneNumberController.phoneNumberController.text}',
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Pinput(
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 50,
                        textStyle: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(30, 60, 87, 1),
                            fontWeight: FontWeight.w600),
                        decoration: BoxDecoration(color: kWhite,
                         
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: otpController,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomButton(label: 'Verify', onPressed: (){verifyOtp(context);}),
                    
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Method for verifying otp
  Future verifyOtp(BuildContext context) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: phoneNumberController.verificationId,
        smsCode: otpController.text);
    signInWithPhoneAuthCredential(phoneAuthCredential,context);
  }

// Method for signing in
  Future signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential,BuildContext? context) async {
    try {
      final authCredential = await phoneNumberController.auth
          .signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        Get.offAll(const HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      functionsController.showSnackBar(
         context!, e.toString());
    }
  }
}
