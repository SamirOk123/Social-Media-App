import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/widgets/gradient.dart';
import '../../dependency_injection.dart';

class AuthFinalStep extends StatelessWidget {
  const AuthFinalStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomGradient(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 0.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Text(
                      'Twitch!',
                      style: TextStyle(fontSize: 35.sp, fontFamily: 'Samir'),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Text(
                    'User name',
                    textAlign: TextAlign.start,
                  ),
                  const TextField(),
                  SizedBox(
                    height: 7.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1.w),
                    ),
                    height: 8.h,
                    width: double.infinity,
                    child: Center(
                      child: Obx(
                        () => Text(
                          '${datePickerController.date.value.day} - ${datePickerController.date.value.month} - ${datePickerController.date.value.year}',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: datePickerController.date.value,
                          firstDate: DateTime(1947),
                          lastDate: DateTime(3000));
                      if (newDate == null) return;

                      datePickerController.date.value = newDate;
                    },
                    child: const Text('Set date of birth'),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      size: 6.h,
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
