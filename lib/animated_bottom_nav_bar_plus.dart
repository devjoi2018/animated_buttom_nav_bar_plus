import 'package:animated_bottom_nav_bar_plus/utils/clip_shadow.dart';
import 'package:animated_bottom_nav_bar_plus/utils/mediaquery_util.dart';
import 'package:flutter/material.dart';

class AnimatedBottomNavBarPlus extends StatefulWidget {
  final Color? navBarColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? colorCalendarTask;
  final Color? colorQuikTask;
  final Color? colorListTask;
  final Color? addColorButtom;
  final Color? disableColor;
  final Function() onTapCalendarTask;
  final Function() onTapListTask;
  final Function() onTapQuikTask;

  const AnimatedBottomNavBarPlus({
    Key? key,
    this.navBarColor,
    this.selectedColor,
    this.unselectedColor,
    this.colorCalendarTask,
    this.colorQuikTask,
    this.colorListTask,
    this.addColorButtom,
    this.disableColor,
    required this.onTapCalendarTask,
    required this.onTapListTask,
    required this.onTapQuikTask,
  }) : super(key: key);

  @override
  State<AnimatedBottomNavBarPlus> createState() => _AnimatedBottomNavBarPlusState();
}

class _AnimatedBottomNavBarPlusState extends State<AnimatedBottomNavBarPlus> with TickerProviderStateMixin {
  /* -------------------------------------------------------------------------- */
  /*                                 CONTROLLERS                                */
  /* -------------------------------------------------------------------------- */
  late AnimationController _animationContoller, _animationController2, _optionController;

  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */
  late Animation _buttomBouncing;
  late Animation _rotatedIcon;
  late Animation _curve1;
  late Animation _curve2;
  late Animation _pathOpacity;
  late Animation _navBarSize;
  late Animation _taskCalendarPosition;
  late Animation _opacityButtom;
  late Animation _quikTaskPosition;
  late Animation _listTaskPosition;
  late Animation _scaleButtons;
  late Animation _option1;
  late Animation _option2;
  late Animation _option3;
  late Animation _option4;

  int _selectedIndex = 0;

  /// Variable que indica si el menu esta abierto o no
  bool _menuOpen = false;

  /* -------------------------------------------------------------------------- */
  /*                                 LIFECYCLES                                 */
  /* -------------------------------------------------------------------------- */
  @override
  void initState() {
    super.initState();
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

    /// Establece los parametros de animacion para hacer rotar el icono del,
    /// FloatingActionButtom
    _rotatedIcon = Tween(begin: 0.0, end: 7.0).animate(_animationController2);

    /// Anima los valores del path del nav bar
    _curve1 = Tween(begin: _NavBarPath().lowSize, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationContoller,
        curve: Curves.bounceIn,
      ),
    );

