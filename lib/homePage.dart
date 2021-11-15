// ignore_for_file: camel_case_types, file_names

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:pro_final/home/list_screen/list_Screen.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import 'home/main_home.dart';
import 'home/notifications_screen/notif_screen.dart';
import 'home/profile_screen/profile_Screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int pageIndex = 0;
  List<Widget> pageList = [
    MainHome(),
    const ListScreen(),
    const notifScreen(),
    profileScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: 
            //pageList[pageIndex],
            
            PageTransitionSwitcher(
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) => 
              FadeThroughTransition(
                animation: primaryAnimation, 
                secondaryAnimation: 
                secondaryAnimation, 
                child: child,
                ),
                child: pageList[pageIndex],
              ),
        /*bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: pageIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index){
          setState(() {
            
            pageIndex = index;
            print(pageIndex);
          }); 
        },
      ),*/
        bottomNavigationBar: 
          TitledBottomNavigationBar(
          activeColor: const Color(0xFF33E1EC),
          inactiveColor: Colors.black45,
          enableShadow: true,
          reverse: true,
          currentIndex: pageIndex, // Use this to update the Bar giving a position
          onTap: (index) {
            setState((){
              pageIndex = index;
            }); 
          },
          items: [
            TitledNavigationBarItem(
              title: const Text('Home'),
              icon: const Icon(Icons.home_outlined),
            ),
            TitledNavigationBarItem(
              title: const Text('Lists'),
              icon: const Icon(Icons.list_alt),
            ),
            TitledNavigationBarItem(
              title: const Text('Notifications'),
              icon: const Icon(Icons.notifications_outlined),
            ),
            TitledNavigationBarItem(
              title: const Text('Profile'),
              icon: const Icon(Icons.person_outline),
            ),
          ],
        ),
        
      
      );
  }
}