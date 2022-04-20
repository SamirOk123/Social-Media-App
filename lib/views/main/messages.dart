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
                    title:  Text('Prithviraj Sukumaran',style: TextStyle(fontSize: 10.sp),),
                    subtitle:  Text('Are you free now?',style: TextStyle(fontSize: 9.sp),),
                    leading: CircleAvatar(
                      radius: 3.5.h,
                      backgroundImage: const NetworkImage(
                          'https://images.indianexpress.com/2021/12/Prithviraj-Sukumaran-1200by667.jpg'),
                    ),
                    trailing:  Text('11:34 AM',style: TextStyle(fontSize: 10.sp),),
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
              color: kBlack,
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
