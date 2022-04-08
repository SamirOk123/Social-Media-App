import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/dependency_injection.dart';
import 'package:social_media/widgets/gradient.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: navigationController.selectedIndex.value,
            onTap: navigationController.onItemTapped,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
             
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
       
        body: CustomGradient(
          child: Obx(
            () => Center(
              child: navigationController.pages
                  .elementAt(navigationController.selectedIndex.value),
            ),
          ),
        ),
      ),
    );
  }
}
