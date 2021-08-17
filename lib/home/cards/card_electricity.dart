import 'package:flutter/material.dart';

class CardElectricity extends StatefulWidget {
  const CardElectricity({ Key? key }) : super(key: key);

  @override
  _CardElectricityState createState() => _CardElectricityState();
}

class _CardElectricityState extends State<CardElectricity> {

  @override
  Widget build(BuildContext context) {
    String inElectricity = "230.5 W";

    final textElectricity = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Electricity\nUsage",
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
          inElectricity,
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
      width: 156,
      height: 232,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 25,
              ),
              child: textElectricity,
            ),
            width: 156,
            height: 232,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple.shade200),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x11f500ff),
                  blurRadius: 2.40,
                  offset: Offset(0, 1.49),
                ),
                BoxShadow(
                  color: Color(0x19f500ff),
                  blurRadius: 6.64,
                  offset: Offset(0, 4.13),
                ),
                BoxShadow(
                  color: Color(0x21f500ff),
                  blurRadius: 15.98,
                  offset: Offset(0, 9.95),
                ),
                BoxShadow(
                  color: Color(0x33f500ff),
                  blurRadius: 43,
                  offset: Offset(0, 33),
                ),
              ],
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffe437d3), Color(0x00ea2bee)],
              ),
            ),
            padding: const EdgeInsets.all(1),
          ),
        ],
      ),
    );
  }
}
