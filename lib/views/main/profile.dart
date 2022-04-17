import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/views/authentication/login_page.dart';
import 'package:social_media/views/sub/edit_profile.dart';
import 'package:social_media/widgets/custom_circle_avatar.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/post_followers_following_container.dart';
import 'package:social_media/widgets/profile_description.dart';
import 'package:social_media/widgets/shimmer_skelton.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  //Variable for storing user info
  dynamic user;

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

            Get.offAll(LoginPage());
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(
                    userName: user.userName,
                    bio: user.bio,
                    location: user.location,
                  ),
                ),
              );
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
                StreamBuilder(
                  stream: firebaseStorageServices.getImage(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const CustomCircleAvatar(
                        backgroundImage: AssetImage('assets/images/user.png'),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return CustomCircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data.toString(),
                        ),
                      );
                    }

                    return const CustomCircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.png'),
                    );
                  },
                ),
                SizedBox(
                  width: 5.w,
                ),
                FutureBuilder<User?>(
                  future: readUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const SizedBox();
                    } else if (snapshot.hasData) {
                      user = snapshot.data;
                      return user == null
                          ? const SizedBox()
                          : ProfileDescription(
                              job: user.bio,
                              name: user.userName,
                              place: user.location);
                    } else {
                      return const UserInfoSkelton();
                    }
                  },
                ),
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

// Method for getting user details
  Future<User?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc('n55aTb73sBgAJtcV8DuT');
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }
}

