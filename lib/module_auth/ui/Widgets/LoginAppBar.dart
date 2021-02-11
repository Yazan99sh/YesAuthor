import 'package:flutter/material.dart';
PreferredSizeWidget loginAppBar(){
  return AppBar(
    elevation: 0,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Colors.grey[900].withOpacity(0),
    title: Image.asset(
      'assets/images/titleLogo.png',
      scale: 3.5,
    ),
    centerTitle: true,
  );
}
