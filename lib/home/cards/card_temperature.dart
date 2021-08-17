import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CardTemperature extends StatefulWidget {
  const CardTemperature({ Key? key }) : super(key: key);

  @override
  _CardTemperatureState createState() => _CardTemperatureState();
}

class _CardTemperatureState extends State<CardTemperature> {
  //Firebase Reference
  final db = FirebaseDatabase.instance.reference();

  String _displ = 'REsults';

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    db.child('1').child('desc').onValue.listen((event) {
      final String desc = event.snapshot.value;
      setState(() {
        _displ = desc;
      });
    });
  }
  //final firebase reference
  @override
  Widget build(BuildContext context) {
    String inTemp = "  $_displ °C"; 
    
    final textTemp = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Home \nTemperature",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 40,),
        Text(
          inTemp,
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
        child: textTemp,
      ),
      width: 156,
      height: 259,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange.shade400,),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11fc6628),
            blurRadius: 2.40,
            offset: Offset(0, 1.49),
          ),
          BoxShadow(
            color: Color(0x19fc6628),
            blurRadius: 6.64,
            offset: Offset(0, 4.13),
          ),
          BoxShadow(
            color: Color(0x21fc6628),
            blurRadius: 15.98,
            offset: Offset(0, 9.95),
          ),
          BoxShadow(
            color: Color(0x33fc6628),
            blurRadius: 53,
            offset: Offset(0, 33),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffff5620), 
            Color(0x00f8772e)],
        ),
      ),
    );
  }
}