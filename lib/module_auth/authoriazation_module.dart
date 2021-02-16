import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/Screen/Login.dart';
import 'package:c4d/module_auth/ui/Screen/Register.dart';
import 'package:c4d/module_auth/ui/Screen/ResetPassword.dart';
import 'package:c4d/module_auth/ui/Screen/WelcomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'authorization_routes.dart';

@provide
class AuthorizationModule extends YesModule {
  final AuthService _authService ;

  AuthorizationModule(this._authService);


  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      AuthorizationRoutes.LOGIN_SCREEN: (context) => Login(_authService),
      AuthorizationRoutes.REGISTER_SCREEN: (context) => Register(_authService),
      AuthorizationRoutes.WelcomePage: (context) => WelcomePage(),
      AuthorizationRoutes.ResetPassword:(context) => ResetPassword(_authService)
    };
  }
}
