import 'package:flutter/material.dart';

/// Funcion que contiene el mediaquery para el alto
double mediaHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// Funcion que contiene el mediaquery para el ancho
double mediaWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
