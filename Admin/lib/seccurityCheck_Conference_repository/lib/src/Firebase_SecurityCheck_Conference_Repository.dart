import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:keepapp/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:keepapp/Security/SecurityCheck/securityCheckConferenceApi.dart'
    as Api;
import '../securityCheck_Conference_repository.dart';

class FirebaseSecurityCheckConferenceRepository extends ChangeNotifier
    implements SecurityCheckConferenceRepository {
  String parent =
      "projects/aakarfoundry-6fabe/databases/(default)/documents/conference";

  String filteredConferenceApi =
      "https://firestore.googleapis.com/v1/projects/aakarfoundry-6fabe/databases/(default)/documents/conference/";
  String errorMsg;

  ///Conference
  @override
  Future<SecurityCheck_Conference> securityCheckConference(String docID) async {
    String getString = "$filteredConferenceApi" + Utils.docIdConference;
    print("conference api string");
    print(getString);
    try {
      var response = await http.get("${getString}",
          headers: {"Authorization": "Bearer ${Utils.loginToken}"});

      if (response.statusCode == 200) {
        print(json.decode(response.body));

        Map map = json.decode(response.body);
        SecurityCheck_Conference visit = SecurityCheck_Conference.store(
          map['name'].toString().replaceAll(parent, ""),
          ((map['fields'] ?? Map())['status'] ?? Map())['stringValue'],
          ((map['fields'] ?? Map())['id'] ?? Map())['stringValue'],
          ((map['fields'] ?? Map())['name'] ?? Map())['stringValue'],
          int.parse(((map['fields'] ?? Map())['start_dateTime'] ??
              Map())['integerValue']),
          int.parse(((map['fields'] ?? Map())['end_dateTime'] ??
              Map())['integerValue']),
          int.parse(((map['fields'] ?? Map())['mob'] ?? Map())['integerValue']),
          int.parse(
              ((map['fields'] ?? Map())['idproof'] ?? Map())['integerValue']),
          ((map['fields'] ?? Map())['address'] ?? Map())['stringValue'],
          ((map['fields'] ?? Map())['purpose'] ?? Map())['stringValue'],
          ((map['fields'] ?? Map())['facility_1'] ?? Map())['stringValue'],
          ((map['fields'] ?? Map())['facility_2'] ?? Map())['stringValue'],
          ((map['fields'] ?? Map())['facility_3'] ?? Map())['stringValue'],
          int.parse(
              ((map['fields'] ?? Map())['entryTime'] ?? Map())['integerValue']),
          int.parse(
              ((map['fields'] ?? Map())['exitTime'] ?? Map())['integerValue']),
          ((map['fields'] ?? Map())['photoUrl'] ?? Map())['stringValue'],
        );

        return visit;
      } else {
        print("Conference Security Check Map is : ");
        print(json.decode(response.body));
        Utils.docIdConference = "null";
        SecurityCheck_Conference securityCheck;
        securityCheck = null;
        return securityCheck;
      }
    } catch (err) {
      print("Security Check Map is : ");
      print(err);
      Utils.docIdConference = "null";
      SecurityCheck_Conference securityCheck;
      securityCheck = null;
      return securityCheck;
    }
  }

  @override
  Future<void> updateSecurityCheckConference(
      SecurityCheck_Conference securityCheck) {
    return Api.updateConferenceData(securityCheck).then((value) {
      Utils.showToast("Operation done Successfully");
    }).catchError((error) {
      Utils.showToast(Utils.getErrorMessage(error));
    });
  }

  @override
  Stream<List<SecurityCheck_Conference>> securityChecks() {
    throw UnimplementedError();
  }
}
