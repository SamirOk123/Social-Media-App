import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onPressed,
      child: Container(
        width: 98.w,
        height: 44,
        decoration: BoxDecoration(
            color: Colors.lightBlue,
            boxShadow: kElevationToShadow[2],
            borderRadius: BorderRadius.circular(5.h)),
        margin: EdgeInsets.all(1.h),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: kWhite),
          ),
        ),
      ),
    );
  }
}
