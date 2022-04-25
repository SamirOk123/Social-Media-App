import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/views/main/profile.dart';
import 'package:social_media/widgets/gradient.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchController = TextEditingController();
  bool showUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          controller: searchController,
          onChanged: (value) {
            setState(() {
              showUsers = true;
            });
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search user',
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: showUsers
          ? CustomGradient(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('userName',
                        isGreaterThanOrEqualTo: searchController.text)
                    .get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text(
                        'Nothing to show!',
                        style: TextStyle(color: kBlack),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () => Get.to(() => Profile(
                              uid: snapshot.data!.docs[index].data()['uid'])),
                          title: Text(
                            snapshot.data!.docs[index].data()['userName'] ?? '',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          subtitle: Text(
                            snapshot.data!.docs[index].data()['bio'] ?? '',
                            style: TextStyle(fontSize: 8.sp),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.04),
                            backgroundImage: NetworkImage(snapshot
                                    .data!.docs[index]
                                    .data()['photoUrl'] ??
                                'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                            radius: 3.5.h,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          : CustomGradient(
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts').get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 3,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                snapshot.data!.docs[index]['postUrl']),
                            fit: BoxFit.cover),
                      ),
                    ),
                    staggeredTileBuilder: (index) => index % 7 == 0
                        ? const StaggeredTile.count(2, 2)
                        : const StaggeredTile.count(1, 1),
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                  );
                },
              ),
            ),
    );
  }
}
