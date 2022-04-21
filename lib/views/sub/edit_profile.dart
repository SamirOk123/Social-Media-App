import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/controllers/image_picker.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/views/main/home_screen.dart';
import 'package:social_media/widgets/custom_circle_avatar.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/input_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

 

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //TEXT EDITING CONTROLLERS

  late final userNameController = TextEditingController()
    ..text = userController.getUser.userName;

  late final bioController = TextEditingController()..text = userController.getUser.bio;

  late final locationController = TextEditingController()
    ..text = userController.getUser.location;

  //IMAGE PICKER CONTROLLER DEPENDENCY INJECTION

  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                //UPLOADING IMAGE
                if (imagePickerController.pickedImage != null) {
                  final filePath = imagePickerController.pickedImage!.path;
                  // final fileName = imagePickerController.pickedImage!.name;
                  const fileName = 'profilePic.jpg';
                  const uploadPath = 'profile/';

                  firebaseStorageServices
                      .uploadFile(filePath, fileName, context, uploadPath)
                      .then((value) => functionsController.showSnackBar(
                          context, 'Upload completed'));
                } else {
                  const SizedBox();
                }

                // UPDATING USER INFO
                updateInfo(
                  userName: userNameController.text,
                  bio: bioController.text,
                  location: locationController.text,
                );

                Get.offAll(const HomeScreen());
              },
              icon: const Icon(
                Icons.check,
                color: kBlack,
              ),
            ),
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: kBlack,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            'Edit Profile',
            style: TextStyle(color: kBlack),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
                                              .pickedImage ==
                                          null
                                      ? NetworkImage(userController.getUser.photoUrl)
                                      : FileImage(File(imagePickerController
                                          .pickedImage!
                                          .path)) as ImageProvider);
                            },
                          ),
                    TextButton(
                        onPressed: () {
                          imagePickerController.showBottomSheet(context);
                        },
                        child: const Text('Change Profile Picture')),
                    SizedBox(
                      height: 5.h,
                    ),
                    InputField(
                        hintText: 'User name', controller: userNameController),
                    SizedBox(
                      height: 5.h,
                    ),
                    InputField(hintText: 'Bio', controller: bioController),
                    SizedBox(
                      height: 5.h,
                    ),
                    InputField(
                        hintText: 'Location', controller: locationController),
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

//METHOD FOR UPDATE USER INFO
  void updateInfo({
    required String userName,
    required String bio,
    required String location,
  }) {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc('n55aTb73sBgAJtcV8DuT');
    docUser.update(
      {
        "userName": userName,
        "bio": bio,
        "location": location,
      },
    );
  }
}
