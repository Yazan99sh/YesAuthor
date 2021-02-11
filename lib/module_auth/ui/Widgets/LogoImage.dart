import 'package:flutter/material.dart';
class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top:65),
        child: Image.asset('images/logo2.png',width: 100,height: 100,),
      ),
    );
  }
}
