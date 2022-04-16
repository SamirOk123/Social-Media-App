import 'package:get/get.dart';
import 'package:social_media/views/main/home.dart';
import 'package:social_media/views/main/notifications.dart';
import 'package:social_media/views/main/profile.dart';
import 'package:social_media/views/main/search.dart';

class NavigationController extends GetxController {
  RxList pages =
      [const HomePage(), const Search(), const Notifications(), Profile()].obs;
  RxInt selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
