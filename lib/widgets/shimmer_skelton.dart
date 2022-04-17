import 'package:flutter/material.dart';

class ShimmerSkelton extends StatelessWidget {
  const ShimmerSkelton(
      {Key? key,
      required this.height,
      required this.width,
      this.boarderRadius = 5})
      : super(key: key);

  final double height;
  final double width;
  final double boarderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.circular(boarderRadius)),
    );
  }
}

//SKELTON OF USER INFO

class UserInfoSkelton extends StatelessWidget {
  const UserInfoSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ShimmerSkelton(height: 15, width: 100),
        SizedBox(
          height: 10,
        ),
        ShimmerSkelton(height: 11, width: 100),
        SizedBox(
          height: 10,
        ),
        ShimmerSkelton(height: 11, width: 100)
      ],
    );
  }
}
