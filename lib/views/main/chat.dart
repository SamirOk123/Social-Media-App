import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/input_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.userData}) : super(key: key);

  final dynamic userData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomGradient(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: const [],
                ),
              ),
              Align(
                child: InputField(
                  hintText: 'Message...',
                  suffixIcon: TextButton(
                    onPressed: () {},
                    child: const Text('Send'),
                  ),
                ),
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(userData['photoUrl']),
            ),
            title: Text(
              userData['userName'],
              style: TextStyle(fontSize: 10.sp),
            ),
            subtitle: Text(
              'Active Now',
              style: TextStyle(fontSize: 8.sp),
            ),
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
          actions: [
            IconButton(
              icon: const Icon(
                Icons.call,
                color: kBlack,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
