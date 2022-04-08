import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/views/main/chat.dart';
import 'package:social_media/widgets/gradient.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomGradient(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: const Text('Prithviraj Sukumaran'),
                    subtitle: const Text('Are you free now?'),
                    leading: CircleAvatar(
                      radius: 3.5.h,
                      backgroundImage: const NetworkImage(
                          'https://images.indianexpress.com/2021/12/Prithviraj-Sukumaran-1200by667.jpg'),
                    ),
                    trailing: const Text('11:34 AM'),
                    onTap: () {
                      Get.to(() => const ChatScreen());
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 2.h,
                  );
                },
                itemCount: 20)),
        appBar: AppBar(
          title: const Text(
            'Messages',
            style: kHeaderStyle,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
    );
  }
}
