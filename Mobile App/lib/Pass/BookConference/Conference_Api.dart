import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/src/models/models.dart';
import 'package:keepapp/utils/AppConstants.dart';
import 'package:keepapp/utils/Exceptions.dart';
import 'package:keepapp/utils/Utils.dart';

String parent =
    "projects/aakarfoundry-6fabe/databases/(default)/documents/conference";

/// To work on Notes List
String CONFERENCE_API =
    "https://firestore.googleapis.com/v1/projects/aakarfoundry-6fabe/databases/(default)/documents/conference";

/// return List of notes of user
Future<List<Conference>> getConference() async {
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
    throw err;
  }
}

/// return add new note [noteModel]
Future<bool> addConference(Conference conference) async {
  List<String> list = ["Avi", "Mawle"];
  try {
    var response = await http.post(
      "${CONFERENCE_API}",
      headers:
          //{"Content-Type": "application/json"},
          {"Authorization": "Bearer ${Utils.loginToken}"},
      body: json.encode(
        {
          "fields": {
            "status": {"stringValue": conference.status},
            "id": {"stringValue": conference.id},
            "name": {"stringValue": conference.name},
            "start_dateTime": {"integerValue": conference.startTime},
            "end_dateTime": {"integerValue": conference.endTime},
            "mob": {"integerValue": conference.mob},
            "idproof": {"integerValue": conference.idproof},
            "address": {"stringValue": conference.address},
            "purpose ": {"stringValue": conference.purpose},
            // "facility": {"arrayValue": { "values": [ {"stringValue": list }]}},
            "facility_1": {
              "stringValue": conference.facility_1 != null
                  ? conference.facility_1
                  : "not needed"
            },
            "facility_2": {
              "stringValue": conference.facility_2 != null
                  ? conference.facility_2
                  : "not needed"
            },
            "facility_3": {
              "stringValue": conference.facility_3 != null
                  ? conference.facility_3
                  : "not needed"
            },
          }
        },
      ),
    );
    if (response.statusCode == 200) {
      print("Conference added");
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
Future<bool> updateConference(Conference conference) async {
  String updateApi = "$CONFERENCE_API" + conference.doc_id;

  try {
    var response = await http.patch(
      updateApi,
      headers: {"Authorization": "Bearer ${Utils.loginToken}"},
      body: json.encode(
        {
          "fields": {
            "status": {"stringValue": conference.status},
            "id": {"stringValue": conference.id},
            "name": {"stringValue": conference.name},
            "start_dateTime": {"integerValue": conference.startTime},
            "end_dateTime": {"integerValue": conference.endTime},
            "mob": {"integerValue": conference.mob},
            "idproof": {"integerValue": conference.idproof},
            "address": {"stringValue": conference.address},
            "purpose ": {"stringValue": conference.purpose},
            // "facility": {"arrayValue": { "values": [ {"stringValue": list }]}},
            "facility_1": {
              "stringValue": conference.facility_1 != null
                  ? conference.facility_1
                  : "not needed"
            },
            "facility_2": {
              "stringValue": conference.facility_2 != null
                  ? conference.facility_2
                  : "not needed"
            },
            "facility_3": {
              "stringValue": conference.facility_3 != null
                  ? conference.facility_3
                  : "not needed"
            },
          }
        },
      ),
    );
    if (response.statusCode == 200) {
      print("Conference updated");
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
Future<bool> deleteConference(Conference conference) async {
  try {
    var response = await http.delete(
      "${CONFERENCE_API}${conference.doc_id}",
      headers: {"Authorization": "Bearer ${Utils.loginToken}"},
    );
    if (response.statusCode == 200) {
      return true;
    }
  } catch (err) {
    throw err;
  }
}