    /// Anima los valores del path del nav bar
    _curve2 = Tween(begin: _NavBarPath().bigSize, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationContoller,
        curve: Curves.bounceIn,
      ),
    );

    /// Establece los parametros para animar la opacidad del nav bar
    _pathOpacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController2,
        curve: const Interval(0.30, 0.60),
      ),
    );

    /// Establece los parametros para animar la opacidad de los botones
    /// del menu radial
    _opacityButtom = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController2,
        curve: const Interval(0.40, 1.0),
      ),
    );

    /// Establece un tamaño animado para el navBar
    _navBarSize = Tween(begin: 0.08, end: 0.0).animate(_animationController2);

    /// Estabele los parametros para animar la escala de los botones del menu radial
    _scaleButtons = Tween(begin: 0.0, end: 1.0).animate(_animationController2);

    /// Establece los parametros de animacion para el primer boton del navBar
    _option1 = Tween(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _optionController, curve: Curves.bounceOut),
    );

    /// Establece los parametros de animacion para el segundo boton del navBar
    _option2 = Tween(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _optionController, curve: Curves.bounceOut),
    );

    /// Establece los parametros de animacion para el tercer boton del navBar
    _option3 = Tween(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _optionController, curve: Curves.bounceOut),
    );

    /// Establece los parametros de animacion para el cuarto boton del navBar
    _option4 = Tween(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _optionController, curve: Curves.bounceOut),
    );

    /// Inicia este controlador
    _optionController.forward();

    /// Escucha si el controller ha finalizado la animacion para hacer una animacion en reversa
    _animationContoller.addListener(() {
      if (_animationContoller.status == AnimationStatus.completed) {
        _animationContoller.reverse();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Establece una animacion para el FloatingActionButtom
    _buttomBouncing = Tween(
      begin: mediaHeight(context) * 0.042,
      end: mediaHeight(context) * 0.10,
    ).animate(
      CurvedAnimation(
        parent: _animationContoller,
        curve: Curves.bounceIn,
      ),
    );

    /// Establece los parametros para la animacion del boton que agrega
    /// tareas al calendario
    _taskCalendarPosition = Tween(
      begin: Offset(mediaWidth(context) * 0.44, -mediaHeight(context) * 0.047),
      end: Offset(mediaWidth(context) * 0.19, -mediaHeight(context) * 0.10),
    ).animate(
      CurvedAnimation(parent: _animationController2, curve: Curves.bounceIn),
    );

    /// Establece los parametros para la animacion del boton que agrega
    /// tareas rapidas
    _quikTaskPosition = Tween(
      begin: Offset(mediaWidth(context) * 0.44, -mediaHeight(context) * 0.047),
      end: Offset(mediaWidth(context) * 0.44, -mediaHeight(context) * 0.20),
    ).animate(
      CurvedAnimation(parent: _animationController2, curve: Curves.bounceIn),
    );

    /// Establece los parametros para la animacion del boton que agrega
    /// lista de tareas
    _listTaskPosition = Tween(
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
    super.dispose();
  }

  /* -------------------------------------------------------------------------- */
  /*                               END LIFECYCLES                               */
  /* -------------------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _radialMenu(
          context: context,
          colorCalendarTask: widget.colorCalendarTask,
          colorQuikTask: widget.colorQuikTask,
          colorListTask: widget.colorListTask,
          onTapCalendarTask: widget.onTapCalendarTask,
          onTapListTask: widget.onTapListTask,
          onTapQuikTask: widget.onTapQuikTask,
        ),
        _navBar(context),
        _centerButtom(context),
      ],
    );
  }

  /// Este metodo construye un menu radial sobre el FloatingActionButtom central
  /// en el navBar
  Widget _radialMenu({
    required BuildContext context,
    required Function() onTapCalendarTask,
    required Function() onTapListTask,
    required Function() onTapQuikTask,
    Color? colorCalendarTask,
    Color? colorQuikTask,
    Color? colorListTask,
  }) {
    return AnimatedBuilder(
      animation: _animationController2,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            /// Boton para agregar tareas al calendario
            _buildButtom(
              color: colorCalendarTask,
              heroTag: '2',
              icon: Icon(
                Icons.calendar_today,
                size: mediaHeight(context) * 0.040,
                color: Colors.white,
              ),
              offset: _taskCalendarPosition.value,
              onPressed: onTapCalendarTask,
            ),

            /// Boton para agregar tareas rapidas
            _buildButtom(
              color: colorQuikTask,
              heroTag: '3',
              icon: Icon(
                Icons.done_all,
                size: mediaHeight(context) * 0.040,
                color: Colors.white,
              ),
              offset: _quikTaskPosition.value,
              onPressed: onTapQuikTask,
            ),

            /// Boton para agregar tareas de lista
            _buildButtom(
              color: colorListTask,
              heroTag: '4',
              icon: Icon(
                Icons.list,
                size: mediaHeight(context) * 0.040,
                color: Colors.white,
              ),
              offset: _listTaskPosition.value,
              onPressed: onTapListTask,
            ),
          ],
        );
      },
    );
  }

  /// Metodo que construye los botones que agregan tareas
  Widget _buildButtom({
    required Offset offset,
    required Function() onPressed,
    required String heroTag,
    required Widget icon,
    Color? color,
  }) {
    return Positioned(
      bottom: 0,
      child: Transform.translate(
        offset: offset,
        child: Opacity(
          opacity: _opacityButtom.value,
          child: Container(
            alignment: Alignment.center,
            height: mediaHeight(context) * 0.070,
            width: mediaHeight(context) * 0.070,
            child: Transform.scale(
              scale: _scaleButtons.value,
              child: SizedBox(
                height: mediaHeight(context) * 0.070,
                width: mediaHeight(context) * 0.070,
                child: FloatingActionButton(
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

  /// Este metodo contiene la barra del nav bar
  Widget _navBar(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationContoller,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          bottom: 0,
          child: Opacity(
            opacity: _pathOpacity.value,
            child: ClipShadow(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26.withOpacity(0.1),
                  offset: Offset(0.0, -mediaHeight(context) * 0.002),
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
              ],
              clipper: _NavBarPath(
                bigSize: _curve2.value,
                lowSize: _curve1.value,
              ),
              child: Container(
                width: mediaWidth(context),
                height: mediaHeight(context) * _navBarSize.value,
                padding: EdgeInsets.only(
                  left: mediaWidth(context) * 0.030,
                  right: mediaWidth(context) * 0.030,
                ),
                color: widget.navBarColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _listButtonsNavBar(
                    selectedColor: widget.selectedColor,
                    disableColor: widget.disableColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Este metodo contiene FloatingActionButtom central del nav bar
  Widget _centerButtom(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationContoller,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          left: mediaWidth(context) * 0.43,
          right: mediaWidth(context) * 0.43,
          bottom: _buttomBouncing.value,
          child: SizedBox(
            height: mediaHeight(context) * 0.075,
            width: mediaHeight(context) * 0.075,
            child: FloatingActionButton(
              heroTag: '1',
              backgroundColor: widget.addColorButtom,
              child: Transform.rotate(
                angle: _rotatedIcon.value,
                child: Icon(
                  Icons.add,
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

  /// Este metodo contiene todos los botones que se muestran en el navBar
  List<Widget> _listButtonsNavBar({
    Color? selectedColor,
    Color? disableColor,
  }) {
    /// Establece todos los containers que contiene los item en center
    const MainAxisAlignment aligment = MainAxisAlignment.center;

    /// Establece el estilo de texto de los items
    final fontSize = mediaHeight(context) * 0.022;

    /// Establece una lista con todos los items del navBar
    List<Widget> iconList = [
      AnimatedBuilder(
        animation: _optionController,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Row(
              children: [
                GestureDetector(
                  child: Transform.scale(
                    scale: _selectedIndex == 0 ? _option1.value : 1.0,
                    child: Container(
                      alignment: Alignment.center,
                      height: mediaHeight(context) * 0.07,
                      width: mediaWidth(context) * 0.14,
                      child: Column(
                        mainAxisAlignment: aligment,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: mediaHeight(context) * 0.040,
                            color: _selectedIndex == 0 ? selectedColor : disableColor,
                          ),
                          Flexible(
                            child: Text(
                              'Tarea',
                              style: TextStyle(
                                fontSize: fontSize,
                                color: _selectedIndex == 0 ? selectedColor : disableColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    _selectedIndex = 0;
                    _optionController.reset();
                    _optionController.forward();
                    setState(() {});
                  },
                ),
                SizedBox(
                  width: mediaWidth(context) * 0.08,
                ),
                GestureDetector(
                  child: Transform.scale(
                    scale: _selectedIndex == 1 ? _option2.value : 1.0,
                    child: Container(
                      alignment: Alignment.center,
                      height: mediaHeight(context) * 0.07,
                      width: mediaWidth(context) * 0.14,
                      child: Column(
                        mainAxisAlignment: aligment,
                        children: [
                          Icon(
                            Icons.done_all,
                            size: mediaHeight(context) * 0.040,
                            color: _selectedIndex == 1 ? selectedColor : disableColor,
                          ),
                          Flexible(
                            child: Text(
                              'Nota',
                              style: TextStyle(
                                fontSize: fontSize,
                                color: _selectedIndex == 1 ? selectedColor : disableColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    _selectedIndex = 1;
                    _optionController.reset();
                    _optionController.forward();
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
      AnimatedBuilder(
        animation: _optionController,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Row(
              children: [
                GestureDetector(
                  child: Transform.scale(
                    scale: _selectedIndex == 2 ? _option3.value : 1.0,
                    child: Container(
                      alignment: Alignment.center,
                      height: mediaHeight(context) * 0.07,
                      width: mediaWidth(context) * 0.14,
                      child: Column(
                        mainAxisAlignment: aligment,
                        children: [
                          Icon(
                            Icons.list,
                            size: mediaHeight(context) * 0.040,
                            color: _selectedIndex == 2 ? selectedColor : disableColor,
                          ),
                          Flexible(
                            child: Text(
                              'Lista',
                              style: TextStyle(
                                fontSize: fontSize,
                                color: _selectedIndex == 2 ? selectedColor : disableColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    _selectedIndex = 2;
                    _optionController.reset();
                    _optionController.forward();
                    setState(() {});
                  },
                ),
                SizedBox(
                  width: mediaWidth(context) * 0.08,
                ),
                GestureDetector(
                  child: Transform.scale(
                    scale: _selectedIndex == 3 ? _option4.value : 1.0,
                    child: Container(
                      alignment: Alignment.center,
                      height: mediaHeight(context) * 0.07,
                      width: mediaWidth(context) * 0.14,
                      child: Column(
                        mainAxisAlignment: aligment,
                        children: [
                          Icon(
                            Icons.category,
                            size: mediaHeight(context) * 0.040,
                            color: _selectedIndex == 3 ? selectedColor : disableColor,
                          ),
                          Flexible(
                            child: Text(
                              'Categ',
                              style: TextStyle(
                                fontSize: fontSize,
                                color: _selectedIndex == 3 ? selectedColor : disableColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    _selectedIndex = 3;
                    _optionController.reset();
                    _optionController.forward();
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
    ];
    return iconList;
  }

  /// Este metodo se encarga de establecer la logica que permite iniciar
  /// la animacion de cada elemento.
  void _logicaDeAnimacion(BuildContext context) {
    _animationContoller.forward();
    if (_menuOpen == false) {
      _animationController2.forward();
      _menuOpen = true;
      setState(() {});
    } else {
      _animationController2.reverse();
      _menuOpen = false;
      setState(() {});
    }
  }
}

/// Dibuja la forma del nav bar por medio del CustomClipper
class _NavBarPath extends CustomClipper<Path> {
  final double lowSize;
  final double bigSize;

  _NavBarPath({
    this.lowSize = 0.2,
    this.bigSize = 1.0,
  });

  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width * 0.29, 0);
    path.quadraticBezierTo(size.width * 0.35, 0, size.width * 0.38, size.height * lowSize);
    path.quadraticBezierTo(size.width * 0.50, size.height * bigSize, size.width * 0.62, size.height * lowSize);
    path.quadraticBezierTo(size.width * 0.65, 0, size.width * 0.71, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
