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
  int followersCount = 0;
  int followingCount = 0;
  bool isFollowing = false;
  bool isLoading = false;
  List followersList = [];
  List followingList = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  //FETCHING DATA OF AN USER
  void getData() async {
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
      followersCount = userSnap.data()!['followers'].length;
      followingCount = userSnap.data()!['following'].length;
      followersList = userSnap.data()!['followers'];
      followingList = userSnap.data()!['following'];

      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      setState(() {});
    } catch (e) {
      if (mounted) {
        functionsController.showSnackBar(context, e.toString());
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
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
                leading: userController.getUser.uid == widget.uid
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
                                  onPressed: () async {
                                    await firebaseStorageServices.followUser(
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        followId: userData['uid'],
                                        context: context);

                                    setState(() {
                                      isFollowing = false;
                                      followersCount--;
                                    });
                                  },
                                  child: const Text(
                                    'Following',
                                    style: TextStyle(color: kBlack),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () =>
                                        Get.to(() =>  ChatScreen(userData: userData)),
                                    child: const Text(
                                      'Message',
                                      style: TextStyle(color: kBlack),
                                    )),
                              ],
                            )
                          : Row(
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      await firebaseStorageServices.followUser(
                                          uid: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          followId: userData['uid'],
                                          context: context);

                                      setState(() {
                                        isFollowing = true;
                                        followersCount++;
                                      });
                                    },
                                    child: const Text(
                                      'Follow',
                                      style: TextStyle(color: kBlack),
                                    )),
                                TextButton(
                                  onPressed: () =>
                                      Get.to(() =>  ChatScreen(userData: userData)),
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
                          InkWell(
                            onTap: () {
                              functionsController.profileScreenBottomSheet(
                                  context: context, title: 'Followers');
                            },
                            child: PostsFollowersFollowing(
                                count: followersCount.toString(),
                                label: 'Followers'),
                          ),
                          InkWell(
                            onTap: () {
                              functionsController.profileScreenBottomSheet(
                                  context: context, title: 'Following');
                            },
                            child: PostsFollowersFollowing(
                                count: followingCount.toString(),
                                label: 'Following'),
                          ),
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
