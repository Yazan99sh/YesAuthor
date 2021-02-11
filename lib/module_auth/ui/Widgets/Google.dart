import 'package:flutter/material.dart';
class Google extends StatelessWidget {
  final text;

  Google(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 55,
      child: RaisedButton.icon(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18)),
        icon: Padding(
          padding:
              const EdgeInsets.only(right: 8.0),
          child: Image.asset('images/google.png',width: 20,height: 20,)
        ),
        color: Colors.grey[50],
        splashColor: Color.fromRGBO(255,189,8,1),
        onPressed: (){},
        label: Text(
          '$text',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
