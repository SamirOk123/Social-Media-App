import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/views/sub/others_profile.dart';

class Post extends StatelessWidget {
  const Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Get.to(() => const OthersProfile());
          },
          leading: CircleAvatar(
            radius: 3.h,
            backgroundImage: const NetworkImage(
                'https://pbs.twimg.com/profile_images/1499037411401420802/1RSuJlx__400x400.jpg'),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
          subtitle: Text(
            '@dqsalmaan',
            style: TextStyle(fontSize: 7.sp),
          ),
          title: Text(
            'Dulquer Salmaan',
            style: TextStyle(fontSize: 10.sp),
          ),
        ),
        Container(
          width: double.infinity,
          height: 54.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://s3.ap-southeast-1.amazonaws.com/images.deccanchronicle.com/dc-Cover-n5lrssiq2bsjpmmhfmdl5fajs2-20191004000400.Medi.jpeg'),
                fit: BoxFit.cover),
            color: Colors.teal,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.h, left: 2.h, right: 2.h),
          child: Row(
            children: [
              Row(
                children: [
                  const Icon(Icons.favorite),
                  SizedBox(
                    width: 4.w,
                  ),
                  const Icon(Icons.chat),
                  SizedBox(
                    width: 4.w,
                  ),
                  const Icon(Icons.share)
                ],
              ),
              const Icon(Icons.save_alt),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        Align(
          child: Padding(
            padding: EdgeInsets.only(top: 2.h, left: 2.h, right: 2.h),
            child: Text(
              'Hey... what\'s up guys?',
              style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
            ),
          ),
          alignment: Alignment.bottomLeft,
        ),
        SizedBox(
          height: 3.h,
        ),
      ],
    );
  }
}
