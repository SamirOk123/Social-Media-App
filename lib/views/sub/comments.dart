import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/widgets/comment_card.dart';
import 'package:social_media/widgets/gradient.dart';

class CommentsScreen extends StatefulWidget {
   const CommentsScreen({Key? key, required this.snap}) : super(key: key);

 final dynamic snap;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  //TEXT EDITING CONTROLLER
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(userController.getUser.photoUrl),
            ),
            title: TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: 'Comment as ${userController.getUser.userName}',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            trailing: InkWell(
              child: const Text(
                'Post',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                await firebaseStorageServices.postComment(
                    username: userController.getUser.userName,
                    uid: userController.getUser.uid,
                    profPic: userController.getUser.photoUrl,
                    text: commentController.text,
                    postId: widget.snap['postId'],
                    context: context);
                setState(() {
                  commentController.text = '';
                });
              },
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Comments',
            style: TextStyle(color: kBlack),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: kBlack,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: CustomGradient(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(widget.snap['postId'])
                .collection('comments')
                .orderBy('datePublished', descending: true)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return CommentCard(
                    snap: snapshot.data!.docs[index].data(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
