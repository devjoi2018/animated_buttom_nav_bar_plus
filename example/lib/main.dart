import 'package:animated_bottom_nav_bar_plus/animated_bottom_nav_bar_plus.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
        bottomNavigationBar: AnimatedBottomNavBarPlus(
          addColorButtom: Colors.red,
          disableColor: Colors.grey,
          navBarColor: Colors.white,
          onTapCalendarTask: () {},
          onTapListTask: () {},
          onTapQuikTask: () {},
        ),
      ),
    );
  }
}
