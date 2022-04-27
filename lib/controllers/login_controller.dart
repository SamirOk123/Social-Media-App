import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/main/home_screen.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  //METHOD FOR LOGIN
  void loginUser(BuildContext context) async {
    isLoading.value = true;
    String res = await firebaseAuthServices.loginUser(
        context: context,
        username: usernameController.text,
        password: passwordController.text);
    if (res == 'Success!') {
      isLoading.value = false;
      Get.offAll(const HomeScreen());
    } else {
      isLoading.value = false;
      functionsController.showSnackBar(context, res);
    }
  }
}
