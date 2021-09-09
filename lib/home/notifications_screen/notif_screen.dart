import 'package:flutter/material.dart';

// ignore: camel_case_types
class notifScreen extends StatefulWidget {
  const notifScreen({ Key? key }) : super(key: key);

  @override
  _notifScreenState createState() => _notifScreenState();
}

// ignore: camel_case_types
class _notifScreenState extends State<notifScreen> {

  final bar = const Center(
    child: Text("Notifications"),
  );

  final notifIcon = Image.network(
    'https://hotemoji.com/images/dl/s/bell-emoji-by-twitter.png',
    height: 200.0,
    color: const Color.fromRGBO(255, 255, 255, 0.3),
    colorBlendMode: BlendMode.modulate,
  );

  final noNotif = Column(
    children: const [
      Text('Nothing Here!!!',
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.black54,
      ),
      ),
      SizedBox(height: 10,),
      Text('No notifications yet, Tab the configuration settings and check again',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black45,
        ),
      ),
    ]
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bar,
            const SizedBox(height: 50,),
            notifIcon,
            const SizedBox(height: 50,),
            noNotif,
          ],
        ),
      ),
    );
  }
}