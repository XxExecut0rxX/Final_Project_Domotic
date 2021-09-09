import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pro_final/main.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ButtonHumidityScreen extends StatefulWidget {
  const ButtonHumidityScreen({Key? key}) : super(key: key);

  @override
  _ButtonHumidityScreenState createState() => _ButtonHumidityScreenState();
}

class _ButtonHumidityScreenState extends State<ButtonHumidityScreen> {
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
      db.child('floor$index1/room$index').update({'fan': 'off'});
    } else {
      db.child('floor$index1/room$index').update({'fan': 'on'});
    }
  }

  bool switchtoggle = false;
  void updateSwitchToggler(int index, int index1) {
    index = index + 1;
    index1 = index1 + 1;
    db.child('floor$index1/room$index').child('fan').onValue.listen((event) {
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
    updateSwitchToggler(_focusedIndexRooms, _focusedIndexFloors);
    updateInitialTemp(_focusedIndexRooms, _focusedIndexFloors);
  }

  void _onItemFocusFloors(int index) {
    _focusedIndexFloors = index;
    updateSwitchToggler(_focusedIndexRooms, _focusedIndexFloors);
    updateInitialTemp(_focusedIndexRooms, _focusedIndexFloors);
    InitRoomsFloors(_focusedIndexFloors);
  }

  //fan button value
  Color fanBackColor = Colors.white;
  Color iconColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //bar
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyApp()));
                  },
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
                const Text('Humidity'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
    
            //stats bar
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        "$humidity%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Icon(
                        Icons.opacity_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.green.shade300,
                ),
                borderRadius: BorderRadius.circular(
                  8,
                ),
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
                    child: Text('0%'),
                    bottom: 50,
                    left: 1,
                  ),
                  const Positioned(
                    child: Text('100%'),
                    bottom: 50,
                    right: -10,
                  ),
                  const Positioned(
                    child: Text('Humidity level'),
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
                    max: 100,
                    initialValue: humidity.toDouble(),
                    appearance: CircularSliderAppearance(
                      infoProperties: InfoProperties(
                        modifier: (value) {
                          final roundedValue = value.ceil().toInt().toString();
                          return '$roundedValue %';
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
                        trackColor: Colors.green.shade900,
                        dotColor: Colors.white,
                        progressBarColors: [
                          Colors.greenAccent.shade400,
                          Colors.greenAccent.shade100,
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
            const SizedBox(
              height: 20,
            ),
            //switch
            FlutterSwitch(
              activeIcon: Icon(Icons.hvac),
              width: 110.0,
              height: 55.0,
              valueFontSize: 25.0,
              toggleSize: 50.0,
              value: switchtoggle,
              borderRadius: 30.0,
              padding: 5.0,
              activeText: 'On',
              inactiveText: 'Off',
              showOnOff: true,
              activeColor: Colors.greenAccent.shade700,
              inactiveColor: Colors.black12,
              onToggle: (val) {
                setState(() {
                  status = val;
                  updateDataonToggleSwitch(
                      status, _focusedIndexRooms, _focusedIndexFloors);
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
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
                            color: Colors.green.shade200.withOpacity(0.5),
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
                            color: Colors.green.shade800.withOpacity(0.5),
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
      ),
    );
  }
}
