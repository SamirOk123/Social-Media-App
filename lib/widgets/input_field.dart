import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.containerHeight,
      required this.suffixIcon,
      required this.hintText})
      : super(key: key);

  final double containerHeight;
  final Widget suffixIcon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 98.w,
      height: containerHeight,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.h)),
      margin: EdgeInsets.all(1.h),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIcon: suffixIcon,
                hintText:hintText),
          ),
        ),
      ),
    );
  }
}
