import 'package:animated_bottom_nav_bar_plus/utils/floating_button_styles.dart';
import 'package:animated_bottom_nav_bar_plus/utils/floating_center_button.dart';
import 'package:animated_bottom_nav_bar_plus/utils/global_memory.dart';
import 'package:animated_bottom_nav_bar_plus/utils/mediaquery_util.dart';
import 'package:animated_bottom_nav_bar_plus/utils/nav_bar.dart';
import 'package:animated_bottom_nav_bar_plus/utils/nav_bar_path.dart';
import 'package:animated_bottom_nav_bar_plus/utils/radial_menu.dart';
import 'package:flutter/material.dart';
export 'package:animated_bottom_nav_bar_plus/utils/floating_button_styles.dart';

class AnimatedBottomNavBarPlus extends StatefulWidget {
  /// Sets the color of the [AnimatedButtonNavBarPlus] widget,
  /// if the value is null the default color is set to white.
  final Color? backgroundColor;

  /// Sets the color of the selected item.
  final Color? selectedColor;
  final FloatingButtonStyles floatingButtonStyles;

  /// Sets the color of the button that is not selected.
  final Color? colorButtonDisabled;

  /// Sets the elevation value of the [AnimatedButtonNavBarPlus],
  /// if the value is null it defaults to `10.0`.
  final double? elevation;

  /// This list receives the screens that you want to display for each
  /// of the buttons in the [AnimatedButtonNavBarPlus], the list must
  /// necessarily receive 4 elements to be able to function correctly.
  final List<Widget> items;
  final ValueChanged<int>? onPageChanged;

  /// Sets the value of the initial screen, if it is null the
  /// default value is 0.
  final int? initialPage;
  final bool? showLabel;
  final Function() onTapFloatingButtonLeft;
  final Function() onTapFloatingButtonRight;
  final Function() onTapFloatingButtonTop;

  const AnimatedBottomNavBarPlus({
    Key? key,
    this.backgroundColor,
    this.selectedColor,
    this.colorButtonDisabled,
    this.elevation,
    this.initialPage,
    this.showLabel,
    required this.floatingButtonStyles,
    required this.onTapFloatingButtonLeft,
    required this.onTapFloatingButtonRight,
    required this.onTapFloatingButtonTop,
    this.onPageChanged,
    required this.items,
  }) : super(key: key);

  @override
  State<AnimatedBottomNavBarPlus> createState() => _AnimatedBottomNavBarPlusState();
}

class _AnimatedBottomNavBarPlusState extends State<AnimatedBottomNavBarPlus> with TickerProviderStateMixin {
  /* -------------------------------------------------------------------------- */
  /*                                 CONTROLLERS                                */
  /* -------------------------------------------------------------------------- */
  late AnimationController _animationContoller;
  late AnimationController _animationController2;
  late AnimationController _optionController;

  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */
  late Animation _buttomBouncing;
  late Animation _rotatedIcon;
  late Animation _curve1;
  late Animation _curve2;
  late Animation _pathOpacity;
  late Animation _navBarSize;
  late Animation _floatingButtonLeftPosition;
  late Animation _opacityButtom;
  late Animation _floatingButtonTopPosition;
  late Animation _floatingButtonRightPosition;
  late Animation _scaleButtons;
  late Animation _option1;
  late Animation _option2;
  late Animation _option3;
  late Animation _option4;

  /* -------------------------------------------------------------------------- */
  /*                                 LIFECYCLES                                 */
  /* -------------------------------------------------------------------------- */
  @override
  void initState() {
    super.initState();

    GlobalMemory.pageController = PageController(initialPage: widget.initialPage ?? 0);
    _animationContoller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _optionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    /// Sets the animation parameters to rotate the icon of the,
    /// [floatingButtonCenter] widget.
    _rotatedIcon = Tween(begin: 0.0, end: 7.0).animate(_animationController2);

    /// Animate the navBar path values.
    _curve1 = Tween(begin: NavBarPath().lowSize, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationContoller,
        curve: Curves.bounceIn,
      ),
    );

