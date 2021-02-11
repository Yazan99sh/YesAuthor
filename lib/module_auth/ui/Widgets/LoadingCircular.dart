import 'package:c4d/module_theme/ColorPicker.dart';
import 'package:flutter/material.dart';
class LoadingCircular extends StatelessWidget {
  final String msg;

  LoadingCircular(this.msg);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      width:double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 50,
              child:CircularProgressIndicator(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('$msg',style: TextStyle(color: ColorPicker.secondaryTextColor),)),
          )
        ],
      ),
    );
  }
}
