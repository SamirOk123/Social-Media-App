import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/main/messages.dart';
import 'package:social_media/views/sub/new_post.dart';
import 'package:social_media/views/sub/new_story.dart';
import 'package:social_media/views/sub/story_page.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //GETTING CURRENT USER
  Future<void> addData() async {
    await userController.refreshUser();
  }

  @override
  void initState() {
    addData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        backgroundColor: kBlack,
        overlayColor: Colors.transparent,
        spacing: 12,
        spaceBetweenChildren: 10,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              onTap: () => Get.to(const NewPost()),
              child: Image.asset(
                'assets/icons/post.png',
                width: 20,
                height: 20,
              ),
              label: 'Post'),
          SpeedDialChild(
              onTap: () => Get.to(NewStory()),
              child: Image.asset(
                'assets/icons/story.png',
                width: 20,
                height: 20,
              ),
              label: 'Story'),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const NewPost());
            },
            icon: const Icon(
              Icons.add,
              color: kBlack,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => const Messages());
            },
            icon: const Icon(Icons.message),
            color: kBlack,
          ),
        ],
        title: Hero(
          tag: 'twitch',
          child: Text(
            'Twitch!',
            style:
                TextStyle(fontSize: 29.sp, fontFamily: 'Samir', color: kBlack),
          ),
        ),
      ),
      body: CustomGradient(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LimitedBox(
                maxHeight: 10.h,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                  ),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('stories')
                        .orderBy('datePublished', descending: true)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 8,
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: DashedCircle(
                                color: Colors.pink,
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => StoryPage(
                                          snap:
                                              snapshot.data!.docs[index].data(),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Colors.black.withOpacity(0.05),
                                      radius: 3.5.h,
                                      backgroundImage: NetworkImage(snapshot
                                          .data!.docs[index]
                                          .data()['profImage']),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('datePublished', descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Post(
                        snap: snapshot.data!.docs[index].data(),
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
