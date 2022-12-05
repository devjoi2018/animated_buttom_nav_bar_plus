import 'package:animated_bottom_nav_bar_plus/utils/clip_shadow.dart';
import 'package:animated_bottom_nav_bar_plus/utils/global_memory.dart';
import 'package:animated_bottom_nav_bar_plus/utils/mediaquery_util.dart';
import 'package:animated_bottom_nav_bar_plus/utils/nav_bar_item.dart';
import 'package:animated_bottom_nav_bar_plus/utils/nav_bar_path.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final AnimationController animationController;
  final AnimationController optionController;
  final Animation pathOpacity;
  final Animation curve1;
  final Animation curve2;
  final Animation navBarSize;
  final Animation option1;
  final Animation option2;
  final Animation option3;
  final Animation option4;
  final Color navBarColor;
  final Color selectedColor;
  final Color colorButtonDisabled;
  final double elevation;
  final ValueChanged<int> onPageChanged;
  final bool? showLabel;
  final List<NavBarItem> navBarItems;

  ///This widget draws the [navBar] and its items
  const NavBar({
    required this.animationController,
    required this.optionController,
    required this.pathOpacity,
    required this.curve1,
    required this.curve2,
    required this.navBarSize,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.navBarColor,
    required this.selectedColor,
    required this.colorButtonDisabled,
    required this.elevation,
    required this.onPageChanged,
    required this.showLabel,
    required this.navBarItems,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          bottom: 0,
          child: Opacity(
            opacity: widget.pathOpacity.value,
            child: ClipShadow(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(widget.elevation == 0.0 ? 0.0 : 0.1),
                  offset: Offset(0.0, -mediaHeight(context) * 0.002),
                  blurRadius: widget.elevation,
                  spreadRadius: 1.0,
                ),
              ],
              clipper: NavBarPath(
                bigSize: widget.curve2.value,
                lowSize: widget.curve1.value,
              ),
              child: Container(
                width: mediaWidth(context),
                height: mediaHeight(context) * widget.navBarSize.value,
                padding: EdgeInsets.only(
                  left: mediaWidth(context) * 0.030,
                  right: mediaWidth(context) * 0.030,
                  top: mediaHeight(context) * 0.010,
                ),
                color: widget.navBarColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _listButtonsNavBar(
                    selectedColor: widget.selectedColor,
                    colorButtonDisabled: widget.colorButtonDisabled,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// This method contains all the buttons that are displayed on the [navBar].
  List<Widget> _listButtonsNavBar({
    Color? selectedColor,
    Color? colorButtonDisabled,
  }) {
    /// Shows a list with all the items in the [navBar].
    List<Widget> iconList = [
      AnimatedBuilder(
        animation: widget.optionController,
        builder: (context, child) {
          return Row(
            children: [
              _navBarItem(
                index: 0,
                icon: widget.navBarItems[0].icon,
                labelText: widget.navBarItems[0].labelText,
                context: context,
                colorButtonDisabled: colorButtonDisabled,
                selectedColor: selectedColor,
                onTap: () {
                  GlobalMemory.selectedIndex = 0;
                  GlobalMemory.pageController.animateToPage(
                    GlobalMemory.selectedIndex!,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  widget.onPageChanged(GlobalMemory.selectedIndex!);
                  widget.optionController.reset();
                  widget.optionController.forward();
                  setState(() {});
                },
              ),
              SizedBox(
                width: mediaWidth(context) * 0.08,
              ),
              _navBarItem(
                index: 1,
                icon: widget.navBarItems[1].icon,
                labelText: widget.navBarItems[1].labelText,
                context: context,
                colorButtonDisabled: colorButtonDisabled,
                selectedColor: selectedColor,
                onTap: () {
                  GlobalMemory.selectedIndex = 1;
                  GlobalMemory.pageController.animateToPage(
                    GlobalMemory.selectedIndex!,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  widget.onPageChanged(GlobalMemory.selectedIndex!);
                  widget.optionController.reset();
                  widget.optionController.forward();
                  setState(() {});
                },
              ),
            ],
          );
        },
      ),
      AnimatedBuilder(
        animation: widget.optionController,
        builder: (context, child) {
          return Row(
            children: [
              _navBarItem(
                index: 2,
                icon: widget.navBarItems[2].icon,
                labelText: widget.navBarItems[2].labelText,
                context: context,
                colorButtonDisabled: colorButtonDisabled,
                selectedColor: selectedColor,
                onTap: () {
                  GlobalMemory.selectedIndex = 2;
                  GlobalMemory.pageController.animateToPage(
                    GlobalMemory.selectedIndex!,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  widget.onPageChanged(GlobalMemory.selectedIndex!);
                  widget.optionController.reset();
                  widget.optionController.forward();
                  setState(() {});
                },
              ),
              SizedBox(
                width: mediaWidth(context) * 0.08,
              ),
              _navBarItem(
                index: 3,
                icon: widget.navBarItems[3].icon,
                labelText: widget.navBarItems[3].labelText,
                context: context,
                colorButtonDisabled: colorButtonDisabled,
                selectedColor: selectedColor,
                onTap: () {
                  GlobalMemory.selectedIndex = 3;
                  GlobalMemory.pageController.animateToPage(
                    GlobalMemory.selectedIndex!,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  widget.onPageChanged(GlobalMemory.selectedIndex!);
                  widget.optionController.reset();
                  widget.optionController.forward();
                  setState(() {});
                },
              ),
            ],
          );
        },
      ),
    ];
    return iconList;
  }

  /// This method contains the model of the [navBar] items
  Widget _navBarItem({
    Color? selectedColor,
    Color? colorButtonDisabled,
    required BuildContext context,
    required IconData icon,
    required String labelText,
    required int index,
    required Function() onTap,
  }) {
    /// Sets all the containers that contain the items in center
    const MainAxisAlignment aligment = MainAxisAlignment.center;

    /// Set the icon size of the items
    final iconSize = mediaHeight(context) * 0.038;

    return GestureDetector(
      onTap: onTap,
      child: Transform.scale(
        scale: GlobalMemory.selectedIndex == index ? widget.option4.value : 1.0,
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            height: mediaHeight(context) * 0.07,
            width: mediaWidth(context) * 0.14,
            child: Column(
              mainAxisAlignment: aligment,
              children: [
                Icon(
                  icon,
                  size: iconSize,
                  color: GlobalMemory.selectedIndex == index ? selectedColor : colorButtonDisabled,
                ),
                Visibility(
                  visible: widget.showLabel!,
                  child: Flexible(
                    child: _textLabel(
                      text: labelText,
                      color: GlobalMemory.selectedIndex == index ? selectedColor : colorButtonDisabled,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// This method contains the style of the Text label that
  /// is displayed below the icon in the [navBar].
  Widget _textLabel({
    required String text,
    required Color? color,
  }) {
    /// Set the fontSize of the text in the [navBar].
    final fontSize = mediaHeight(context) * 0.015;

    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
