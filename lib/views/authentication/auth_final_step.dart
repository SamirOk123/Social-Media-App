import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/views/main/home_screen.dart';
import 'package:social_media/widgets/custom_button.dart';
import 'package:social_media/widgets/gradient.dart';
import 'package:social_media/widgets/input_field.dart';

class AuthFinalStep extends StatelessWidget {
  AuthFinalStep({Key? key}) : super(key: key);

  final userNameController = TextEditingController();
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
                    Center(
                      child: Text(
                        'Twitch!',
                        style: TextStyle(fontSize: 35.sp, fontFamily: 'Samir'),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    InputField(
                      controller: userNameController,
                      hintText: 'User name',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    InputField(
                      controller: bioController,
                      hintText: 'Bio',
                      prefixIcon: const Icon(Icons.info),
                    ),
                    SizedBox(
                      height: 5.h,
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
                          label:
                              'Date of birth:  ${datePickerController.date.value.day} - ${datePickerController.date.value.month} - ${datePickerController.date.value.year}',
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: datePickerController.date.value,
                                firstDate: DateTime(1947),
                                lastDate: DateTime(3000));
                            if (newDate == null) return;

                            datePickerController.date.value = newDate;
                          }),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          size: 6.h,
                        ),
                        onPressed: () {
                          createUser(
                              userName: userNameController.text,
                              bio: bioController.text,
                              location: locationController.text,
                              dateOfBirth:
                                  '${datePickerController.date.value.day} - ${datePickerController.date.value.month} - ${datePickerController.date.value.year}');
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

  void createUser(
      {required String userName,
      BuildContext? context,
      required String bio,
      required String location,
      required String dateOfBirth}) {
    if (userName.isNotEmpty || bio.isNotEmpty || location.isNotEmpty) {
      final newUser = User(
          location: location,
          bio: bio,
          dateOfBirth: dateOfBirth,
          userName: userName);
      firebaseStorageServices.createUser(newUser);
      Get.offAll(const HomeScreen());
    } else {
      functionsController.showSnackBar(context!,'Please fill all the fields');
    }
  }
}