    /// Animate the navBar path values.
    _curve2 = Tween(begin: NavBarPath().bigSize, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationContoller,
        curve: Curves.bounceIn,
      ),
    );

    /// Sets the parameters to animate the opacity of the navBar.
    _pathOpacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController2,
        curve: const Interval(0.30, 0.60),
      ),
    );

    /// Sets the parameters to animate the opacity of the buttons.
    /// from the radial menu
    _opacityButtom = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController2,
        curve: const Interval(0.40, 1.0),
      ),
    );

    /// Sets a dynamic size for the navBar animation.
    _navBarSize = Tween(begin: 0.08, end: 0.0).animate(_animationController2);

    /// Sets the parameters to animate the scale of the radial menu buttons.
    _scaleButtons = Tween(begin: 0.0, end: 1.0).animate(_animationController2);

    /// Sets the animation parameters for the first button of the navBar.
    _option1 = Tween(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _optionController, curve: Curves.bounceOut),
    );

    /// Sets the animation parameters for the second button of the navBar.
    _option2 = Tween(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _optionController, curve: Curves.bounceOut),
    );

    /// Sets the animation parameters for the third button of the navBar.
    _option3 = Tween(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _optionController, curve: Curves.bounceOut),
    );

    /// Sets the animation parameters for the fourth button of the navBar.
    _option4 = Tween(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _optionController, curve: Curves.bounceOut),
    );

    /// start this controller.
    _optionController.forward();

    /// Listen if the controller has finished the animation to do a reverse animation.
    _animationContoller.addListener(() {
      if (_animationContoller.status == AnimationStatus.completed) {
        _animationContoller.reverse();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Sets the dynamic parameters for the animation of the
    /// central floating button that opens the radial menu.
    _buttomBouncing = Tween(
      begin: mediaHeight(context) * 0.042,
      end: mediaHeight(context) * 0.10,
    ).animate(
      CurvedAnimation(
        parent: _animationContoller,
        curve: Curves.bounceIn,
      ),
    );

    /// Sets the dynamic parameters for the animation of the left floating
    /// button of the radial menu.
    _floatingButtonLeftPosition = Tween(
      begin: Offset(mediaWidth(context) * 0.44, -mediaHeight(context) * 0.047),
      end: Offset(mediaWidth(context) * 0.19, -mediaHeight(context) * 0.10),
    ).animate(
      CurvedAnimation(parent: _animationController2, curve: Curves.bounceIn),
    );

    /// Sets the dynamic parameters for the animation of the top floating
    /// button of the radial menu.
    _floatingButtonTopPosition = Tween(
      begin: Offset(mediaWidth(context) * 0.44, -mediaHeight(context) * 0.047),
      end: Offset(mediaWidth(context) * 0.44, -mediaHeight(context) * 0.20),
    ).animate(
      CurvedAnimation(parent: _animationController2, curve: Curves.bounceIn),
    );

    /// Sets the dynamic parameters for the animation of the right floating
    /// button of the radial menu.
    _floatingButtonRightPosition = Tween(
      begin: Offset(mediaWidth(context) * 0.44, -mediaHeight(context) * 0.047),
      end: Offset(mediaWidth(context) * 0.71, -mediaHeight(context) * 0.10),
    ).animate(
      CurvedAnimation(parent: _animationController2, curve: Curves.bounceIn),
    );
  }

  @override
  void dispose() {
    _animationContoller.dispose();
    _animationController2.dispose();
    _optionController.dispose();
    GlobalMemory.pageController.dispose();
    super.dispose();
  }

  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    /// Throw an exception if the value of [initialPage] is greater than 3
    /// or less than 0, the value must be between 0 and 3.
    if (widget.initialPage != null) {
      if (widget.initialPage! > 3 || widget.initialPage! < 0) {
        throw Exception('Initial page must be between 0 and 3');
      }
    }

    /// Assigns the value of [initialPage] if it is other than null,
    /// but if the value is null then the default value 0 is assigned.
    GlobalMemory.selectedIndex = widget.initialPage ?? 0;

    if (widget.items.length > 4 || widget.items.length < 4) {
      throw Exception('The number of items must be 4');
    }
    return Stack(
      children: [
        /// List of screens associated with the [NavBar], the [itemCount]
        /// property must always be equal to 4 because it is the number
        /// of fixed screens
        PageView.builder(
          controller: GlobalMemory.pageController,
          itemCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return widget.items[index];
          },
        ),
        RadialMenu(
          context: context,
          floatingButtonStyles: widget.floatingButtonStyles,
          floatingButtonRightPosition: _floatingButtonRightPosition,
          opacityButtom: _opacityButtom,
          floatingButtonTopPosition: _floatingButtonTopPosition,
          scaleButtons: _scaleButtons,
          floatingButtonLeftPosition: _floatingButtonLeftPosition,
          controller: _animationController2,
          colorCalendarTask: widget.floatingButtonStyles.colorFloatingButtonLeft,
          colorQuikTask: widget.floatingButtonStyles.colorFloatingButtonTop,
          colorListTask: widget.floatingButtonStyles.colorFloatingButtonRight,
          onTapFloatingButtonLeft: widget.onTapFloatingButtonLeft,
          onTapFloatingButtonRight: widget.onTapFloatingButtonRight,
          onTapFloatingButtonTop: widget.onTapFloatingButtonTop,
        ),
        NavBar(
          animationController: _animationContoller,
          optionController: _optionController,
          pathOpacity: _pathOpacity,
          curve1: _curve1,
          curve2: _curve2,
          navBarSize: _navBarSize,
          option1: _option1,
          option2: _option2,
          option3: _option3,
          option4: _option4,
          navBarColor: widget.backgroundColor ?? Colors.white,
          selectedColor: widget.selectedColor ?? Colors.blue,
          colorButtonDisabled: widget.colorButtonDisabled ?? Colors.grey,
          elevation: widget.elevation ?? 10.0,
          onPageChanged: widget.onPageChanged ?? (index) {},
          showLabel: widget.showLabel ?? true,
        ),
        FloatingCenterButton(
          animationController: _animationContoller,
          animationController2: _animationController2,
          buttomBouncing: _buttomBouncing,
          floatingButtonStyles: widget.floatingButtonStyles,
          rotatedIcon: _rotatedIcon,
        ),
      ],
    );
  }
}
