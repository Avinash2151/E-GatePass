import 'dart:async';
import 'dart:convert';
import 'entities/entities.dart';
import '../conference_repository.dart';
import 'package:http/http.dart' as http;
import 'package:keepapp/utils/Utils.dart';
import 'package:keepapp/utils/Exceptions.dart';
import 'package:keepapp/Pass/BookConference/Conference_Api.dart' as Api;

class FirebaseConferenceRepository implements ConferenceRepository {
  String parent =
      "projects/aakarfoundry-6fabe/databases/(default)/documents/conference";

  /// To work on Notes List
  String CONFERENCE_API =
      "https://firestore.googleapis.com/v1/projects/aakarfoundry-6fabe/databases/(default)/documents/conference";

  @override
  Future<void> addNewConference(Conference conference) {
    return Api.addConference(conference).then((value) {
      Utils.showToast("Conference Added Successfully");
    }).catchError((error) {
      Utils.showToast(Utils.getErrorMessage(error));
    });
  }

  @override
  Future<void> deleteConference(Conference conference) async {
    Utils.showToast("Visit deleted Successfully");
    return Api.deleteConference(conference)
        .then((value) {})
        .catchError((error) {
      Utils.showToast(Utils.getErrorMessage(error));
    });
  }

  @override
  Future<List<Conference>> conference() async {
    try {
      var response = await http.get("${CONFERENCE_API}",
          headers: {"Authorization": "Bearer ${Utils.loginToken}"});
      if (response.statusCode == 200) {
        List<Conference> conferenceLists = List();
        Map map = json.decode(response.body);

        List list = map['documents'];
        if (list != null && !list.isEmpty) {
          for (int i = 0; i < list.length; i++) {
            Conference conference = Conference.store(
              map['documents'][i]['name'].toString().replaceAll(parent, ""),
              ((map['documents'][i]['fields'] ?? Map())['status'] ??
                  Map())['stringValue'],
              ((map['documents'][i]['fields'] ?? Map())['id'] ??
                  Map())['stringValue'],
              ((map['documents'][i]['fields'] ?? Map())['name'] ??
                  Map())['stringValue'],
              int.parse(
                  ((map['documents'][i]['fields'] ?? Map())['start_dateTime'] ??
                      Map())['integerValue']),
              int.parse(
                  ((map['documents'][i]['fields'] ?? Map())['end_dateTime'] ??
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
            conferenceLists.add(conference);
          }
        }
        return conferenceLists;
      } else {
        Map map = json.decode(response.body);
        print("error is : $map");
        throw (UserMessageException(map['error']['status']));
      }
    } catch (err) {
      print("exception in conference");
      throw err;
    }
  }

  @override
  Future<void> updateConference(Conference conference) {
    return Api.updateConference(conference).then((value) {
      Utils.showToast("Visit Updated Successfully");
    }).catchError((error) {
      Utils.showToast(Utils.getErrorMessage(error));
    });
  }

  @override
  Stream<List<Conference>> conferences() {
    throw UnimplementedError();
  }
}
