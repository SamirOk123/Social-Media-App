import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/widgets/gradient.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: kHeaderStyle,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: CustomGradient(
          child: ListView.separated(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.04),
                    radius: 3.5.h,
                    backgroundImage: const NetworkImage(
                        'https://images.indianexpress.com/2016/05/mohanlal-7591.jpg'),
                  ),
                  title: Text(
                    'Mohanlal liked your photo',
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  trailing: Container(
                    height: 5.h,
                    width: 5.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/samir.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 2.h,
                );
              })),
    );
  }
}
