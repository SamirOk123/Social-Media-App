import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/widgets/custom_button.dart';
import 'package:social_media/widgets/custom_circle_avatar.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/input_field.dart';

class AuthFinalStep extends StatefulWidget {
  const AuthFinalStep({Key? key}) : super(key: key);

  @override
  State<AuthFinalStep> createState() => _AuthFinalStepState();
}

class _AuthFinalStepState extends State<AuthFinalStep> {
  //IMAGE PICKER INSTANCE
  final ImagePicker imagePicker = ImagePicker();

  //VARIABLE TO STORE PICKED IMAGE
  XFile? pickedImage;

//GETTING IMAGE FROM DEVICE
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    setState(() {
      pickedImage = pickedFile;
    });
  }

  //TEXT EDITING CONTROLLERS
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final usernameController = TextEditingController();

  final bioController = TextEditingController();

  final locationController = TextEditingController();

  

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
                    CustomCircleAvatar(
                        backgroundImage: pickedImage != null
                            ? FileImage(File(pickedImage!.path))
                                as ImageProvider
                            : const AssetImage('assets/images/user.jpg')),
                    TextButton(
                        onPressed: () {
                          showBottomSheet(context);
                        },
                        child: const Text('Pick Image')),
                    InputField(
                      controller: emailController,
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    InputField(
                      controller: passwordController,
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.person),
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

                    // Obx(
                    //   () => CustomButton(
                    //       label:
                    //           'Date of birth:  ${datePickerController.date.value.day} - ${datePickerController.date.value.month} - ${datePickerController.date.value.year}',
                    //       onPressed: () async {
                    //         DateTime? newDate = await showDatePicker(
                    //             context: context,
                    //             initialDate: datePickerController.date.value,
                    //             firstDate: DateTime(1947),
                    //             lastDate: DateTime(3000));
                    //         if (newDate == null) return;

                    //         datePickerController.date.value = newDate;
                    //       }),
                    // ),
                    SizedBox(
                      height: 5.h,
                    ),
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: IconButton(
                    //     icon: Icon(
                    //       Icons.keyboard_arrow_right,
                    //       size: 6.h,
                    //     ),
                    //     onPressed: () {
                    //       // createUser(
                    //       //     userName: userNameController.text,
                    //       //     bio: bioController.text,
                    //       //     location: locationController.text,
                    //       //     dateOfBirth:
                    //       //         '${datePickerController.date.value.day} - ${datePickerController.date.value.month} - ${datePickerController.date.value.year}');
                    //     },
                    //   ),
                    // ),
                    Obx(
                      () => CustomButton(
                        label: signupController.isLoading.value == true
                            ? const CircularProgressIndicator(
                                color: kWhite,
                              )
                            : const Text('SignUp'),
                        onPressed: () async {
                         if(pickedImage!=null){
                            await signupController.signupUser(
                              context: context,
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              bio: bioController.text,
                              location: locationController.text,
                              file: pickedImage!);
                         
                         }else{
                           functionsController.showSnackBar(context, 'Please select an image!');
                         }
                        },
                      ),
                    ),
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
