import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/src/models/models.dart';
import 'package:keepapp/utils/AppConstants.dart';
import 'package:keepapp/utils/Exceptions.dart';
import 'package:keepapp/utils/Utils.dart';

String parent =
    "projects/aakarfoundry-6fabe/databases/(default)/documents/visits";

/// To work on Notes List
String VISIT_API =
    "https://firestore.googleapis.com/v1/projects/aakarfoundry-6fabe/databases/(default)/documents/visits";

/// Register User
const registerUserApi =
    "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${AppConstants.API_KEY}";

/// Login Existing User with Email and Password
const signInApi =
    "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${AppConstants.API_KEY}";

/// Login Existing User with Token
const loginWithApiToken =
    "https://www.googleapis.com/identitytoolkit/v3/relyingparty/getAccountInfo?key=${AppConstants.API_KEY}";

/// Send reset password email to user
const passwordResetApi =
    "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=${AppConstants.API_KEY}";

/// return List of notes of user
Future<List<Visit>> getVisit() async {
  try {
    var response = await http.get("${VISIT_API}",
        headers: {"Authorization": "Bearer ${Utils.loginToken}"});
    if (response.statusCode == 200) {
      List<Visit> visitLists = List();
      Map map = json.decode(response.body);

      print("Map is : $map");
      List list = map['documents'];
      if (list != null && !list.isEmpty) {
        for (int i = 0; i < list.length; i++) {
          print("reach 1");
          Visit visit = Visit.store(
            map['documents'][i]['name'].toString().replaceAll(parent, ""),
            ((map['documents'][i]['fields'] ?? Map())['status'] ??
                Map())['stringValue'],
            ((map['documents'][i]['fields'] ?? Map())['id'] ??
                Map())['stringValue'],
            ((map['documents'][i]['fields'] ?? Map())['name'] ??
                Map())['stringValue'],
            int.parse(((map['documents'][i]['fields'] ?? Map())['dateTime'] ??
                Map())['integerValue']),
            int.parse(((map['documents'][i]['fields'] ?? Map())['mob'] ??
                Map())['integerValue']),
            int.parse(((map['documents'][i]['fields'] ?? Map())['idproof'] ??
                Map())['integerValue']),
            ((map['documents'][i]['fields'] ?? Map())['address'] ??
                Map())['stringValue'],
            ((map['documents'][i]['fields'] ?? Map())['purpose'] ??
                Map())['stringValue'],
            ((map['documents'][i]['fields'] ?? Map())['facility_1'] ??
                Map())['stringValue'],
            ((map['documents'][i]['fields'] ?? Map())['facility_2'] ??
                Map())['stringValue'],
            ((map['documents'][i]['fields'] ?? Map())['facility_3'] ??
                Map())['stringValue'],
          );
          print("reach 2");
          visitLists.add(visit);
        }
      }
      print("Visit list is : $visitLists");
      return visitLists;
    } else {
      Map map = json.decode(response.body);
      print("error is : $map");
      throw (UserMessageException(map['error']['status']));
    }
  } catch (err) {
    throw err;
  }
}

/// return add new note [noteModel]
Future<bool> addNote(Visit visit) async {
  List<String> list = ["Avi", "Mawle"];
  try {
    var response = await http.post(
      "${VISIT_API}",
      headers:
          //{"Content-Type": "application/json"},
          {"Authorization": "Bearer ${Utils.loginToken}"},
      body: json.encode(
        {
          "fields": {
            "status": {"stringValue": visit.status},
            "id": {"stringValue": visit.id},
            "name": {"stringValue": visit.name},
            "dateTime": {"integerValue": visit.dateTime},
            "mob": {"integerValue": visit.mob},
            "idproof": {"integerValue": visit.idproof},
            "address": {"stringValue": visit.address},
            "purpose ": {"stringValue": visit.purpose},
            // "facility": {"arrayValue": { "values": [ {"stringValue": list }]}},
            "facility_1": {
              "stringValue":
                  visit.facility_1 != null ? visit.facility_1 : "not needed"
            },
            "facility_2": {
              "stringValue":
                  visit.facility_2 != null ? visit.facility_2 : "not needed"
            },
            "facility_3": {
              "stringValue":
                  visit.facility_3 != null ? visit.facility_3 : "not needed"
            },
          }
        },
      ),
    );
    if (response.statusCode == 200) {
      print("visit added");
      return true;
    } else {
      print(response.body);
      return false;
    }
  } catch (err) {
    throw err;
  }
}

