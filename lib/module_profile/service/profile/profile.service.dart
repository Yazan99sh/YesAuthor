import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart';
import 'package:c4d/module_profile/manager/profile/profile.manager.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:inject/inject.dart';

@provide
class ProfileService {
  final ProfileManager _manager;
  final AuthPrefsHelper _authPrefsHelper;
  ProfileService(
    this._manager,
      this._authPrefsHelper
  );
  Future<bool> createProfile(String userName,token) async {
    // _repository = ProfileRepository();
    // _manager = ProfileManager(_repository);
    ProfileRequest profileRequest = ProfileRequest(
        userName:userName
    );
    return await _manager.createProfile(profileRequest,token);
  }
  Future<dynamic> getProfile() async {

    String token = await _authPrefsHelper.getToken();
    var data = await _manager.getProfile(token);
    return data;
  }
  Future<dynamic> updateProfile(userName) async {
    String token = await _authPrefsHelper.getToken();
    return await _manager.updateProfile(token,ProfileRequest(userName: userName));
  }
}
