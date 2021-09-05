// ignore_for_file: camel_case_types, file_names


import 'package:flutter/material.dart';

class profileScreen extends StatelessWidget {
  profileScreen({ Key? key }) : super(key: key);

  final bar = const Center(
    child: Text("Profile"),
  );

  final profilePicture = SizedBox(
    width: 115,
    height: 115,
    child: Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage('https://github.com/XxExecut0rxX/Final_Project_Domotic/blob/master/assets/Images/profile/p.jpg'),
        ),
        Positioned(
          right: -12,
          bottom: 0,
          child: SizedBox(
            height: 46,
            width: 46,
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(color: Colors.white),
                )),
                backgroundColor: MaterialStateProperty.all(const Color(0xFFF5F6F9)),
              ),
              onPressed: () {}, 
              child: const Icon(
                  Icons.photo_camera,
                  color: Colors.black45,
                ),
            ),
          ),
        )
      ]
    ),
  );

  final account = ProfileMenu(
    icon: Icons.person_outline,
    text: "My account" , 
    press: () {}
  );
  final but = ProfileMenu(
    icon: Icons.person_outline,
    text: "My account" , 
    press: () {}
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          bar,
          const SizedBox(height: 20),
          profilePicture,
          const SizedBox(height: 20),
          but,
          account,
        ],
    )
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        onPressed: press,
        child: Row(
          children:  [
            Icon(
              icon,
              size: 44,
              color: Colors.black54,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(
              text
              //style: Theme.of(context).textTheme.bodyText1,
            ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const  Color(0xFFF5F6F9)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ),
    );
  }
}