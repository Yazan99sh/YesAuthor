import 'package:flutter/material.dart';
class Field extends StatefulWidget {
  final controller;
  final String text;
  final FormFieldValidator<String> validator;
  Field({Key key, this.controller, this.text ,this.validator})
      : assert(text != null),
        super(key: key);

  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<Field> {
  FocusNode focus;
  TextStyle style = TextStyle(color: Colors.white24);
  bool secure = true;
  Color color = Colors.white24;
  Icon icon ;
  @override
  void initState() {
    super.initState();
    icon = Icon(Icons.visibility_off);
    focus = FocusNode();
    focus.addListener(() {
      if (focus.hasPrimaryFocus) {
        setState(() {
          style = null;
          color = Colors.grey;
        });
      } else if (focus.canRequestFocus) {
        setState(() {
          style = TextStyle(color: Colors.white24);
          color = Colors.white24;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: focus,
      validator:widget.validator,
      style: TextStyle(color: Colors.white),
      obscureText:widget.text=='Password'&& secure ?true :false ,
      decoration: InputDecoration(
        suffixIcon:widget.text=='Password'?IconButton(
          color: color,
          icon: icon,
          onPressed: (){
            if (secure)
            setState(() {
              secure = false;
              icon = Icon(Icons.remove_red_eye);
            });
            else {
              setState(() {
                secure = true;
                icon = Icon(Icons.visibility_off);
              });
            }
          },
        ):null,
        labelText: '${widget.text}',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle:style,
      ),
    );
  }
}
