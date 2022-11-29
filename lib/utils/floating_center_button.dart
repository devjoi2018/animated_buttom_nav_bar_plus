import 'package:animated_bottom_nav_bar_plus/utils/floating_button_styles.dart';
import 'package:animated_bottom_nav_bar_plus/utils/mediaquery_util.dart';
import 'package:flutter/material.dart';

class FloatingCenterButton extends StatefulWidget {
  final AnimationController animationController;
  final AnimationController animationController2;
  final Animation buttomBouncing;
  final Animation rotatedIcon;
  final FloatingButtonStyles floatingButtonStyles;

  const FloatingCenterButton({
    required this.animationController,
    required this.animationController2,
    required this.buttomBouncing,
    required this.floatingButtonStyles,
    required this.rotatedIcon,
  });

  @override
  State<FloatingCenterButton> createState() => _FloatingCenterButtonState();
}

class _FloatingCenterButtonState extends State<FloatingCenterButton> {
  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */
  /// Variable que indica si el menu esta abierto o no
  bool _menuOpen = false;

  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          left: mediaWidth(context) * 0.43,
          right: mediaWidth(context) * 0.43,
          bottom: widget.buttomBouncing.value,
          child: SizedBox(
            height: mediaHeight(context) * 0.075,
            width: mediaHeight(context) * 0.075,
            child: FloatingActionButton(
              heroTag: '1',
              elevation: widget.floatingButtonStyles.elevationFloatingCenterButton,
              backgroundColor: widget.floatingButtonStyles.colorFloatingCenterButton,
              child: Transform.rotate(
                angle: widget.rotatedIcon.value,
                child: Icon(
                  widget.floatingButtonStyles.iconFloatingCenterButton,
                  size: mediaHeight(context) * 0.045,
                ),
              ),
              onPressed: () {
                _logicaDeAnimacion(context);
              },
            ),
          ),
        );
      },
    );
  }

  /// Este metodo se encarga de establecer la logica que permite iniciar
  /// la animacion de cada elemento.
  void _logicaDeAnimacion(BuildContext context) {
    widget.animationController.forward();
    if (_menuOpen == false) {
      widget.animationController2.forward();
      _menuOpen = true;
      setState(() {});
    } else {
      widget.animationController2.reverse();
      _menuOpen = false;
      setState(() {});
    }
  }
}
