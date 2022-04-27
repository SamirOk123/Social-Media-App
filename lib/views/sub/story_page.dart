import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/widgets/progress_bar.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int currentStoryIndex = 0;

  List<double> percentWatched = [];

  List stories = [
    Container(
      color: Colors.amber,
      width: double.infinity,
      height: double.infinity,
    ),
    Container(
      color: Colors.purple,
      width: double.infinity,
      height: double.infinity,
    ),
    Container(
      color: Colors.teal,
      width: double.infinity,
      height: double.infinity,
    ),
  ];

  @override
  void initState() {
    for (int i = 0; i < stories.length; i++) {
      percentWatched.add(0);
    }

    _startWatching();
    super.initState();
  }

  //PLAYING ALL STORIES
  void _startWatching() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        if (percentWatched[currentStoryIndex] + 0.01 < 1) {
          percentWatched[currentStoryIndex] += 0.01;
        } else {
          percentWatched[currentStoryIndex] = 1;
          timer.cancel();

          if (currentStoryIndex < stories.length - 1) {
            currentStoryIndex++;
            _startWatching();
          } else {
            Get.back();
          }
        }
      });
    });
  }

  //DETECTING USER'S TOUCH IN ORDER TO SKIP NEXT AND PREVIOUS
  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 2) {
      setState(() {
        if (currentStoryIndex > 0) {
          percentWatched[currentStoryIndex - 1] = 0;
          percentWatched[currentStoryIndex] = 0;
          currentStoryIndex--;
        }
      });
    } else {
      setState(() {
        if (currentStoryIndex < stories.length - 1) {
          percentWatched[currentStoryIndex] = 1;
          currentStoryIndex++;
        } else {
          percentWatched[currentStoryIndex] = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTapDown: (details) => _onTapDown(details),
        child: Scaffold(
          body: Stack(
            children: [
              stories[currentStoryIndex],
              Padding(
                padding:  EdgeInsets.only(top: 2.h),
                child: Row(
                  children: [
                    Expanded(
                      child: ProgressBar(
                        percentWatched: percentWatched[0],
                      ),
                    ),
                    Expanded(
                      child: ProgressBar(
                        percentWatched: percentWatched[1],
                      ),
                    ),
                    Expanded(
                      child: ProgressBar(
                        percentWatched: percentWatched[2],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 3.h),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(userController.getUser.photoUrl),
                  ),
                  title: Text(userController.getUser.userName),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
