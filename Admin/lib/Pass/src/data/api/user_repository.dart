import 'package:keepapp/utils/LocalDataStorage.dart';
import 'package:keepapp/utils/Api.dart' as Api;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:keepapp/utils/Utils.dart';

class UserRepository extends ChangeNotifier {
  String token;
  LocalDataStorage localDataStorage = LocalDataStorage();
  bool isLoading = false;
  Future<bool> signInWithCredentials(String email, String password) async {
    isLoading = true;
    notifyListeners();
    return Api.signInUser(email, password).then((token) {
      if (token != null) {
        isLoading = false;
        localDataStorage.saveToken(token);
        localDataStorage.saveUserId(Utils.userId);
        localDataStorage.saveRole(Utils.role);
        localDataStorage.saveEmail(Utils.userEmail);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }).catchError((onError) {
      isLoading = false;
      Utils.showToast(Utils.getErrorMessage(onError));
      notifyListeners();
      return false;
    });
  }

  Future<void> signUp({String email, String password, String role}) async {
    isLoading = true;
    notifyListeners();
    return Api.registerUser(email, password, role).then((result) {
      if (result) {
        isLoading = false;
        // localDataStorage.saveToken(token);
        // localDataStorage.saveUserId(Utils.userId);
        notifyListeners();
      } else {
        isLoading = false;
        Utils.showToast(Utils.getErrorMessage("User Not added"));
        notifyListeners();
      }
    }).catchError((onError) {
      isLoading = false;
      Utils.showToast(Utils.getErrorMessage(onError));
      notifyListeners();
    });
  }

  Future<void> signOut() async {
    Utils.loginToken = null;
    localDataStorage.clear();
  }

  Future<bool> isSignedIn() async {
    Utils.loginToken = await localDataStorage.getToken();
    Utils.userId = await localDataStorage.getUserId();
    Utils.role = await localDataStorage.getUserRole();
    Utils.userEmail = await localDataStorage.getUserEmail();
    if (Utils.loginToken != null) {
      bool isValid = await Api.signInWithToken(Utils.loginToken);
      print(isValid);
      if (isValid ?? false) {
        return true;
      }
    }
    return false;
  }

  Future<String> getUser() async {
    print("reach in sign inn: get user user repo");
    return Utils.userId;
  }
}
