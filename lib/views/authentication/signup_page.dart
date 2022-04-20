import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/authentication/login_page.dart';
import 'package:social_media/views/authentication/phone_number_signup.dart';
import 'package:social_media/views/main/home_screen.dart';
import 'package:social_media/widgets/rich_text.dart';
import 'package:social_media/widgets/custom_button.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/input_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
                    const InputField(
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon:  Icon(Icons.person),
                        hintText: 'Email'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(
                      () => InputField(
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
                    CustomButton(label: signupController.isLoading.value==true? const CircularProgressIndicator(color: kWhite,): 
                   const  Text('SignUp'),
                     
                      onPressed: () {
                        // signupUser(context);
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
                        GestureDetector(
                          child: Image.asset(
                            'assets/icons/call.png',
                            width: 7.w,
                            height: 7.h,
                          ),
                          onTap: () {
                            Get.to(const PhoneNumberSignUp());
                          },
                        ),
                        GestureDetector(
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
                            Get.offAll(const HomeScreen());
                          },
                          child: GestureDetector(
                            onTap: () {
                              firebaseAuthServices.signinWithFacebook(context);
                            },
                            child: Image.asset(
                              'assets/icons/facebook.png',
                              width: 7.w,
                              height: 7.h,
                            ),
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
