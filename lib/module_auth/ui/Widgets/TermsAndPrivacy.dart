import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
class TermsAndPrivacy extends StatelessWidget {
  final pressRecognizer;
  TermsAndPrivacy(this.pressRecognizer);
  @override
  Widget build(BuildContext context) {
    return  RichText(
      text: TextSpan(children: [
        TextSpan(
            text:
            "By registering you agree to ChetChat's ",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            )),
        TextSpan(
            text: "Terms of service",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 13,
            ),
            recognizer: pressRecognizer),
        TextSpan(
            text: " and ",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            )),
        TextSpan(
            text: "Privacy Policy",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 13,
            ),
            recognizer: pressRecognizer),
        TextSpan(
            text: ".",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            )),
      ]),
    );
  }
}
