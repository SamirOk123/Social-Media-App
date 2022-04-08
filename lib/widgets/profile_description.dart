import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileDescription extends StatelessWidget {
  const ProfileDescription(
      {Key? key, required this.job, required this.name, required this.place})
      : super(key: key);

  final String name;
  final String place;
  final String job;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          place,
          style: TextStyle(
              fontSize: 7.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          job,
          style: TextStyle(
              fontSize: 7.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
