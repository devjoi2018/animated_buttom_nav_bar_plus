import 'package:animated_bottom_nav_bar_plus/utils/floating_button_styles.dart';
import 'package:animated_bottom_nav_bar_plus/utils/global_memory.dart';
import 'package:animated_bottom_nav_bar_plus/utils/mediaquery_util.dart';
import 'package:flutter/material.dart';

class FloatingCenterButton extends StatefulWidget {
  final Animation buttomBouncing;
  final Animation rotatedIcon;
  final AnimationController animationController;
  final AnimationController animationController2;
  final FloatingButtonStyles floatingButtonStyles;
  final bool floatingCentralButtonIsAnimated;
  final ValueChanged<bool> onCenterButtonStateChanged;

  const FloatingCenterButton({
    super.key,
    required this.buttomBouncing,
    required this.floatingButtonStyles,
    required this.rotatedIcon,
    required this.floatingCentralButtonIsAnimated,
    required this.animationController,
    required this.animationController2,
    required this.onCenterButtonStateChanged,
  });

  @override
  State<FloatingCenterButton> createState() => _FloatingCenterButtonState();
}

class _FloatingCenterButtonState extends State<FloatingCenterButton> {
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
              onPressed: !widget.floatingCentralButtonIsAnimated
                  ? () {
                      _animationLogic();
                    }
                  : null,
              child: Transform.rotate(
                angle: widget.rotatedIcon.value,
                child: Icon(
                  widget.floatingButtonStyles.iconFloatingCenterButton,
                  size: mediaHeight(context) * 0.045,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _animationLogic() {
    widget.animationController.forward();
    if (!GlobalMemory.menuIsOpen) {
      widget.animationController2.forward();
      GlobalMemory.menuIsOpen = true;
      setState(() {});
    } else {
      widget.animationController2.reverse();
      GlobalMemory.menuIsOpen = false;
      setState(() {});
    }

    widget.onCenterButtonStateChanged(GlobalMemory.menuIsOpen);
  }
}
