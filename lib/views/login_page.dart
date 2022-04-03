import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Color(0xffa6daf8),
              ],
            ),
          ),
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
                  SizedBox(height: 5.h,),
                  const Text('Password'),
                  const TextField(),
                   SizedBox(height: 10.h,),
                  ElevatedButton(onPressed: (){}, child: const Text('Login'),),
                  SizedBox(height: 10.h,),
                  const Text('Don\'t have an account yet?'),
                  SizedBox(height: 0.8.h,),
                  const Text('Sign up',style: TextStyle(fontWeight: FontWeight.w600),),
                  
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
