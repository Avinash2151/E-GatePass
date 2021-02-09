import 'package:cross_local_storage/cross_local_storage.dart';
import 'package:keepapp/utils/AppConstants.dart';

/// Store Local data for app usage
class LocalDataStorage {
  LocalStorageInterface prefs;

  /// saveToken [token]
  void saveToken(String token) async {
    prefs = await LocalStorage.getInstance();
    prefs.setString(AppConstants.API_TOKEN, token);
  }

  /// saveUserId [userId]
  void saveUserId(String userId) async {
    prefs = await LocalStorage.getInstance();
    prefs.setString(AppConstants.LOCAL_ID, userId);
  }

  ///Save roll
  void saveRole(String role) async {
    prefs = await LocalStorage.getInstance();
    prefs.setString(AppConstants.DISPLAY_NAME, role);
  }

  /// Save Email
  void saveEmail(String email) async {
    prefs = await LocalStorage.getInstance();
    prefs.setString(AppConstants.EMAIL, email);
  }

  /// getToken
  Future<String> getToken() async {
    prefs = await LocalStorage.getInstance();
    return prefs.getString(AppConstants.API_TOKEN);
  }

  /// getUserId
  Future<String> getUserId() async {
    prefs = await LocalStorage.getInstance();
    return prefs.getString(AppConstants.LOCAL_ID);
  }

  ///get USer roll
  Future<String> getUserRole() async {
    prefs = await LocalStorage.getInstance();
    return prefs.getString(AppConstants.DISPLAY_NAME);
  }

  ///get USer email
  Future<String> getUserEmail() async {
    prefs = await LocalStorage.getInstance();
    return prefs.getString(AppConstants.EMAIL);
  }

  /// clear local app data
  Future<String> clear() async {
    prefs = await LocalStorage.getInstance();
    await prefs.setString(AppConstants.API_TOKEN, null);
    await prefs.setString(AppConstants.LOCAL_ID, null);
    await prefs.setString(AppConstants.API_KEY, null);
    await prefs.setString(AppConstants.DISPLAY_NAME, null);
    await prefs.setString(AppConstants.EMAIL, null);
    await prefs.clear();
  }
}
