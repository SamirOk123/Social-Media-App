import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FunctionsController extends GetxController {
//SNACKBAR
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void profileScreenBottomSheet(
      {required BuildContext context, required String title}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                 title,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const CircleAvatar(),
                title: const Text('Brock Lotus'),
                onTap: () {
                  Get.back();
                },
              ),
              ListTile(
                leading: const CircleAvatar(),
                title: const Text('Walter White'),
                onTap: () {
                  Get.back();
                },
              ),
              ListTile(
                leading: const CircleAvatar(),
                title: const Text('Lucas Hood'),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          );
        });
  }
}
