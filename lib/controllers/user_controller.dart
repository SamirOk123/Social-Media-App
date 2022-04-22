import 'package:get/get.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/models/user_model.dart';

class UserController extends GetxController{
  User? _user;
  User get getUser => _user!;
  

  //GETTING CURRENT USER DETAILS
  Future<void> refreshUser()async{
    User user = await firebaseAuthServices.getUserDetails();
    _user = user;
    update();
  }
}