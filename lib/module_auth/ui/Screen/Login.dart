import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/Widgets/LRFrame.dart';
import 'package:c4d/module_auth/ui/Widgets/LoadingCircular.dart';
import 'package:c4d/module_auth/ui/Widgets/ResetDialogPassword.dart';
import 'package:c4d/module_auth/ui/Widgets/StackedBottun.dart';
import 'package:c4d/module_auth/ui/Widgets/field.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_theme/ColorPicker.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final AuthService authService;

  Login(this.authService);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email;
  TextEditingController password;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return LRFrame(Stack(children: [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
            child: Text(
              'Welcome back!',
              style: TextStyle(
                color: ColorPicker.primaryTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            'Login with your email to start chatting',
            style: TextStyle(
              color: ColorPicker.secondaryTextColor,
              fontSize: 13,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                            child: Field(text:'Email',controller: email,validator:(result) {
                              if (result.isEmpty) {
                                return 'Please fill this field';
                              }
                              return null;
                            },),
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
                            },),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SelectableText(
                                'Forgot your password?',
                                onTap: (){
                                  resetDialogPassword(context,widget.authService);
                                },
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          //Google('Login With Google'),
                          Container(
                            height: 55,
                            width: double.maxFinite,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                StackedButton(text:'Login',onPressed: (){
                  if (_loginFormKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    widget.authService.loginUser(email.text,password.text).then((value){
                      if (value){
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
      loading?LoadingCircular():Container(),
    ],));
  }

}
