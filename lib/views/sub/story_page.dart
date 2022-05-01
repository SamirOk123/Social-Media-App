import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key, required this.snap}) : super(key: key);

  final dynamic snap;

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int currentStoryIndex = 0;

  List<double> percentWatched = [];

  late List stories = [
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(widget.snap['storyUrl']), fit: BoxFit.cover),
      ),
      width: double.infinity,
      height: double.infinity,
    ),
    // Container(
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //         image: NetworkImage(widget.snap['storyUrl']), fit: BoxFit.cover),
    //   ),
    //   width: double.infinity,
    //   height: double.infinity,
    // ),
    // Container(
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //         image: NetworkImage(widget.snap['storyUrl']), fit: BoxFit.cover),
    //   ),
    //   width: double.infinity,
    //   height: double.infinity,
    // ),
  ];

  @override
  void initState() {
    //Initially all stories haven't been watched yet
    for (int i = 0; i < stories.length; i++) {
      percentWatched.add(0);
    }

    _startWatching();
    super.initState();
  }

  //PLAYING ALL STORIES
  void _startWatching() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (mounted) {
        setState(() {
          if (percentWatched[currentStoryIndex] + 0.01 < 1) {
            percentWatched[currentStoryIndex] += 0.01;
          } else {
            percentWatched[currentStoryIndex] = 1;
            timer.cancel();
            //Going to next story
            if (currentStoryIndex < stories.length - 1) {
              currentStoryIndex++;
              _startWatching();
            } else {
              Get.back();
              timer.cancel();
            }
          }
        });
      }
    });
  }

  //DETECTING USER'S TOUCH IN ORDER TO SKIP TO NEXT AND PREVIOUS
  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 2) {
      if (mounted) {
        setState(() {
          if (currentStoryIndex > 0) {
            percentWatched[currentStoryIndex - 1] = 0;
            percentWatched[currentStoryIndex] = 0;
            currentStoryIndex--;
          }
        });
      }
    } else {
      if (mounted) {
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
                padding: EdgeInsets.only(top: 2.h),
                child: LinearPercentIndicator(
                  lineHeight: 4,
                  percent: percentWatched[0],
                  progressColor: kBlue,
                  backgroundColor: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(widget.snap['profImage']),
                  ),
                  title: Text(widget.snap['username']),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
