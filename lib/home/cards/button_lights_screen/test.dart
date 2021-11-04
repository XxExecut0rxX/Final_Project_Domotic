// ignore_for_file: unused_import, unused_field, sized_box_for_whitespace

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class Test1 extends StatefulWidget {
  const Test1({ Key? key }) : super(key: key);

  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  
  List<String> data = ['room9','room8','room7','room6','room5','room4','room3'];
  int _focusedIndex = 0;

  Widget _buildListItem(BuildContext context, int index) {
    //horizontal
    if(index == data.length){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 100,
            color: Colors.lightBlueAccent,
            child: Center(child: Text(data[index], style: const TextStyle(fontSize: 30),)),
          )
        ],
      ),
    );
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ScrollSnapList(
            onItemFocus: _onItemFocus,
            itemSize: 150,
            dynamicItemSize: true,

            itemBuilder: _buildListItem,
            itemCount: data.length,
            reverse: true,
          ),
        ),
      ],
    );
  }
}