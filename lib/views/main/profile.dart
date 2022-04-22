import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/authentication/login_page.dart';
import 'package:social_media/views/sub/edit_profile.dart';
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
            Icons.logout_outlined,
            color: kBlack,
          ),
          onPressed: () async {
            await firebaseAuthServices.signOut();

            Get.offAll(() => const LoginPage());
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => EditProfile());
            },
            child: const Text(
              'Edit Profile',
              style: TextStyle(color: kBlack),
            ),
          ),
        ],
      ),
      body: CustomGradient(
        child: Column(
          children: [
            Row(
              children: [
                CustomCircleAvatar(
                    backgroundImage:
                        NetworkImage(userController.getUser.photoUrl)),
                SizedBox(
                  width: 5.w,
                ),
                ProfileDescription(
                    job: userController.getUser.bio,
                    name: userController.getUser.userName,
                    place: userController.getUser.location),
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
