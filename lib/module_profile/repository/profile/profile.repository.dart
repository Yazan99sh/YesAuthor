import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:inject/inject.dart';

@provide
class ProfileRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  ProfileRepository(
    this._apiClient,
    this._authService,
  );

  Future<bool> createProfile(ProfileRequest profileRequest,token) async {
    var headers= {'Content-Type':'application/json','Authorization':'Bearer $token'};
    dynamic response = await _apiClient.post(
      Urls.PROFILE,
      profileRequest.toJson(),
      headers:headers,
    );

    if (response['status_code'] == '201' || response['status_code'] == '200') return true;

    return false;
  }
  Future<dynamic> getProfile(token) async {
    var headers= {'Content-Type':'application/json','Authorization':'Bearer $token'};
    dynamic response = await _apiClient.get(
      Urls.PROFILE,
      headers: headers,
    );
    //print(token);
    if (response['status_code'] == '200') return response;

    return null;
  }
  Future<bool> updateProfile(token,ProfileRequest profileRequest) async {
    var headers= {'Content-Type':'application/json','Authorization':'Bearer $token'};
    dynamic response = await _apiClient.put(
        Urls.PROFILE,
      profileRequest.toJson(),
        headers:headers,
    );

    if (response['status_code'] == '200') return response;

    return false;
  }
}
