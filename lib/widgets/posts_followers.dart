import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PostsFollowersFollowing extends StatelessWidget {
  const PostsFollowersFollowing(
      {Key? key, required this.count, required this.label})
      : super(key: key);

  final String count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 7.sp, color: Colors.grey),
        ),
      ],mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
