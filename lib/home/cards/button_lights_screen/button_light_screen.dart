// ignore_for_file: camel_case_types, duplicate_ignore, slash_for_doc_comments, non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

// ignore: camel_case_types
class lightButtonScreen extends StatefulWidget {
  const lightButtonScreen({Key? key}) : super(key: key);

  @override
  _lightButtonScreenState createState() => _lightButtonScreenState();
}

class _lightButtonScreenState extends State<lightButtonScreen> {
  /***********FIREBASE IMPLEMENTATION**********/
  final db = FirebaseDatabase.instance.reference();
  String _displ = 'on';

  @override
  void initState() {
    super.initState();
    updateSwitchToggler(_focusedIndexRooms, _focusedIndexFloors);
    updateInitialSlider(_focusedIndexRooms, _focusedIndexFloors);
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
          light_on_off = Image.network(
              'https://github.com/XxExecut0rxX/Final_Project_Domotic/blob/master/assets/Images/lightsicon/lightson.png?raw=true');
        } else {
          switchtoggle = false;
          light_on_off = Image.network(
              'https://github.com/XxExecut0rxX/Final_Project_Domotic/blob/master/assets/Images/lightsicon/lightsoff.png?raw=true');
        }
      });
    });
  }

  //slider brightness updates
  double brightness = 0;
  void updateSlider(int index, double value, int index1) {
    index = index + 1;
    index1 = index1 + 1;
    int inval = value.round();
    db.child('floor$index1/room$index').update({'brightness': inval});
  }

  void updateInitialSlider(int index, int index1) {
    index += 1;
    index1 += 1;
    //slider
    db.child('floor$index1/room$index').child('brightness').onValue.listen((event) {
      final int desc = event.snapshot.value;
      setState(() {
        brightness = desc.toDouble();
      });
    });
  }
  
  //initializer rooms and floors : just rooms for now
  void InitRoomsFloors(int index1){
    index1 += 1;
    db
        .child('floor$index1')
        .child('Nrooms')
        .onValue
        .listen((event) {
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

  //center light on off icon variable
  Image light_on_off = Image.network(
      'https://github.com/XxExecut0rxX/Final_Project_Domotic/blob/master/assets/Images/lightsicon/lightson.png?raw=true');

  void _onItemFocusRooms(int index) {
    _focusedIndexRooms = index;
    updateSwitchToggler(_focusedIndexRooms, _focusedIndexFloors);
    updateInitialSlider(_focusedIndexRooms, _focusedIndexFloors);
  }
  void _onItemFocusFloors(int index) {
    _focusedIndexFloors = index;
    updateSwitchToggler(_focusedIndexRooms, _focusedIndexFloors);
    updateInitialSlider(_focusedIndexRooms, _focusedIndexFloors);
    InitRoomsFloors(_focusedIndexFloors);
  }

  //main widget
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          bar,
          const SizedBox(
            height: 50,
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
                  child: Text('Brightness'),
                  bottom: 10,
                ),
                //slider
                SleekCircularSlider(
                    initialValue: brightness,
                    appearance: CircularSliderAppearance(
                      infoProperties: InfoProperties(
                        mainLabelStyle: const TextStyle(
                          color: Colors.transparent,
                        ),
                      ),
                      size: 300,
                      customColors: CustomSliderColors(
                        hideShadow: true,
                        shadowMaxOpacity: 0.2,
                        shadowStep: 30,
                        trackColor: Colors.blue.shade900,
                        dotColor: Colors.grey.shade200,
                        progressBarColor: Colors.blue.shade300,
                      ),
                      customWidths: CustomSliderWidths(
                        trackWidth: 4,
                        handlerSize: 20,
                      ),
                    ),
                    onChange: (value) {
                      brightness = value;
                      updateSlider(_focusedIndexRooms, value, _focusedIndexFloors);
                    }),
                Positioned(
                  top: 50,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: light_on_off,
                    ),
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
              ]),
          const SizedBox(
            height: 20,
          ),
          //scrollsnaplist floors
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
                          color: Colors.blue.shade800.withOpacity(0.5),
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
          //scrollsnaplist rooms
          const SizedBox(height: 5,),
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
                          color: Colors.blue.shade200.withOpacity(0.5),
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
            height: 40,
          ),
          //switch
          FlutterSwitch(
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
            activeColor: Colors.blue.shade300,
            inactiveColor: Colors.black12,
            onToggle: (val) {
              setState(() {
                status = val;
                updateDataonToggleSwitch(status, _focusedIndexRooms, _focusedIndexFloors);
              });
            },
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
