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

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //Variable for storing user info
  dynamic user;

  //  String username = '';
  //  String location = '';
  //  String bio = '';
  //  String photoUrl = '';

  // // void getUserDetails() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //       setState(() {
  //         username = (snap.data() as Map<String,dynamic> )['userName'];
  //         location = (snap.data() as Map<String,dynamic> )['location'];
  //         bio = (snap.data() as Map<String,dynamic> )['bio'];
  //         photoUrl = (snap.data() as Map<String,dynamic> )['photoUrl'];

  //       });
  // }

  // @override
  // void initState() {
  //   getUserDetails();
  //   super.initState();
  // }

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

            Get.offAll(const LoginPage());
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
             Get.to(const EditProfile());
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
                // StreamBuilder(
                //   stream: firebaseStorageServices.getImage(
                //       context, 'profile/profilePic.jpg'),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasError) {
                //       return const CustomCircleAvatar(
                //         backgroundImage: AssetImage('assets/images/user.jpg'),
                //       );
                //     } else if (snapshot.connectionState ==
                //         ConnectionState.done) {
                //       return CustomCircleAvatar(
                //         backgroundImage: NetworkImage(
                //           snapshot.data.toString(),
                //         ),
                //       );
                //     }

                //     return const CustomCircleAvatar(
                //       backgroundImage: AssetImage('assets/images/user.jpg'),
                //     );
                //   },
                // ),
                SizedBox(
                  width: 5.w,
                ),
                ProfileDescription(
                    job: userController.getUser.bio,
                    name: userController.getUser.userName,
                    place: userController.getUser.location),
                // FutureBuilder<User?>(
                //   future: readUser(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasError) {
                //       return const SizedBox();
                //     } else if (snapshot.hasData) {
                //       user = snapshot.data;
                //       return user == null
                //           ? const SizedBox()
                //           : ProfileDescription(
                //               job: user.bio,
                //               name: user.userName,
                //               place: user.location);
                //     } else {
                //       return const UserInfoSkelton();
                //     }
                //   },
                // ),
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
