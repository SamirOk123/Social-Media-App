import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:social_media/constants.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar({Key? key, required this.percentWatched}) : super(key: key);

  double percentWatched = 0;

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: 4,
      percent: percentWatched,
      progressColor: kBlue,
      backgroundColor: Colors.grey,
    );
  }
}
