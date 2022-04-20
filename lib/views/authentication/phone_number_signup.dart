import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/authentication/login_page.dart';
import 'package:social_media/views/authentication/signup_page.dart';
import 'package:social_media/views/main/home_screen.dart';
import 'package:social_media/widgets/rich_text.dart';
import 'package:social_media/widgets/custom_button.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/input_field.dart';

class PhoneNumberSignUp extends StatelessWidget {
  const PhoneNumberSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomGradient(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Twitch!',
                        style: TextStyle(fontSize: 35.sp, fontFamily: 'Samir'),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    InputField(
                        controller: phoneNumberController.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.phone),
                        hintText: 'Phone number (+91)'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(
                      () => InputField(
                        controller: phoneNumberController.passwordController,
                        prefixIcon: const Icon(Icons.key),
                        hintText: 'Password',
                        obscureText: obscureTextController.obscureText.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            obscureTextController.obscureText.value =
                                !obscureTextController.obscureText.value;
                          },
                          icon: obscureTextController.obscureText.value
                              ? Icon(
                                  Icons.visibility_off,
                                  size: 3.h,
                                )
                              : Icon(
                                  Icons.visibility,
                                  size: 3.h,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomButton(
                      label: const Text('Sign Up'),
                      onPressed: () {
                        phoneNumberController.getOtp(context);
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Center(child: Text('OR')),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            await firebaseAuthServices
                                .signInWithGoogle(context);
                            Get.offAll(const HomeScreen());
                          },
                          child: Image.asset(
                            'assets/icons/google.png',
                            width: 7.w,
                            height: 7.h,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(const SignUpPage());
                          },
                          child: Image.asset(
                            'assets/icons/gmail.png',
                            width: 7.w,
                            height: 7.h,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            firebaseAuthServices.signinWithFacebook(context);
                          },
                          child: Image.asset(
                            'assets/icons/facebook.png',
                            width: 7.w,
                            height: 7.h,
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomRichText(
                      label: 'Alredy have an account?',
                      richText: 'Login',
                      onPressed: () {
                        Get.to(const LoginPage());
                      },
                    ),
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
}
