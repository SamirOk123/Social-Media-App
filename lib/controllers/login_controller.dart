import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/main/home_screen.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  //METHOD FOR LOGIN
  void loginUser(BuildContext context) async {
    isLoading.value = true;
    String res = await firebaseAuthServices.loginUser(
        context: context,
        email: emailController.text,
        password: passwordController.text);
    if (res == 'Success!') {
      isLoading.value = false;
      Get.offAll(const HomeScreen());
    } else {
      functionsController.showSnackBar(context, res);
    }
  }
}
