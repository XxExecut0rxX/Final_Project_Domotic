// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

class micScreen extends StatefulWidget {
  const micScreen({ Key? key }) : super(key: key);

  @override
  _micScreenState createState() => _micScreenState();
}

class _micScreenState extends State<micScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30.0,),
          SingleChildScrollView(
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Press the\n",
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "Microphone Button",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(
                    text: " and\nstart speaking ",
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                style: TextStyle(
                  fontSize: 35,
                  
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Image(
            image: AssetImage(
              'assets/Images/voice_wave.png',
            ),
            height: 11.0,
          ),
          const SizedBox(width: double.infinity,height: 10,),
          FloatingActionButton.large(
            onPressed: (){},
            child: const Icon(Icons.mic_none),
          ),
        ],
      ),
    );
  }
}
