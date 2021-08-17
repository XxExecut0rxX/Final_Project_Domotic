import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class CardLights extends StatefulWidget {
  const CardLights({ Key? key }) : super(key: key);

  @override
  _CardLightsState createState() => _CardLightsState();
}

class _CardLightsState extends State<CardLights> {

  final db = FirebaseDatabase.instance.reference();

  String _displ = 'Init';

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    db.child('floor1').child('led1').onValue.listen((event) {
      final String desc = event.snapshot.value;
      setState(() {
        _displ = desc;
      });
    });
  }
  
  void updateData(){
    if(_displ == 'On') {
      db.child('floor1').update(
        {
          'led1' : 'Off'
        }
      );
    } else{
      db.child('floor1').update({'led1': 'On'});
    }
  }

  @override
  Widget build(BuildContext context) {

    final textLights = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "General \nLights",
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
          "$_displ :",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );

    return GestureDetector( 
      onTap: () { 
        updateData();
      },
      child: Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        child: textLights,
      ),
      width: 156,
      height: 232,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue.shade200,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11108ec5),
            blurRadius: 2.40,
            offset: Offset(0, 1.49),
          ),
          BoxShadow(
            color: Color(0x19108ec5),
            blurRadius: 6.64,
            offset: Offset(0, 4.13),
          ),
          BoxShadow(
            color: Color(0x21108ec5),
            blurRadius: 15.98,
            offset: Offset(0, 9.95),
          ),
          BoxShadow(
            color: Color(0x33108ec5),
            blurRadius: 53,
            offset: Offset(0, 33),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff077cbe), Color(0x0017a1cd)],
        ),
      ),
    )
    );
  }
}