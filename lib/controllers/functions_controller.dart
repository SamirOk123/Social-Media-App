import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionsController extends GetxController {


//SNACKBAR
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
