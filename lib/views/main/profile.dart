import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/authentication/login_page.dart';
import 'package:social_media/views/main/chat.dart';
import 'package:social_media/views/sub/edit_profile.dart';
import 'package:social_media/widgets/custom_circle_avatar.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/posts_followers.dart';
import 'package:social_media/widgets/profile_description.dart';

class Profile extends StatefulWidget {
  final String uid;
  const Profile({Key? key, required this.uid}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userData = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  //FETCHING DATA OF AN USER
  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      //USER
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      //POSTS COUNT
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();

      postLength = postSnap.docs.length;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      setState(() {});
    } catch (e) {
      functionsController.showSnackBar(context, e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SafeArea(
            child: CustomGradient(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: FirebaseAuth.instance.currentUser!.uid == widget.uid
                    ? IconButton(
                        icon: const Icon(
                          Icons.logout_outlined,
                          color: kBlack,
                        ),
                        onPressed: () async {
                          await firebaseAuthServices.signOut();

                          Get.offAll(() => const LoginPage());
                        },
                      )
                    : IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back),
                        color: kBlack,
                      ),
                actions: [
                  FirebaseAuth.instance.currentUser!.uid == widget.uid
                      ? TextButton(
                          onPressed: () => Get.to(() => EditProfile()),
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(color: kBlack),
                          ),
                        )
                      : isFollowing
                          ? Row(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Following',
                                      style: TextStyle(color: kBlack),
                                    )),
                                TextButton(
                                    onPressed: () =>
                                        Get.to(() => const ChatScreen()),
                                    child: const Text(
                                      'Message',
                                      style: TextStyle(color: kBlack),
                                    )),
                              ],
                            )
                          : Row(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Follow',
                                      style: TextStyle(color: kBlack),
                                    )),
                                TextButton(
                                  onPressed: () =>
                                      Get.to(() => const ChatScreen()),
                                  child: const Text(
                                    'Message',
                                    style: TextStyle(color: kBlack),
                                  ),
                                ),
                              ],
                            ),
                ],
              ),
              body: CustomGradient(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        CustomCircleAvatar(
                          backgroundImage: NetworkImage(
                            userData['photoUrl'],
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        ProfileDescription(
                          job: userData['bio'],
                          name: userData['userName'],
                          place: userData['location'],
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      height: 6.h,
                      width: 58.w,
                      child: Row(
                        children: [
                          PostsFollowersFollowing(
                              count: postLength.toString(), label: 'Posts'),
                          PostsFollowersFollowing(
                              count: followers.toString(), label: 'Followers'),
                          PostsFollowersFollowing(
                              count: following.toString(), label: 'Following'),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ),
                    SizedBox(
                      height: 3.3.h,
                    ),
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('posts')
                          .where('uid', isEqualTo: widget.uid)
                          .get(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                          ),
                          itemBuilder: (context, index) {
                            final data = snapshot.data!.docs[index];

                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(data['postUrl']),
                                    fit: BoxFit.cover),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
