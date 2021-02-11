import 'package:c4d/module_auth/repository/auth/auth_repository.dart';
import 'package:c4d/module_auth/request/login_request/LoginRequest_Api.dart';
import 'package:c4d/module_auth/request/login_request/login_request.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_auth/response/login_response/login_response.dart';
import 'package:inject/inject.dart';

@provide
class AuthManager {
  final AuthRepository _authRepository;
  AuthManager(this._authRepository);
  Future<dynamic> register(RegisterRequest registerRequest) => _authRepository.createUser(registerRequest);

  Future<dynamic> login(LoginRequest loginRequest) => _authRepository.login(loginRequest);
  Future<LoginResponse> loginApi(LoginRequestApi loginRequestApi) => _authRepository.loginApi(loginRequestApi);
}
