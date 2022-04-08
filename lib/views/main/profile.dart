import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/widgets/custom_circle_avatar.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/post_followers_following_container.dart';
import 'package:social_media/widgets/profile_description.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: CustomGradient(
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    const CustomCircleAvatar(
                        backgroundImage: AssetImage('assets/images/samir.jpg')),
                    Padding(
                      padding: EdgeInsets.only(left: 11.h, top: 11.h),
                      child: CircleAvatar(
                        child: CircleAvatar(
                          radius: 2.h,
                          child: Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 2.h,
                            ),
                          ),
                        ),
                        radius: 1.5.h,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5.w,
                ),
                const ProfileDescription(
                    job: 'Software Developer',
                    name: 'Samir Ok',
                    place: 'Malappuram, Kerala.'),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            SizedBox(
              height: 3.h,
            ),
            const PostFollowersFollowingContainer(),
            SizedBox(
              height: 3.3.h,
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.2.h,
                  mainAxisSpacing: 0.2.h,
                ),
                children: [
                  Image.network('https://picsum.photos/250?image=1'),
                  Image.network('https://picsum.photos/250?image=2'),
                  Image.network('https://picsum.photos/250?image=3'),
                  Image.network('https://picsum.photos/250?image=4'),
                  Image.network('https://picsum.photos/250?image=1'),
                  Image.network('https://picsum.photos/250?image=2'),
                  Image.network('https://picsum.photos/250?image=3'),
                  Image.network('https://picsum.photos/250?image=4'),
                  Image.network('https://picsum.photos/250?image=1'),
                  Image.network('https://picsum.photos/250?image=2'),
                  Image.network('https://picsum.photos/250?image=3'),
                  Image.network('https://picsum.photos/250?image=4'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
