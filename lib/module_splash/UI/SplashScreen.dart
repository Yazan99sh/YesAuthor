import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthPrefsHelper authPrefsHelper;
  @override
  void initState(){
  super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    authPrefsHelper = AuthPrefsHelper();
    auth.authStateChanges().listen((User user) async{
      var token = await authPrefsHelper.getToken();
      if (token == null) {
        if (user == null) {
          Navigator.pushNamed(context, AuthorizationRoutes.WelcomePage,);
        } else {
          //FirebaseAuth.instance.signOut();
          //Navigator.pushNamed(context, ProfileRoutes.Logged);
        }
      }
      else {
        Navigator.pushNamed(context, ProfileRoutes.Logged);
      }
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(51, 51, 51, 1),
        child: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top:65),
                  child: Image.asset('images/logo2.png',width: 100,height: 100,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:25),
                child: Container(
                    width: 100,
                    child: LinearProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
