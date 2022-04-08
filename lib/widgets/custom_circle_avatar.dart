import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({Key? key, required this.backgroundImage})
      : super(key: key);

  final ImageProvider backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          child: CircleAvatar(
            backgroundImage: backgroundImage,
            radius: 7.h,
          ),
          radius: 7.5.h,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
