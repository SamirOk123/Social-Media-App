import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/widgets/gradient.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomGradient(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.h),
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
                  Text(
                    'A four digit code has been sent to 9544499015',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  const Text(
                    'OTP',
                    textAlign: TextAlign.start,
                  ),
                  const TextField(
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Confirm'),
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
