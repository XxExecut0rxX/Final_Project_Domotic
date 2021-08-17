// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CardHumidity extends StatefulWidget {
  const CardHumidity({ Key? key }) : super(key: key);

  @override
  CardHumidityState createState() => CardHumidityState();
}

class CardHumidityState extends State<CardHumidity> {
  @override
  Widget build(BuildContext context) {
    String inHumidity = "  35 %";

    final textHumidity = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Humidity \nLevel",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          inHumidity,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
    
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
          ),
        child: textHumidity,
      ),
      width: 156,
      height: 261,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1119c281),
            blurRadius: 2.40,
            offset: Offset(0, 1.49),
          ),
          BoxShadow(
            color: Color(0x1919c281),
            blurRadius: 6.64,
            offset: Offset(0, 4.13),
          ),
          BoxShadow(
            color: Color(0x2119c281),
            blurRadius: 15.98,
            offset: Offset(0, 9.95),
          ),
          BoxShadow(
            color: Color(0x3319c281),
            blurRadius: 53,
            offset: Offset(0, 33),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff16bf82), Color(0x001cc47e)],
        ),
      ),
    );
  }
}