import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:pro_final/home/cards/button_lights_screen/button_light_screen.dart';
import 'package:pro_final/home/cards/button_temperature_screen/button_temp_screen.dart';
import 'package:pro_final/home/main_home.dart';
import 'package:pro_final/home/profile_screen/profile_Screen.dart';
import 'package:pro_final/home/notifications_screen/notif_screen.dart';
import 'package:pro_final/home/list_screen/list_Screen.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageIndex = 0;
  List<Widget> pageList = [
    MainHome(),
    const ListScreen(),
    const notifScreen(),
    profileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: const lightButtonScreen(),
            //pageList[pageIndex],
            /*PageTransitionSwitcher(
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) => 
              FadeThroughTransition(
                animation: primaryAnimation, 
                secondaryAnimation: 
                secondaryAnimation, 
                child: child,
                ),
                child: pageList[pageIndex],
              ),*/
        bottomNavigationBar: TitledBottomNavigationBar(
          activeColor: const Color(0xFF33E1EC),
          inactiveColor: Colors.black45,
          enableShadow: true,
          reverse: true,
          currentIndex: pageIndex, // Use this to update the Bar giving a position
          onTap: (index) {
            setState((){
              pageIndex = index;
            }); 
          },
          items: [
            TitledNavigationBarItem(
              title: const Text('Home'),
              icon: const Icon(Icons.home_outlined),
            ),
            TitledNavigationBarItem(
              title: const Text('Lists'),
              icon: const Icon(Icons.list_alt),
            ),
            TitledNavigationBarItem(
              title: const Text('Notifications'),
              icon: const Icon(Icons.notifications_outlined),
            ),
            TitledNavigationBarItem(
              title: const Text('Profile'),
              icon: const Icon(Icons.person_outline),
            ),
          ],
        ),
      ), 
    );
  }
}

/*

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/