/// update existing note [noteModel]
Future<bool> updateData(Visit visit) async {
  String updateApi = "$VISIT_API" + visit.doc_id;

  try {
    var response = await http.patch(
      updateApi,
      headers: {"Authorization": "Bearer ${Utils.loginToken}"},
      body: json.encode(
        {
          "fields": {
            "status": {"stringValue": visit.status},
            "id": {"stringValue": visit.id},
            "name": {"stringValue": visit.name},
            "dateTime": {"integerValue": visit.dateTime},
            "mob": {"integerValue": visit.mob},
            "idproof": {"integerValue": visit.idproof},
            "address": {"stringValue": visit.address},
            "purpose ": {"stringValue": visit.purpose},
            "facility_1": {
              "stringValue":
                  visit.facility_1 != null ? visit.facility_1 : "not needed"
            },
            "facility_2": {
              "stringValue":
                  visit.facility_2 != null ? visit.facility_2 : "not needed"
            },
            "facility_3": {
              "stringValue":
                  visit.facility_3 != null ? visit.facility_3 : "not needed"
            },
          }
        },
      ),
    );
    if (response.statusCode == 200) {
      print("Visit updated");
      return true;
    } else {
      print(response.body);
      return false;
    }
  } catch (err) {
    throw err;
  }
}

/// delete existing note [noteModel]
Future<bool> deleteVisit(Visit visit) async {
  try {
    var response = await http.delete(
      "${VISIT_API}${visit.doc_id}",
      headers: {"Authorization": "Bearer ${Utils.loginToken}"},
    );
    if (response.statusCode == 200) {
      return true;
    }
  } catch (err) {
    throw err;
  }
}

/// Sign-in existing user with  [email] and [password]
Future<String> signInUser(String email, String password) async {
  try {
    var response = await http.post(signInApi,
        body: json.encode({
          AppConstants.EMAIL: email,
          AppConstants.PASSWORD: password,
          "returnSecureToken": true
        }));
    if (response.statusCode == 200) {
      Map map = json.decode(response.body);
      Utils.loginToken = map['idToken'];
      Utils.userId = map['localId'];
      return Utils.loginToken;
    } else {
      Map map = json.decode(response.body);
      throw (UserMessageException(map['error']['message']));
    }
  } catch (err) {
    print("Login error is :");
    print(err);
    throw err;
  }
}

/// Sign-up new user with [email] and [password]
Future<String> registerUser(String email, String password) async {
  try {
    var response = await http.post(registerUserApi,
        body: json.encode(
            {AppConstants.EMAIL: email, AppConstants.PASSWORD: password}));

    if (response.statusCode == 200) {
      Map map = json.decode(response.body);
      Utils.loginToken = map['idToken'];
      Utils.userId = map['localId'];
      return Utils.loginToken;
    } else {
      Map map = json.decode(response.body);
      throw (UserMessageException(map['error']['message']));
    }
  } catch (err) {
    throw err;
  }
  return null;
}

/// Sign-in existing user with  [token]
Future<bool> signInWithToken(String token) async {
  print("token is $token");
  try {
    var response = await http.post(loginWithApiToken,
        body: json.encode({"idToken": token}));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (err) {
    throw err;
  }
}

/// Reset password with [email]
Future<bool> resetPassword(String email) async {
  try {
    var response = await http.post(passwordResetApi,
        body: json.encode({
          AppConstants.EMAIL: email,
          AppConstants.REQUEST_TYPE: "PASSWORD_RESET"
        }));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (err) {
    throw err;
  }
}

/// send Email verification [email]
Future<bool> sendVerifyEmail(String email) async {
  try {
    var response = await http.post(passwordResetApi,
        body: json.encode({
          AppConstants.EMAIL: email,
          AppConstants.REQUEST_TYPE: "VERIFY_EMAIL"
        }));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (err) {
    throw err;
  }
}
