import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/widgets/like_animation.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  final dynamic snap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(snap['profPic']),
          ),
          title: Text(
            snap['username'],
            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
          ),
          trailing: LikeAnimation(
            isAnimating: snap['likes'].contains(userController.getUser.uid),
            smallLike: true,
            child: InkWell(
              onTap: () async {
                await firebaseStorageServices.likeComment(
                    userController.getUser.uid,
                    snap['postId'],
                    snap['likes'],
                    snap['commentId']);
              },
              child: snap['likes'].contains(userController.getUser.uid)
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 2.h,
                    )
                  : Icon(
                      Icons.favorite_border,
                      size: 2.h,
                    ),
            ),
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(snap['datePublished'].toDate()),
            style: TextStyle(fontSize: 8.sp),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: Text(
            snap['comment'],
            style: TextStyle(fontSize: 10.sp),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(),
        ),
      ],
    );
  }
}
