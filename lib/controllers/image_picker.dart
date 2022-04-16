import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/dependency_injection.dart';

class ImagePickerController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();

  XFile? pickedImage;

  

  //METHOD FOR GETTING IMAGE FROM DEVICE
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    pickedImage = pickedFile;
    update();
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
                label: const Text('Camera'),
                icon: const Icon(Icons.camera_alt),
                onPressed: () {
                  getImage(ImageSource.camera);
                }),
            TextButton.icon(
                label: const Text('Gallery'),
                icon: const Icon(Icons.image),
                onPressed: () {
                  getImage(ImageSource.gallery);
                }),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
   dispose();
    super.onClose();
  }
}
