import 'package:animated_bottom_nav_bar_plus/animated_bottom_nav_bar_plus.dart';
import 'package:animated_bottom_nav_bar_plus/utils/mediaquery_util.dart';
import 'package:flutter/material.dart';

class RadialMenu extends StatelessWidget {
  final BuildContext context;
  final FloatingButtonStyles floatingButtonStyles;
  final AnimationController controller;
  final Animation opacityButtom;
  final Animation floatingButtonLeftPosition;
  final Animation floatingButtonTopPosition;
  final Animation floatingButtonRightPosition;
  final Animation scaleButtons;
  final Function() onTapFloatingButtonLeft;
  final Function() onTapFloatingButtonRight;
  final Function() onTapFloatingButtonTop;
  final Color? colorCalendarTask;
  final Color? colorQuikTask;
  final Color? colorListTask;

  /// Este metodo construye un menu radial sobre el FloatingActionButtom central
  /// en el navBar
  const RadialMenu({
    required this.context,
    required this.onTapFloatingButtonLeft,
    required this.onTapFloatingButtonRight,
    required this.onTapFloatingButtonTop,
    required this.controller,
    required this.floatingButtonLeftPosition,
    required this.floatingButtonTopPosition,
    required this.floatingButtonRightPosition,
    required this.opacityButtom,
    required this.scaleButtons,
    required this.floatingButtonStyles,
    this.colorCalendarTask,
    this.colorQuikTask,
    this.colorListTask,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            /// Boton para agregar tareas al calendario
            _buildButtom(
              elevation: floatingButtonStyles.elevationOfTheThreeFloatingButtons,
              color: colorCalendarTask,
              heroTag: '2',
              icon: Icon(
                floatingButtonStyles.iconFloatingLeftButton,
                size: mediaHeight(context) * 0.040,
                color: Colors.white,
              ),
              offset: floatingButtonLeftPosition.value,
              onPressed: onTapFloatingButtonLeft,
            ),

            /// Boton para agregar tareas rapidas
            _buildButtom(
              elevation: floatingButtonStyles.elevationOfTheThreeFloatingButtons,
              color: colorQuikTask,
              heroTag: '3',
              icon: Icon(
                floatingButtonStyles.iconFloatingTopButton,
                size: mediaHeight(context) * 0.040,
                color: Colors.white,
              ),
              offset: floatingButtonTopPosition.value,
              onPressed: onTapFloatingButtonTop,
            ),

            /// Boton para agregar tareas de lista
            _buildButtom(
              elevation: floatingButtonStyles.elevationOfTheThreeFloatingButtons,
              color: colorListTask,
              heroTag: '4',
              icon: Icon(
                floatingButtonStyles.iconFloatingRightButton,
                size: mediaHeight(context) * 0.040,
                color: Colors.white,
              ),
              offset: floatingButtonRightPosition.value,
              onPressed: onTapFloatingButtonRight,
            ),
          ],
        );
      },
    );
  }

  /// Metodo que construye los botones que agregan tareas
  Widget _buildButtom({
    Color? color,
    double? elevation,
    required Offset offset,
    required Function() onPressed,
    required String heroTag,
    required Widget icon,
  }) {
    return Positioned(
      bottom: 0,
      child: Transform.translate(
        offset: offset,
        child: Opacity(
          opacity: opacityButtom.value,
          child: Container(
            alignment: Alignment.center,
            height: mediaHeight(context) * 0.070,
            width: mediaHeight(context) * 0.070,
            child: Transform.scale(
              scale: scaleButtons.value,
              child: SizedBox(
                height: mediaHeight(context) * 0.070,
                width: mediaHeight(context) * 0.070,
                child: FloatingActionButton(
                  elevation: elevation,
                  heroTag: heroTag,
                  backgroundColor: color,
                  onPressed: onPressed,
                  child: icon,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
