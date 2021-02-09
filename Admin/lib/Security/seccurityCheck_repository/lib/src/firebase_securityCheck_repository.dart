import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../securityCheck_repository.dart';
import 'package:keepapp/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:keepapp/Security/SecurityCheck/securityCheckApi.dart' as Api;

class FirebaseSecurityCheckRepository extends ChangeNotifier
    implements SecurityCheckRepository {
  String parent =
      "projects/aakarfoundry-6fabe/databases/(default)/documents/visits";

  String filteredVisitApi =
      "https://firestore.googleapis.com/v1/projects/aakarfoundry-6fabe/databases/(default)/documents/visits/";

  String errorMsg;

  @override
  Future<SecurityCheck> securityCheck(String docID) async {
    String getString = "$filteredVisitApi" + Utils.docID;

    try {
      var response = await http.get("${getString}",
          headers: {"Authorization": "Bearer ${Utils.loginToken}"});

      if (response.statusCode == 200) {
        print("security Check reponse body ");
        print(json.decode(response.body));

        Map map = json.decode(response.body);
        SecurityCheck visit = SecurityCheck.store(
          map['name'].toString().replaceAll(parent, ""),
          ((map['fields'] ?? Map())['status'] ?? Map())['stringValue'],
          ((map['fields'] ?? Map())['id'] ?? Map())['stringValue'],
          ((map['fields'] ?? Map())['name'] ?? Map())['stringValue'],
          int.parse(
              ((map['fields'] ?? Map())['dateTime'] ?? Map())['integerValue']),
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
        print("Visit Security Check Map is : ");
        print(json.decode(response.body));
        Utils.docID = "null";
        SecurityCheck securityCheck;
        securityCheck = null;
        return securityCheck;
      }
    } catch (err) {
      print("Security Check Map is : ");
      print(err);
      Utils.docID = "null";
      SecurityCheck securityCheck;
      securityCheck = null;
      return securityCheck;
    }
  }

  @override
  Future<void> updateSecurityCheckVisit(SecurityCheck securityCheck) {
    return Api.updateData(securityCheck).then((value) {
      Utils.showToast("Operation done Successfully");
    }).catchError((error) {
      Utils.showToast(Utils.getErrorMessage(error));
    });
  }

  Stream<List<SecurityCheck>> securityChecks() {
    throw UnimplementedError();
  }
}
