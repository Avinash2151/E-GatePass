import 'package:keepapp/utils/LocalDataStorage.dart';
import 'package:keepapp/utils/Api.dart' as Api;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:keepapp/utils/Utils.dart';

class UserRepository extends ChangeNotifier {
  String token;
  LocalDataStorage localDataStorage = LocalDataStorage();
  bool isLoading = false;


  Future<void> signInWithCredentials(String email, String password) async {
//    return _firebaseAuth.signInWithEmailAndPassword(
//        email: email, password: password);
    isLoading = true;
    notifyListeners();
    return Api.signInUser(email, password).then((token) {
      if (token != null) {
        isLoading = false;
        localDataStorage.saveToken(token);
        localDataStorage.saveUserId(Utils.userId);
        notifyListeners();
      }
    }).catchError((onError) {
      isLoading = false;
      Utils.showToast(Utils.getErrorMessage(onError));
      notifyListeners();
    });
  }

  Future<void> signUp({String email, String password}) async {
//    return await _firebaseAuth.createUserWithEmailAndPassword(
//        email: email, password: password);
    isLoading = true;
    notifyListeners();
    return Api.registerUser(email, password).then((token) {
      if (token != null) {
        isLoading = false;
        localDataStorage.saveToken(token);
        localDataStorage.saveUserId(Utils.userId);
        notifyListeners();
      }
    }).catchError((onError) {
      isLoading = false;
      Utils.showToast(Utils.getErrorMessage(onError));
      notifyListeners();
    });
  }

  Future<void> signOut() async {
    Utils.loginToken=null;
    localDataStorage.clear();
  }

  Future<bool> isSignedIn() async {
    bool status;

    Utils.loginToken = await localDataStorage.getToken();
    Utils.userId = await localDataStorage.getUserId();
    if (Utils.loginToken != null) {
      print("token is $Utils.loginToken");
      bool isValid = await Api.signInWithToken(Utils.loginToken);
      print(isValid);

      print("is valid is $isValid");
      if (isValid ?? false) {
        return true;
      }
//      else {
//        return false;
//      }
    }
    return false;
  }

//    print("status is $status");
//    return status;
//    final currentUser = await _firebaseAuth.currentUser();
//    return currentUser != null;

  Future<String> getUser() async {
    return Utils.userId;
    //  return (await _firebaseAuth.currentUser()).email;
  }
}
