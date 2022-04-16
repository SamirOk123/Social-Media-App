import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';

class CustomGradient extends StatelessWidget {
  const CustomGradient({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kWhite,
            kBlue,
          ],
        ),
      ),
      child: child,
    );
  }
}
