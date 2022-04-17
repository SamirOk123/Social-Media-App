import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';

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
            backgroundColor: Colors.black.withOpacity(0.04),
            radius: 7.h,
          ),
          radius: 7.5.h,
          backgroundColor: kWhite,
        ),
      ],
    );
  }
}
