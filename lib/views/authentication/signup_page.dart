import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/views/authentication/auth_final_step.dart';
import 'package:social_media/views/authentication/phone_number_signup.dart';
import 'package:social_media/widgets/gradient.dart';
import '../../dependency_injection.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomGradient(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Text(
                      'Twitch!',
                      style: TextStyle(fontSize: 35.sp, fontFamily: 'Samir'),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Text(
                    'Email',
                    textAlign: TextAlign.start,
                  ),
                  const TextField(),
                  SizedBox(
                    height: 5.h,
                  ),
                  const Text('Password'),
                  Obx(
                    () => TextField(
                      obscureText: obscureTextController.obscureText.value,
                      decoration: InputDecoration(
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
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(const AuthFinalStep());
                    },
                    child: const Text('Signup'),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  const Center(child: Text('Or')),
                  SizedBox(
                    height: 4.h,
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
                      Image.asset(
                        'assets/icons/google.png',
                        width: 7.w,
                        height: 7.h,
                      ),
                      Image.asset(
                        'assets/icons/facebook.png',
                        width: 7.w,
                        height: 7.h,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
