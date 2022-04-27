import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/controllers/image_picker.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/authentication/login_page.dart';
import 'package:social_media/widgets/custom_button.dart';
import 'package:social_media/widgets/custom_circle_avatar.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/input_field.dart';
import 'package:social_media/widgets/rich_text.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  //TEXT EDITING CONTROLLERS
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final locationController = TextEditingController();

  //IMAGE PICKER CONTROLLER DEPENDENCY INJECTION
  final imagePickerController = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomGradient(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GetBuilder<ImagePickerController>(
                      builder: (controller) {
                        return CustomCircleAvatar(
                            backgroundImage: imagePickerController
                                        .pickedImage !=
                                    null
                                ? FileImage(File(imagePickerController
                                    .pickedImage!.path)) as ImageProvider
                                : const AssetImage('assets/images/user.jpg'));
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          imagePickerController.showBottomSheet(context);
                        },
                        child: const Text('Pick Image')),
                    InputField(
                      controller: emailController,
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email_rounded),
                    ),
                     Obx(
                      () => InputField(
                        prefixIcon: const Icon(Icons.key),
                        hintText: 'Password',
                        obscureText: obscureTextController.obscureText.value,
                        controller: passwordController,
                        suffixIcon: IconButton(
                          onPressed: () {
                            obscureTextController.obscureText.value =
                                !obscureTextController.obscureText.value;
                          },
                          icon: obscureTextController.obscureText.value
                              ? Icon(
                                  Icons.visibility_off,
                                  size: 3.h,
                                )
                              : Icon(
                                  Icons.visibility,
                                  size: 3.h,
                                ),
                        ),
                      ),
                    ),
                    InputField(
                      controller: usernameController,
                      hintText: 'Username',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    InputField(
                      controller: bioController,
                      hintText: 'Bio',
                      prefixIcon: const Icon(Icons.info),
                    ),
                    InputField(
                      controller: locationController,
                      hintText: 'Location',
                      prefixIcon: const Icon(Icons.location_city),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(
                      () => CustomButton(
                        label: signupController.isLoading.value == true
                            ? const CircularProgressIndicator(
                                color: kWhite,
                              )
                            : const Text('SignUp'),
                        onPressed: () async {
                          if (imagePickerController.pickedImage != null) {
                            await signupController.signupUser(
                                context: context,
                                username: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                bio: bioController.text,
                                location: locationController.text,
                                file: imagePickerController.pickedImage!);
                          } else {
                            functionsController.showSnackBar(
                                context, 'Please select an image!');
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    CustomRichText(
                        label: 'Alredy have an account?',
                        onPressed: () {
                          Get.to(const LoginPage());
                        },
                        richText: 'Login'),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
