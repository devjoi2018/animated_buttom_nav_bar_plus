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
        body: AnimatedBottomNavBarPlus(
          initialPage: 1,
          backgroundColor: Colors.white,
          floatingButtonStyles: FloatingButtonStyles(),
          colorButtonDisabled: Colors.grey,
          onTapFloatingButtonLeft: () {},
          onTapFloatingButtonRight: () {},
          onTapFloatingButtonTop: () {},
          items: const [
            Center(child: Text('Home')),
            Center(child: Text('Search')),
            Center(child: Text('Profile')),
            Center(child: Text('Settings')),
          ],
        ),
      ),
    );
  }
}
