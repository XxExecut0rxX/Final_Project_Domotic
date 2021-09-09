// ignore_for_file: camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class buttonTempScreen extends StatefulWidget {
  const buttonTempScreen({ Key? key }) : super(key: key);

  @override
  _buttonTempScreenState createState() => _buttonTempScreenState();
}

class _buttonTempScreenState extends State<buttonTempScreen> {
  
  // ignore: slash_for_doc_comments
  /***********FIREBASE IMPLEMENTATION**********/
  final db = FirebaseDatabase.instance.reference();
  String _displ = 'on';

  @override
  void initState() {
    super.initState();
    updateSwitchToggler(_focusedIndexRooms, _focusedIndexFloors);
    updateInitialTemp(_focusedIndexRooms, _focusedIndexFloors);
    InitRoomsFloors(_focusedIndexFloors);
  }

  //switch updates
  void updateDataonToggleSwitch(bool val, int index, int index1) {
    index = index + 1;
    index1 = index1 + 1;
    if (!val) {
      db.child('floor$index1/room$index').update({'lights': 'off'});
    } else {
      db.child('floor$index1/room$index').update({'lights': 'on'});
    }
  }

  bool switchtoggle = false;
  void updateSwitchToggler(int index, int index1) {
    index = index + 1;
    index1 = index1 + 1;
    db.child('floor$index1/room$index').child('lights').onValue.listen((event) {
      final String desc = event.snapshot.value;
      _displ = desc;
      setState(() {
        if (_displ == 'on') {
          switchtoggle = true;
          } else {
          switchtoggle = false;
        }
      });
    });
  }

  //slider brightness updates
  double brightness = 0;
  int humidity = 0;


  void updateInitialTemp(int index, int index1) {
    index += 1;
    index1 += 1;
    //slider temp
    db
        .child('floor$index1/room$index/sensors')
        .child('temperature')
        .onValue
        .listen((event) {
      final int desc = event.snapshot.value;
      setState(() {
        brightness = desc.toDouble();

      });
    });
    //humidity
    db
        .child('floor$index1/room$index/sensors')
        .child('humidity')
        .onValue
        .listen((event) {
      final int desc = event.snapshot.value;
      setState(() {
        humidity = desc;
      });
    });
  }

  //initializer rooms and floors : just rooms for now
  // ignore: non_constant_identifier_names
  void InitRoomsFloors(int index1) {
    index1 += 1;
    db.child('floor$index1').child('Nrooms').onValue.listen((event) {
      final int desc = event.snapshot.value;
      setState(() {
        nRooms = desc;
        _focusedIndexRooms = 0;
      });
    });
  }
  ////////////////////////////////////////////

