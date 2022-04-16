import 'package:get/get.dart';
import 'package:social_media/controllers/date_picker.dart';
import 'package:social_media/controllers/functions_controller.dart';
import 'package:social_media/controllers/image_picker.dart';
import 'package:social_media/controllers/navigation.dart';
import 'package:social_media/controllers/obscure_text.dart';
import 'package:social_media/controllers/phone_number_controller.dart';
import 'package:social_media/firebase/auth_services.dart';
import 'package:social_media/firebase/storage_services.dart';

DatePickerController datePickerController = Get.put(DatePickerController());
ObscureTextController obscureTextController = Get.put(ObscureTextController());
NavigationController navigationController = Get.put(NavigationController());
PhoneNumberController phoneNumberController = Get.put(PhoneNumberController());
FunctionsController functionsController = Get.put(FunctionsController());
ImagePickerController imagePickerController = Get.put(ImagePickerController());

//Instances
FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
FirebaseStorageServices firebaseStorageServices = FirebaseStorageServices();
