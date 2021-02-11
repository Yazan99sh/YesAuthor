import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/request/login_request/LoginRequest_Api.dart';
import 'package:c4d/module_auth/request/login_request/login_request.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_auth/response/login_response/login_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';

@provide
class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<String> createUser(RegisterRequest request) async {
    UserCredential userCredential;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:request.email,
        password:request.password,
      );
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> login(LoginRequest loginRequest) async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "${loginRequest.email}",
          password: "${loginRequest.password}"
      );
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      // if (e.code=='invalid-email'){
      //   return 'Wrong email pattern';
      // }
      // else if (e.code == 'user-not-found') {
      //   return 'No user found for that email.';
      // } else if (e.code == 'wrong-password') {
      //   return 'Wrong password provided for that user.';
      // }
      // else {
      //   return e.code ;
      // }
      print(e.code);
      return null;
    }
  }

  Future<LoginResponse> loginApi(LoginRequestApi loginRequest) async {
    Map<String, String> headers = {'Content-Type':'application/json'};
    var result = await _apiClient.post(Urls.CREATE_TOKEN_API,loginRequest.toJson(),headers:headers);
    if (result == null) {
      return null;
    }
    return LoginResponse.fromJson(result);
  }

}
