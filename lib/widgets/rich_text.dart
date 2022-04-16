import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText(
      {Key? key,
      required this.label,
      required this.onPressed,
      required this.richText})
      : super(key: key);

  final String label;
  final String richText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(color: kBlack, fontSize: 11.sp),
            ),
            WidgetSpan(
              child: GestureDetector(
                child: Text(
                  richText,
                  style: TextStyle(
                      decoration: TextDecoration.underline, fontSize: 11.sp),
                ),
                onTap: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
