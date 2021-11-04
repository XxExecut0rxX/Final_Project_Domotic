// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({ Key? key }) : super(key: key);

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {

  /////////////firebase
  final db = FirebaseDatabase.instance.reference();

  String _displ1 = 'off';
  String st1 = 'Available';
  String _displ2 = 'off';
  String st2 = 'Available';

  @override
  void initState() {
    super.initState();
    _activateListeners1();
    _activateListeners2();
  }

  void _activateListeners1() {
    db.child('floor2/room1').child('doors').onValue.listen((event) {
      final String desc = event.snapshot.value;
      setState(() {
        _displ1 = desc;
      });
    });

    db.child('floor2/room1/sensors').child('movement').onValue.listen((event) {
      final String desc = event.snapshot.value;
      setState(() {
        st1 = desc;
        if (desc == 'true') {
          st1 = 'Using';
        } else {
          st1 = 'Available';
        }
      });
    });
  }

  void updateData1() {
    if (_displ1 == 'on') {
      db.child('floor2/room1').update({'doors': 'off'});
    } else {
      db.child('floor2/room1').update({'doors': 'on'});
    }
  }
  void _activateListeners2() {
    db.child('floor2/room2').child('doors').onValue.listen((event) {
      final String desc = event.snapshot.value;
      setState(() {
        _displ2 = desc;
      });
    });

    db.child('floor2/room2/sensors').child('movement').onValue.listen((event) {
      final String desc = event.snapshot.value;
      setState(() {
        st2 = desc;
        if (desc == 'true') {
          st2 = 'Using';
        } else {
          st2 = 'Available';
        }
      });
    });
  }

  void updateData2() {
    if (_displ2 == 'on') {
      db.child('floor2/room2').update({'doors': 'off'});
    } else {
      db.child('floor2/room2').update({'doors': 'on'});
    }
  }

  final bar = const Center(
    child: Text("List view"),
  );
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            bar,
            const SizedBox(height: 20,),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(35,18,18,3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Laboratory 1',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800)),
                      const Divider(color: Colors.white,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                          children: [
                            const Icon(Icons.show_chart,color: Colors.white),
                            const Text('State: ', style: TextStyle(color: Colors.white)),
                            Text(st1, style: const TextStyle(color: Colors.white)),
                          ]),
                          ElevatedButton.icon(
                            onPressed: () {
                              updateData1();
                            },
                            icon: const Icon(Icons.door_back_door),
                            label: const Text("Door"),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0.0),
                              foregroundColor:
                                  MaterialStateProperty.all(
                                    //const Color(0xff56c2cd)
                                    Colors.orange.shade800,
                                    ),
                              backgroundColor:
                                  MaterialStateProperty.all(
                                    //const Color(0xffe3fcff)
                                    Colors.orange.shade100
                                    ),
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  //side: const BorderSide(color: Colors.white),
                                ),
                              ),
                            )),
                        ],
                      ),
                    ],
                  ),
                  height: 110.0,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(30, 10, 10, 2),
                  decoration: BoxDecoration(
                    /*gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.9],
                      colors: [
                        Color(0xff8454ea),
                        Color(0xfffc416f),
                      ],
                    ),*/
                    color: const Color(0xFF333366),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(  
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 1,
                  top: 20,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                  ),
                )
              ]
            ),
            Stack(alignment: AlignmentDirectional.center, children: [
              Container(
                padding: const EdgeInsets.fromLTRB(35, 18, 18, 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Laboratory 2',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800)),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(children: [
                          const Icon(Icons.show_chart, color: Colors.white),
                          const Text('State: ', style: TextStyle(color: Colors.white)),
                          Text(st2,
                              style: const TextStyle(color: Colors.white)),
                        ]),
                        ElevatedButton.icon(
                            onPressed: () {
                              updateData2();
                            },
                            icon: const Icon(Icons.door_back_door),
                            label: const Text("Door"),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0.0),
                              foregroundColor: MaterialStateProperty.all(
                                //const Color(0xff56c2cd)
                                Colors.orange.shade800,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  //const Color(0xffe3fcff)
                                  Colors.orange.shade100),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  //side: const BorderSide(color: Colors.white),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
                height: 110.0,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(30, 10, 10, 2),
                decoration: BoxDecoration(
                  /*gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.9],
                      colors: [
                        Color(0xff8454ea),
                        Color(0xfffc416f),
                      ],
                    ),*/
                  color: const Color(0xFF333366),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 1,
                top: 20,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                ),
              )
            ]),

          ],
        ),
      ),
    );
  }
}