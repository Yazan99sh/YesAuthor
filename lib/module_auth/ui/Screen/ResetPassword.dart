import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/Widgets/LRFrame.dart';
import 'package:c4d/module_auth/ui/Widgets/LoadingCircular.dart';
import 'package:c4d/module_auth/ui/Widgets/StackedBottun.dart';
import 'package:c4d/module_auth/ui/Widgets/TermsAndPrivacy.dart';
import 'package:c4d/module_auth/ui/Widgets/field.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_theme/ColorPicker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
class ResetPassword extends StatefulWidget {
  final AuthService authService;
  @override
  _ResetPasswordState createState() => _ResetPasswordState();

  ResetPassword(this.authService);
}

class _ResetPasswordState extends State<ResetPassword> {
  TapGestureRecognizer _pressRecognizer;
  TextEditingController code;
  TextEditingController email;
  TextEditingController password;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _pressRecognizer = TapGestureRecognizer()..onTap = _handlePress;
    code = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    _pressRecognizer.dispose();
    super.dispose();
  }

  void _handlePress() {
    print('');
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return LRFrame(Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
              child: Text(
                'Reset your password',
                style: TextStyle(
                  color:ColorPicker.primaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _loginFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 16, left: 16),
                            child: Field(text:'Reset Code',controller: code,validator:(result) {
                              if (result.isEmpty) {
                                return 'Please fill this field';
                              }
                              return null;
                            },onEditingComplete: () => node.nextFocus()),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 16, left: 16),
                            child: Field(text: 'Email',controller: email,validator:(result) {
                              if (result.isEmpty) {
                                return 'Please fill this field';
                              }
                              return null;
                            },onEditingComplete: () => node.nextFocus()),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 16, left: 16),
                            child: Field(text: 'Password',controller: password,validator: (result){
                              if (result.isEmpty){
                                return "Please fill this field";
                              }
                              else if (result.length < 6){
                                return "Password with less than 6 characters not allowed";
                              }
                              else
                                return null;
                            },onFieldSubmitted:(_) => node.unfocus()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TermsAndPrivacy(_pressRecognizer),
                            ),
                          ),
                          //Google('Register with google'),
                          Container(
                            height: 55,
                            width: double.maxFinite,
                          )
                        ],
                      ),
                    ),
                  ),
                  StackedButton(text:'Reset',onPressed: (){
                    if (_loginFormKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      widget.authService.registerUser(code.text,email.text,password.text).then((value){
                        if(value) {
                          Navigator.pushNamed(context, ProfileRoutes.Logged);
                        }
                      }).whenComplete(() => setState((){
                        loading = false;
                      }));
                    }
                  },),
                ],
              ),
            ),
          ],
        ),
        loading?LoadingCircular('Loading...'):Container(),
      ],
    ));
  }

}