  final bar = Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(
        width: 10,
      ),
      TextButton(
        onPressed: () {},
        child: Row(
          children: const [
            Icon(Icons.arrow_back_ios),
            Text('Back'),
          ],
        ),
      ),
      const SizedBox(
        width: 95,
      ),
      const Text('Lights'),
    ],
  );

  bool status = true;

  //horizontal snap bar
  List<String> roomdata = [
    'Room1',
    'Room2',
    'Room3',
    'Room4',
    'Room5',
    'Room6',
    'Room7'
  ];
  List<String> floordata = [
    'floor1',
    'floor2',
  ];

  int nRooms = 0;
  int nFloors = 0;
  int _focusedIndexRooms = 0;
  int _focusedIndexFloors = 0;

  Widget _buildListItemRooms(BuildContext context, int index) {
    //horizontal
    if (index == roomdata.length) {
      return const Center(
        child: //CircularProgressIndicator(),
            Text(''),
      );
    }
    return SizedBox(
      width: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 100,
            child: Center(
              child: Text(
                roomdata[index],
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItemFloors(BuildContext context, int index) {
    //horizontal
    if (index == floordata.length) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 100,
            child: Center(
              child: Text(
                floordata[index],
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _onItemFocusRooms(int index) {
    _focusedIndexRooms = index;
    updateInitialTemp(_focusedIndexRooms, _focusedIndexFloors);
  }
  void _onItemFocusFloors(int index) {
    _focusedIndexFloors = index;
    updateInitialTemp(_focusedIndexRooms, _focusedIndexFloors);
    InitRoomsFloors(_focusedIndexFloors);
  }
  
  //fan button value
  Color fanBackColor = Colors.white;
  Color iconColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          bar,
          const SizedBox(
            height: 10,
          ),
          
          //stats bar
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children: [
                  Text(
                    "$humidity%",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  const Icon(
                    Icons.opacity_outlined,
                    color: Colors.white,
                  ),
                ],),
                Row(
                  children: [
                    Text(
                      "${brightness.round()}°C",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      width: 1.0,
                    ),
                    const Icon(
                      Icons.thermostat_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      "Normal",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      CupertinoIcons.bolt,
                      color: Colors.white,
                    )
                  ],
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.orange.shade400,
              ),
              borderRadius: BorderRadius.circular(
                8,
              ),
              boxShadow: const [
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
              gradient:  const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffff5620), 
                  Color(0x00f8772e)
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          //slider bar
          Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.center,
              children: [
                const Positioned(
                  child: Text('0°C'),
                  bottom: 50,
                  left: 1,
                ),
                const Positioned(
                  child: Text('70°C'),
                  bottom: 50,
                  right: -10,
                ),
                const Positioned(
                  child: Text('Temperature level'),
                  bottom: 10,
                ),
                Positioned(
                  top: 50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                //slider
                SleekCircularSlider(
                    min: 0,
                    max: 70,
                    initialValue: brightness,
                    appearance: CircularSliderAppearance(
                      infoProperties: InfoProperties(

                        modifier: (value) {
                          final roundedValue = value.ceil().toInt().toString();
                          return '$roundedValue °C';
                        },
                        mainLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                      size: 300,
                      customColors: CustomSliderColors(
                        hideShadow: true,
                        shadowMaxOpacity: 0.2,
                        shadowStep: 30,
                        trackColor: Colors.orange.shade900,
                        dotColor: Colors.white,
                        progressBarColors: [
                          Colors.deepOrange.shade600,
                          Colors.orange.shade200,
                          Colors.orange.shade50,
                          ],
                      ),
                      customWidths: CustomSliderWidths(
                        trackWidth: 4,
                        handlerSize: 7,
                      ),
                    ),
                    /*onChange: (value) {
                        brightness = value;
                        updateSlider(_focusedIndexRooms, value, _focusedIndexFloors);
                      }*/
                    ),
                
              ]),
          const SizedBox(height: 10,),
          OutlinedButton(
            child: const Icon(Icons.auto_awesome,size: 10,),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(40, 40)),
              side: MaterialStateProperty.all(const BorderSide(width: 1)),
              backgroundColor: MaterialStateProperty.all(fanBackColor),
              foregroundColor: MaterialStateProperty.all(iconColor),
            ),
            onPressed: (){
              setState(() {
                if(fanBackColor == Colors.red) {
                  fanBackColor = Colors.white;
                  iconColor = Colors.black;
                } else {
                  fanBackColor = Colors.red;
                  iconColor = Colors.white;
                }
              });
            }, 
            //icon: Icon(Icons.add), 
            //label: Text(''),
          ),
          const SizedBox(height: 5,),
          //scrollsnaplist rooms
          Expanded(
            child: Stack(children: [
              Center(
                child: Container(
                  width: 90,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.shade200.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(2, 4),
                        ),
                      ]),
                ),
              ),
              ScrollSnapList(
                onItemFocus: _onItemFocusRooms,
                itemSize: 140,
                dynamicItemSize: true,
                itemBuilder: _buildListItemRooms,
                itemCount: nRooms,
                reverse: false,
              ),
            ]),
          ),
          const SizedBox(
            height: 10,
          ), //scrollsnaplist floors
          Expanded(
            child: Stack(children: [
              Center(
                child: Container(
                  width: 70,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.shade800.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(2, 4),
                        ),
                      ]),
                ),
              ),
              ScrollSnapList(
                onItemFocus: _onItemFocusFloors,
                itemSize: 140,
                dynamicItemSize: true,
                itemBuilder: _buildListItemFloors,
                itemCount: floordata.length,
                reverse: false,
              ),
            ]),
          ),

          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}