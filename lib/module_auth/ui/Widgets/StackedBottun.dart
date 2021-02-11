import 'package:flutter/material.dart';
class StackedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  StackedButton({Key key,this.onPressed, this.text}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: double.maxFinite,
          height: 55,
          child: RaisedButton(
            onPressed:onPressed,
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$text',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
