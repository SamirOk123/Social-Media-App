import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/input_field.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradient(
        child: NestedScrollView(
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'No data',
                    style: TextStyle(color: kBlack),
                  ),
                );
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data!.docs[index].data()['userName'],
                          style: TextStyle(fontSize: 10.sp),
                        ),
                        subtitle: Text(
                          snapshot.data!.docs[index].data()['bio'],
                          style: TextStyle(fontSize: 8.sp),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.04),
                          backgroundImage: NetworkImage(
                            snapshot.data!.docs[index].data()['photoUrl'],
                          ),
                          radius: 3.5.h,
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text('No data!'),
                );
              }
            },
          ),
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: InputField(
                hintText: 'Search',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }

  // Future<User?> readUser() async {
  //   final docUser = FirebaseFirestore.instance.collection('users').doc();
  //   final snapshot = await docUser.get();

  //   if (snapshot.exists) {
  //     return User.fromJson(snapshot.data()!);
  //   } else {
  //     return null;
  //   }
  // }
}
