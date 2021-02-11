import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart';
import 'package:c4d/module_auth/request/login_request/LoginRequest_Api.dart';
import 'package:c4d/module_auth/request/login_request/login_request.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:c4d/module_profile/manager/profile/profile.manager.dart';
import 'package:c4d/module_profile/repository/profile/profile.repository.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/subjects.dart';

@provide
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
  final FireNotificationService _fireNotificationService;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final PublishSubject _authSubject = PublishSubject();
  Stream get onAuthorized => _authSubject.stream;
  ApiClient _apiClient;
  ProfileService _profileService;
  Future<bool> get isLoggedIn => _prefsHelper.isSignedIn();
  AuthService(
      this._prefsHelper,
      this._authManager,
      this._fireNotificationService,
      );

  Future <bool> registerUser(String username ,String email,String password ) async {
    _apiClient = ApiClient(Logger());
    _profileService = ProfileService(ProfileManager(ProfileRepository(_apiClient,AuthService(_prefsHelper, _authManager, _fireNotificationService))));
    String uId;
    try {
      uId = await _authManager.register(RegisterRequest(username: username , email: email , password: password));
      if (uId != null) {
        var headers = {'Content-Type': 'application/json'};
        var body = {'userID': '$uId','password':'$password'};
        var result = await _apiClient.post(Urls.API_SIGN_UP,body,headers:headers);
        if (result['status_code']=='201' || result['status_code']=='200') {
          var token = await _authManager.loginApi(
              LoginRequestApi(username: uId, password: password));
          if (token.token != null) {
            await _profileService.createProfile(username, token.token);
            AuthPrefsHelper authPrefsHelper = AuthPrefsHelper();
            await authPrefsHelper.setToken(token.token);
            return true;
          }
          return false;
        }
        else {return false;}
      }
      return false;
    }catch(e){
      print(e);
      return false;
    }
  }
  Future <bool> loginUser(String email,String password) async {

    var uId;
    try {
      uId = await _authManager.login(LoginRequest(email: email ,password: password));
      if (uId != null) {
        var token = await _authManager.loginApi(LoginRequestApi(username: uId,password: password));
        if (token.token != null){
          AuthPrefsHelper authPrefsHelper = AuthPrefsHelper();
          await authPrefsHelper.setToken(token.token);
          return true;
        }
        else {return false;}
      }
      else
        {return false;}
    }catch(e){
      print(e);
      Logger().info('AuthService', 'User Already Exists');
      return false;
    }
  }

  Future <void> resetPassword(String email) async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email:email);
    } catch (e) {
      print(e);
    }
  }
  Future<void> logout() async {
    await _prefsHelper.clearPrefs();
    await _firebaseAuth.signOut();
  }
}
// class AuthService {
//   final AuthPrefsHelper _prefsHelper;
//   final AuthManager _authManager;
//   final FireNotificationService _fireNotificationService;
//
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   final PublishSubject _authSubject = PublishSubject();
//   Stream get onAuthorized => _authSubject.stream;
//
//   AuthService(
//       this._prefsHelper,
//       this._authManager,
//       this._fireNotificationService,
//       );
//
//   Future<bool> loginUser(
//       String uid,
//       String password,
//       String email,
//       USER_TYPE role,
//       AUTH_SOURCE authSource,
//       ) async {
//     try {
//       await _authManager.register(RegisterRequest(
//         userID: uid,
//         password: uid,
//         roles: [role.toString().split('.')[1]],
//       ));
//     } catch (e) {
//       Logger().info('AuthService', 'User Already Exists');
//     }
//
//     LoginResponse loginResult = await _authManager.login(LoginRequest(
//       username: uid,
//       password: uid,
//     ));
//
//     if (loginResult == null) {
//       return false;
//     }
//
//     await Future.wait([
//       _prefsHelper.setUserId(uid),
//       _prefsHelper.setAuthSource(authSource),
//       _prefsHelper.setToken(loginResult.token),
//       _prefsHelper.setCurrentRole(role),
//     ]);
//
//     await _fireNotificationService.refreshNotificationToken(loginResult.token);
//     return true;
//   }
//
//   Future<USER_TYPE> get userRole {
//     return _prefsHelper.getCurrentRole();
//   }
//
//   Future<String> getToken() async {
//     try {
//       bool isLoggedIn = await this.isLoggedIn;
//       var tokenDate = await this._prefsHelper.getTokenDate();
//       var diff = DateTime.now().difference(DateTime.parse(tokenDate)).inMinutes;
//       if (isLoggedIn) {
//         if (diff < 0) {
//           diff = diff * -1;
//         }
//         if (diff < 55) {
//           return _prefsHelper.getToken();
//         }
//         await refreshToken();
//         return _prefsHelper.getToken();
//       }
//     } catch (e) {
//       return null;
//     }
//     return null;
//   }
//
//   Future<Map<String, String>> getAuthHeaderMap() async {
//     var token = await getToken();
//     return {'Authorization': 'Bearer ' + token};
//   }
//
//   Future<void> refreshToken() async {
//     String uid = await _prefsHelper.getUserId();
//     LoginResponse loginResponse = await _authManager.login(LoginRequest(
//       username: uid,
//       password: uid,
//     ));
//     await _prefsHelper.setToken(loginResponse.token);
//   }
//
//   Future<bool> get isLoggedIn => _prefsHelper.isSignedIn();
//
//   Future<String> get userID => _prefsHelper.getUserId();
//
//   Future<void> logout() async {
//     await _firebaseAuth.signOut();
//     await _prefsHelper.clearPrefs();
//   }
// }