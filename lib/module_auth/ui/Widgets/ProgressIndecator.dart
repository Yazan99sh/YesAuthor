import 'package:flutter/material.dart';
class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:25),
      child: Container(
          width: 100,
          child: LinearProgressIndicator()),
    );
  }
}
