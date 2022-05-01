import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/constants.dart';

class ImagePickerController extends GetxController {
  //IMAGE PICKER INSTANCE
  final ImagePicker imagePicker = ImagePicker();

  //VARIABLE TO STORE PICKED IMAGE
  File? pickedImage;

  //GETTING IMAGE FROM DEVICE
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile == null) {
      return;
    } else {
      File file = File(pickedFile.path);
      pickedImage = file;
      update();
    }
  }

  //IMAGE CROP METHOD
  Future<void> cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedImage!.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: const AndroidUiSettings(
          activeControlsWidgetColor: kBlue,
          toolbarTitle: 'Crop Image',
          toolbarColor: kBlue,
          toolbarWidgetColor: kWhite,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    if (croppedFile != null) {
      pickedImage = croppedFile;
      update();
    }
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
                  Get.back();
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
                  Get.back();
                }),
          ],
        ),
      ),
    );
  }
}
