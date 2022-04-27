import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/authentication/signup.dart';
import 'package:social_media/widgets/custom_button.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/input_field.dart';
import 'package:social_media/widgets/rich_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                      child: Hero(
                        tag: 'twitch',
                        child: Text(
                          'Twitch!',
                          style:
                              TextStyle(fontSize: 35.sp, fontFamily: 'Samir'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InputField(
                        controller: loginController.usernameController,
                        prefixIcon: const Icon(Icons.person),
                        hintText: 'Username'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(
                      () => InputField(
                        prefixIcon: const Icon(Icons.key),
                        hintText: 'Password',
                        obscureText: obscureTextController.obscureText.value,
                        controller: loginController.passwordController,
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
                    Obx(
                      () => CustomButton(
                        label: loginController.isLoading.value == true
                            ? const CircularProgressIndicator(
                                color: kWhite,
                              )
                            : const Text('Login'),
                        onPressed: () {
                          loginController.loginUser(context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomRichText(
                      label: 'Don\'t have an account yet?',
                      richText: 'Signup',
                      onPressed: () {
                        Get.to(SignUp());
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
