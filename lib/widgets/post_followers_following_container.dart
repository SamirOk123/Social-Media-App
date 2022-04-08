import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/widgets/posts_followers.dart';

class PostFollowersFollowingContainer extends StatelessWidget {
  const PostFollowersFollowingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      width: 58.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(2.h)),
      child: Row(
        children: const [
          PostsFollowersFollowing(count: '12', label: 'Posts'),
          PostsFollowersFollowing(count: '1.5M', label: 'Followers'),
          PostsFollowersFollowing(count: '157', label: 'Following'),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
