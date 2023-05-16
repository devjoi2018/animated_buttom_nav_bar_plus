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
          initialPage: 0,
          onCenterButtonStateChanged: (value) {
            print('onButtonStateChanged $value');
          },
          backgroundColor: Colors.white,
          floatingButtonStyles: FloatingButtonStyles(),
          colorButtonDisabled: Colors.grey,
          onTapFloatingButtonLeft: () {
            print('onTapFloatingButtonLeft');
          },
          onTapFloatingButtonRight: () {
            print('onTapFloatingButtonRight');
          },
          onTapFloatingButtonTop: () {
            print('onTapFloatingButtonTop');
          },
          navBarItems: [
            NavBarItem(icon: Icons.home, labelText: 'Home'),
            NavBarItem(icon: Icons.search, labelText: 'Search'),
            NavBarItem(icon: Icons.person, labelText: 'Profile'),
            NavBarItem(icon: Icons.settings, labelText: 'Settings'),
          ],
          pages: const [
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
