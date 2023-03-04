import 'package:animated_bottom_nav_bar_plus/animated_bottom_nav_bar_plus.dart';
import 'package:animated_bottom_nav_bar_plus/utils/global_memory.dart';
import 'package:animated_bottom_nav_bar_plus/utils/mediaquery_util.dart';
import 'package:flutter/material.dart';

class RadialMenu extends StatefulWidget {
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
  final Color? colorFloatingButtonLeft;
  final Color? colorFloatingButtonTop;
  final Color? colorFloatingButtonRight;

  /// This method builds a radial menu on top of the central [FloatingActionButton]
  /// in the [navBar]
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
    this.colorFloatingButtonLeft,
    this.colorFloatingButtonTop,
    this.colorFloatingButtonRight,
  });

  @override
  State<RadialMenu> createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            /// Left floating button of the radial menu
            _buildButtom(
              elevation: widget.floatingButtonStyles.elevationOfTheThreeFloatingButtons,
              color: widget.colorFloatingButtonLeft,
              heroTag: '2',
              icon: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
                    onTap: () {
                      widget.onTapFloatingButtonLeft();
                      setState(() {
                        GlobalMemory.animationController2.reverse();
                        GlobalMemory.menuIsOpen = false;
                      });
                    },
                    child: Icon(
                      widget.floatingButtonStyles.iconFloatingLeftButton,
                      size: constraints.maxHeight * 0.60,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              offset: widget.floatingButtonLeftPosition.value,
              // onPressed: widget.onTapFloatingButtonLeft,
            ),

            /// Floating top button of the radial menu
            _buildButtom(
              elevation: widget.floatingButtonStyles.elevationOfTheThreeFloatingButtons,
              color: widget.colorFloatingButtonTop,
              heroTag: '3',
              icon: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
                    onTap: () {
                      widget.onTapFloatingButtonTop();
                      setState(() {
                        GlobalMemory.animationController2.reverse();
                        GlobalMemory.menuIsOpen = false;
                      });
                    },
                    child: Icon(
                      widget.floatingButtonStyles.iconFloatingTopButton,
                      size: constraints.maxHeight * 0.60,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              offset: widget.floatingButtonTopPosition.value,
              // onPressed: widget.onTapFloatingButtonTop,
            ),

            /// Right floating button of the radial menu
            _buildButtom(
              elevation: widget.floatingButtonStyles.elevationOfTheThreeFloatingButtons,
              color: widget.colorFloatingButtonRight,
              heroTag: '4',
              icon: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
                    onTap: () {
                      widget.onTapFloatingButtonRight();
                      setState(() {
                        GlobalMemory.animationController2.reverse();
                        GlobalMemory.menuIsOpen = false;
                      });
                    },
                    child: Icon(
                      widget.floatingButtonStyles.iconFloatingRightButton,
                      size: constraints.maxHeight * 0.60,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              offset: widget.floatingButtonRightPosition.value,
              // onPressed: widget.onTapFloatingButtonRight,
            ),
          ],
        );
      },
    );
  }

  /// Method that builds the floating buttons of the radial menu
  Widget _buildButtom({
    Color? color,
    double? elevation,
    Function()? onPressed,
    required Offset offset,
    required String heroTag,
    required Widget icon,
  }) {
    return Positioned(
      bottom: 0,
      child: Transform.translate(
        offset: offset,
        child: Opacity(
          opacity: widget.opacityButtom.value,
          child: Transform.scale(
            scale: widget.scaleButtons.value,
            child: SizedBox(
              height: mediaHeight(widget.context) * 0.060,
              width: mediaHeight(widget.context) * 0.070,
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
    );
  }
}
