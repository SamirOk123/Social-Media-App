import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/controllers/image_picker.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/widgets/gradient.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  //LOADING VARIABLE
  bool isLoading = false;

  //TEXT EDITING CONTROLLER
  final descriptionController = TextEditingController();

  //POST IMAGE METHOD
  void postImage(String uid, String username, String profImage) async {
    try {
      String result = await firebaseStorageServices.uploadPost(
          description: descriptionController.text,
          uid: uid,
          username: username,
          file: imagePickerController.pickedImage!,
          profImage: profImage);
      if (result == 'success') {
        functionsController.showSnackBar(context, 'Posted');
        setState(() {
          isLoading = false;
        });
        Get.back();
      } else {
        functionsController.showSnackBar(context, result);
      }
    } catch (e) {
      functionsController.showSnackBar(context, e.toString());
    }
  }

  //IMAGE PICKER CONTROLLER DEPENDENCY INJECTION
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ImagePickerController>(
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'New Post',
                style: TextStyle(color: kBlack),
              ),
              actions: [
                imagePickerController.pickedImage != null
                    ? IconButton(
                        onPressed: () {
                          imagePickerController.cropImage();
                        },
                        icon: Icon(Icons.crop, color: kBlack,size: 3.h,),
                      )
                    : const SizedBox(), 
                TextButton(
                  child: const Text(
                    'Post',
                    style: TextStyle(color: kBlack),
                  ),
                  onPressed: () {
                    //UPLOADING IMAGE
                    if (imagePickerController.pickedImage != null) {
                      setState(() {
                        isLoading = true;
                      });
                      postImage(
                          userController.getUser.uid,
                          userController.getUser.userName,
                          userController.getUser.photoUrl);
                    } else {
                      functionsController.showSnackBar(
                          context, 'Please select an image!');
                    }
                  },
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
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: CustomGradient(
              child: Column(
                children: [
                  isLoading
                      ? const LinearProgressIndicator()
                      : const SizedBox(),
                  GetBuilder<ImagePickerController>(
                    builder: (controller) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(userController.getUser.photoUrl),
                        ),
                        title: TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Type Something...',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                        trailing: imagePickerController.pickedImage == null
                            ? InkWell(
                                child: Image.asset(
                                  'assets/icons/photo.png',
                                  width: 27,
                                  height: 27,
                                ),
                                onTap: () {
                                  imagePickerController
                                      .showBottomSheet(context);
                                },
                              )
                            : Container(
                                width: 33,
                                height: 33,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(imagePickerController
                                          .pickedImage!.path),
                                    ),
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
