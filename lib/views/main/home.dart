import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/views/main/messages.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/post.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const Messages());
            },
            icon: const Icon(Icons.message),
            color: Colors.black,
          ),
        ],
        title: Text(
          'Twitch!',
          style: TextStyle(
              fontSize: 29.sp, fontFamily: 'Samir', color: Colors.black),
        ),
      ),
      body: CustomGradient(
          child: SingleChildScrollView(
        child: Column(
          children: [
            LimitedBox(
              maxHeight: 9.h,
              child: Padding(
                padding: EdgeInsets.only(top: 2.h, left: 1.h, right: 1.h),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 2.h,
                    );
                  },
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return CircleAvatar(
                      radius: 3.5.h,
                      backgroundImage: const NetworkImage(
                          'https://resize.indiatvnews.com/en/resize/newbucket/715_-/2022/01/mammootty-1642327286.jpg'),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            const Post(),
            const Post(),
            const Post(),
            const Post(),
          ],
        ),
      )),
    );
  }
}
