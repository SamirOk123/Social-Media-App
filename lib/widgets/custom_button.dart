import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  final Widget label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 6.h,
        decoration: BoxDecoration(
            color: Colors.lightBlue,
            boxShadow: kElevationToShadow[2],
            borderRadius: BorderRadius.circular(5.h)),
        margin: EdgeInsets.all(1.h),
        child: Center(
          child: label,
        ),
      ),
    );
  }
}
