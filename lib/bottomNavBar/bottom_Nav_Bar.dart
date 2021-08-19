// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class BottomNavBar1 extends StatelessWidget {
  const BottomNavBar1({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return TitledBottomNavigationBar(
      activeColor: const Color(0xFF33E1EC),
      inactiveColor: Colors.black45,
      enableShadow: true,
      reverse: true,
      currentIndex: 0, // Use this to update the Bar giving a position
      onTap: (index) {
        //print("Selected Index: $index");
      },
      items: [
        TitledNavigationBarItem(
          title: const Text('Home'), 
          icon: const Icon(Icons.home_outlined),
        ),
        TitledNavigationBarItem(
          title: const Text('Voice'), 
          icon: const Icon(Icons.mic),
        ),

        TitledNavigationBarItem(
          title: const Text('Notification'), 
          icon: const Icon(Icons.notifications_outlined),
        ),
        TitledNavigationBarItem(
          title: const Text('Profile'), 
          icon: const Icon(Icons.person_outline),
        ),
      ],
    );
  }
}
