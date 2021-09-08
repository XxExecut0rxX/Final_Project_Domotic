// ignore_for_file: camel_case_types, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

// ignore: camel_case_types
class lightButtonScreen extends StatefulWidget {
  const lightButtonScreen({ Key? key }) : super(key: key);
  
  @override
  _lightButtonScreenState createState() => _lightButtonScreenState();
}

class _lightButtonScreenState extends State<lightButtonScreen> {
  
  final bar = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(
        onPressed: (){},
        child: Row(
          children: const [
            Icon(Icons.arrow_back_ios),
            Text('Back'),
          ],
        ), 
      ),
      SizedBox(width: 100,),
      Text('Lights'),
    ],
  );
  
  final slider = SleekCircularSlider(

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
        progressBarColor: Colors.blue.shade600,
      ),
      customWidths: CustomSliderWidths(
        trackWidth: 4,
        handlerSize: 25,
      ),
    ),
    onChange: (double value) {
    }
  );

  bool status = true;

  //horizontal snap bar
  List<String> data = [
    'Room1',
    'Room2',
    'Room3',
    'Room4',
    'Room5',
    'Room6',
    'Room7'
  ];
  int _focusedIndex = 0;

  Widget _buildListItem(BuildContext context, int index) {

    //horizontal
    if (index == data.length) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 100,
            //color: Colors.lightBlueAccent,
            child: Center(
                child: Text(
                data[index],
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
    )
    ;
  }

  final centerLightIcon = Container(
    child: Image.network('https://github.com/XxExecut0rxX/Final_Project_Domotic/blob/master/assets/Images/lightsicon/lightson.png'),
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
  );

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }
  //main widget
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          bar,
          const SizedBox(height: 50,),
          Stack(
            clipBehavior:  Clip.none,
            alignment: AlignmentDirectional.center,
            children: [
              slider,
              Positioned(
                top: 50,
                child: centerLightIcon,
              ),
            ]
          ),
          const SizedBox(height: 50,),

          //scrollsnaplist
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 90,
                    height: 45,
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(2, 4),
                        ),
                      ]
                    ),
                  ),
                ),
                ScrollSnapList(
                  onItemFocus: _onItemFocus,
                  itemSize: 140,
                  dynamicItemSize: true,
                  itemBuilder: _buildListItem,
                  itemCount: data.length,
                  reverse: false,
                ),
                
              ]
            ),
          ),
          const SizedBox(height: 30,),
          FlutterSwitch(
            width: 110.0,
            height: 55.0,
            valueFontSize: 25.0,
            toggleSize: 50.0,
            value: status,
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