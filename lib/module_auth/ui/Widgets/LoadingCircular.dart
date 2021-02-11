import 'package:flutter/material.dart';
class LoadingCircular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      width:double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          child:CircularProgressIndicator(),
        ),
      ),
    );
  }
}
