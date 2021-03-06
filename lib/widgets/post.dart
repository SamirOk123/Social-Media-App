import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/main/profile.dart';
import 'package:social_media/views/sub/comments.dart';
import 'package:social_media/widgets/like_animation.dart';

class Post extends StatefulWidget {
  const Post({Key? key, required this.snap}) : super(key: key);

  final dynamic snap;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  int commentCount = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    getCommentsCount();
    super.initState();
  }

  //GETTING THE LENGTH OF COMMENTS LIST
  void getCommentsCount() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentCount = snapshot.docs.length;
    } catch (e) {
      functionsController.showSnackBar(context, e.toString());
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => Get.to(
            () => Profile(uid: widget.snap['uid']),
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.05),
            radius: 2.5.h,
            backgroundImage: NetworkImage(widget.snap['profImage']),
          ),
          trailing: IconButton(
            onPressed: () {
              // firebaseStorageServices.deletePost(widget.snap['postId']);
            },
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
          title: Text(
            widget.snap['username'],
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        GestureDetector(
          onDoubleTap: () async {
            await firebaseStorageServices.likePost(userController.getUser.uid,
                widget.snap['postId'], widget.snap['likes']);

            setState(() {
              isLikeAnimating = true;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.snap['postUrl']),
                      fit: BoxFit.cover),
                  color: Colors.black.withOpacity(0.04),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 200,
                ),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  child: const Icon(Icons.favorite, color: kWhite, size: 120),
                  isAnimating: isLikeAnimating,
                  duration: const Duration(milliseconds: 400),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding:
                EdgeInsets.only(top: 2.h, left: 2.h, right: 2.h, bottom: 1.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        LikeAnimation(
                          isAnimating: widget.snap['likes']
                              .contains(userController.getUser.uid),
                          smallLike: true,
                          child: InkWell(
                            onTap: () async {
                              await firebaseStorageServices.likePost(
                                  userController.getUser.uid,
                                  widget.snap['postId'],
                                  widget.snap['likes']);
                            },
                            child: widget.snap['likes']
                                    .contains(userController.getUser.uid)
                                ? const Icon(Icons.favorite, color: Colors.red)
                                : const Icon(Icons.favorite_border_outlined),
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        InkWell(
                          child: const Icon(Icons.chat),
                          onTap: () {
                            Get.to(() => CommentsScreen(
                                  snap: widget.snap,
                                ));
                          },
                        ),
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
                SizedBox(
                  height: 1.h,
                ),
                Align(
                  child: Text(
                    widget.snap['likes'].length == 1
                        ? '${widget.snap['likes'].length} like'
                        : '${widget.snap['likes'].length} likes',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Text(
                      widget.snap['username'],
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.snap['description'],
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Align(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => CommentsScreen(
                            snap: widget.snap,
                          ));
                    },
                    child: Text(
                      commentCount == 0
                          ? '0 Comments'
                          : 'View all $commentCount comments',
                      style:
                          TextStyle(color: Colors.grey[600], fontSize: 11.sp),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Align(
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style: TextStyle(color: Colors.grey[600], fontSize: 11.sp),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
