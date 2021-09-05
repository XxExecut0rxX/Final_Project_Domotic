// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({ Key? key }) : super(key: key);

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  @override

  final bar = const Center(
    child: Text("List"),
  );

  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          bar,
        ],
      ),
    );
  }
}