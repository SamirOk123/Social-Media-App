import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/constants.dart';
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
  //IMAGE PICKER INSTANCE
  final ImagePicker imagePicker = ImagePicker();

  final descriptionController = TextEditingController();

  //VARIABLE TO STORE PICKED IMAGE
  XFile? pickedImage;

  //METHOD FOR GETTING IMAGE FROM DEVICE
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    setState(() {
      pickedImage = pickedFile;
    });
  }

  //POST IMAGE
  void postImage(String uid, String username, String profImage) async {
    try {
      String result = await firebaseStorageServices.uploadPost(
          description: descriptionController.text,
          uid: uid,
          username: username,
          file: pickedImage!,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'New Post',
            style: TextStyle(color: kBlack),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Post',
                style: TextStyle(color: kBlack),
              ),
              onPressed: () {
                //UPLOADING IMAGE
                if (pickedImage != null) {
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
              isLoading ? const LinearProgressIndicator() : const SizedBox(),
              ListTile(
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
                trailing: pickedImage == null
                    ? IconButton(
                        icon: Image.asset(
                          'assets/icons/photo.png',
                          width: 27,
                          height: 27,
                        ),
                        onPressed: () {
                          showBottomSheet(context);
                        },
                      )
                    : Container(
                        width: 33,
                        height: 33,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(pickedImage!.path),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //BOTTOM SHEET
  void showBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                label: const Text(
                  'Camera',
                  style: TextStyle(color: kBlack),
                ),
                icon: const Icon(
                  Icons.camera_alt,
                  color: kBlack,
                ),
                onPressed: () {
                  getImage(ImageSource.camera);
                }),
            TextButton.icon(
                label: const Text(
                  'Gallery',
                  style: TextStyle(color: kBlack),
                ),
                icon: const Icon(
                  Icons.image,
                  color: kBlack,
                ),
                onPressed: () {
                  getImage(ImageSource.gallery);
                }),
          ],
        ),
      ),
    );
  }
}
