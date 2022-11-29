import 'package:flutter/material.dart';

class FloatingButtonStyles {
  final Color? colorFloatingButtonLeft;
  final Color? colorFloatingButtonTop;
  final Color? colorFloatingButtonRight;
  final Color? colorFloatingCenterButton;
  final IconData? iconFloatingCenterButton;
  final IconData? iconFloatingLeftButton;
  final IconData? iconFloatingTopButton;
  final IconData? iconFloatingRightButton;
  final double? elevationOfTheThreeFloatingButtons;
  final double? elevationFloatingCenterButton;

  /// Sets the styles for the center floatingButton and the three floatingButtons
  /// that show up when the center click is pressed
  FloatingButtonStyles({
    this.colorFloatingButtonLeft = Colors.red,
    this.colorFloatingButtonTop = Colors.green,
    this.colorFloatingButtonRight = Colors.blue,
    this.colorFloatingCenterButton = Colors.blue,
    this.iconFloatingCenterButton = Icons.add,
    this.iconFloatingLeftButton = Icons.add,
    this.iconFloatingTopButton = Icons.add,
    this.iconFloatingRightButton = Icons.add,
    this.elevationOfTheThreeFloatingButtons,
    this.elevationFloatingCenterButton,
  });
}
