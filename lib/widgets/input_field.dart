import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      this.keyboardType,
      this.obscureText =false,
      this.prefixIcon,
      this.containerHeight,
      this.suffixIcon,
      this.controller,
      required this.hintText})
      : super(key: key);

  final double? containerHeight;
  final Widget? suffixIcon;
  final String hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 98.w,
      height: containerHeight,
      decoration: BoxDecoration(
          color: kWhite, borderRadius: BorderRadius.circular(5.h)),
      margin: EdgeInsets.all(1.h),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: TextField(
            controller: controller,keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                hintText: hintText),
          ),
        ),
      ),
    );
  }
}
