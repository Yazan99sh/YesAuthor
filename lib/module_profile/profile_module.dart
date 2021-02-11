import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/UI/screens/LogedTest.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
@provide
class ProfileModule extends YesModule {
  final AuthService authService;
  final ProfileService profileService;
  ProfileModule(this.authService,this.profileService);
  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ProfileRoutes.Logged: (context) => Logged(authService,profileService),
    };
  }
}
