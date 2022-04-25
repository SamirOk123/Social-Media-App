// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:social_media/constants.dart';
// import 'package:social_media/views/main/chat.dart';
// import 'package:social_media/widgets/custom_circle_avatar.dart';
// import 'package:social_media/widgets/gradient.dart';
// import 'package:social_media/widgets/post_followers_following_container.dart';
// import 'package:social_media/widgets/profile_description.dart';

// class OthersProfile extends StatefulWidget {
//   const OthersProfile({Key? key}) : super(key: key);

//   @override
//   State<OthersProfile> createState() => _OthersProfileState();
// }

// class _OthersProfileState extends State<OthersProfile> {
//   bool following = false;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   setState(() {
//                     following = !following;
//                   });
//                 },
//                 child: following
//                     ? const Text(
//                         'Following',
//                         style: TextStyle(color: kBlack),
//                       )
//                     : const Text(
//                         'Follow',
//                         style: TextStyle(color: kBlack),
//                       )),
//             TextButton(
//                 onPressed: () {
//                   Get.to(() => const ChatScreen());
//                 },
//                 child: const Text(
//                   'Message',
//                   style: TextStyle(color: kBlack),
//                 ))
//           ],
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back,
//               color: kBlack,
//             ),
//             onPressed: () {
//               Get.back();
//             },
//           ),
//         ),
//         body: CustomGradient(
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   const CustomCircleAvatar(
//                       backgroundImage: NetworkImage(
//                           'https://pbs.twimg.com/profile_images/1499037411401420802/1RSuJlx__400x400.jpg')),
//                   SizedBox(
//                     width: 5.w,
//                   ),
//                   const ProfileDescription(
//                       job: 'Actor, Producer',
//                       name: 'Dulquer Salmaan',
//                       place: 'Kerala, India')
//                 ],
//                 mainAxisAlignment: MainAxisAlignment.center,
//               ),
//               SizedBox(
//                 height: 2.h,
//               ),
//               const PostFollowersFollowingContainer(),
//               SizedBox(
//                 height: 3.3.h,
//               ),
//               Expanded(
//                 child: GridView(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 0.2.h,
//                     mainAxisSpacing: 0.2.h,
//                   ),
//                   children: [
//                     Image.network('https://picsum.photos/250?image=1'),
//                     Image.network('https://picsum.photos/250?image=2'),
//                     Image.network('https://picsum.photos/250?image=3'),
//                     Image.network('https://picsum.photos/250?image=4'),
//                     Image.network('https://picsum.photos/250?image=1'),
//                     Image.network('https://picsum.photos/250?image=2'),
//                     Image.network('https://picsum.photos/250?image=3'),
//                     Image.network('https://picsum.photos/250?image=4'),
//                     Image.network('https://picsum.photos/250?image=1'),
//                     Image.network('https://picsum.photos/250?image=2'),
//                     Image.network('https://picsum.photos/250?image=3'),
//                     Image.network('https://picsum.photos/250?image=4'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
