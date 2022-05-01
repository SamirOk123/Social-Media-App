import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/controllers/image_picker.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/widgets/gradient.dart';

class NewStory extends StatelessWidget {
  NewStory({Key? key}) : super(key: key);

  //IMAGE PICKER CONTROLLER DEPENDENCY INJECTION
  final imagePickerController = Get.put(ImagePickerController());

  //POST STORY METHOD
  void postStory(String uid, String username, String profImage,
      BuildContext context) async {
    try {
      String result = await firebaseStorageServices.uploadStory(
          uid: uid,
          username: username,
          file: imagePickerController.pickedImage!,
          profImage: profImage);
      if (result == 'success') {
        functionsController.showSnackBar(context, 'Posted');

        Get.back();
      } else {
        functionsController.showSnackBar(context, result);
      }
    } catch (e) {
      functionsController.showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomGradient(
          child: Center(
            child: GetBuilder<ImagePickerController>(
              builder: (controller) {
                return Container(
                  child: imagePickerController.pickedImage == null
                      ? InkWell(
                          child: Image.asset(
                            'assets/icons/photo.png',
                            width: 27,
                            height: 27,
                          ),
                          onTap: () {
                            imagePickerController.showBottomSheet(context);
                          },
                        )
                      : InkWell(
                          onTap: () =>
                              imagePickerController.showBottomSheet(context),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  File(imagePickerController.pickedImage!.path),
                                ),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  //UPLOADING STORY
                  if (imagePickerController.pickedImage != null) {
                    postStory(
                        userController.getUser.uid,
                        userController.getUser.userName,
                        userController.getUser.photoUrl,
                        context);
                  } else {
                    functionsController.showSnackBar(
                        context, 'Please select an image!');
                  }
                },
                child: const Text('Post'))
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: kBlack,
            ),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            'Add Story',
            style: kHeaderStyle,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}
