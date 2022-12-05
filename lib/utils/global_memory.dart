import 'package:flutter/cupertino.dart';

class GlobalMemory {
  static late AnimationController animationController;
  static late AnimationController animationController2;

  /// Variable that indicates if the menu is open or not
  static bool menuIsOpen = false;
  static late PageController pageController;
  static int? selectedIndex;
}
