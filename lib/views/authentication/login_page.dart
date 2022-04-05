import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:social_media/views/authentication/signup_page.dart';
import 'package:social_media/widgets/gradient.dart';

import '../../dependency_injection.dart';





class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

 
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
                    'User name',
                    textAlign: TextAlign.start,
                  ),
                  const TextField(),
                  SizedBox(
                    height: 5.h,
                  ),
                  const Text('Password'),
                Obx(() =>   TextField(
                    obscureText: obscureTextController.obscureText.value,
                    decoration: InputDecoration(
                      suffixIcon:IconButton(
                        onPressed: () {
                         
                            obscureTextController.obscureText.value =!obscureTextController.obscureText.value;
                         
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
                    ),),),
                  
                  SizedBox(
                    height: 8.h,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Login'),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  const Text('Don\'t have an account yet?'),
                  SizedBox(
                    height: 0.8.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const SignUpPage());
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
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
