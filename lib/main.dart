import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/views/login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 return Sizer(
      builder: (context, orientation, deviceType) {
          return const MaterialApp(
      title: 'Social Media',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
 );});
 }
}
