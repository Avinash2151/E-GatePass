import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../visit_repository.dart';
import 'package:keepapp/utils/Utils.dart';
import 'package:keepapp/utils/Api.dart' as Api;
import 'package:http/http.dart' as http;
import 'package:keepapp/utils/Exceptions.dart';

class FirebaseVisitRepository extends ChangeNotifier
    implements VisitRepository {

  String parent =
      "projects/aakarfoundry-6fabe/databases/(default)/documents/visits";

  /// To work on Notes List
  String VISIT_API =
      "https://firestore.googleapis.com/v1/projects/aakarfoundry-6fabe/databases/(default)/documents/visits";
  List<Visit> visitList = List();
  String errorMsg;
  @override
  Future<void> addNewVisit(Visit visit) async {
    return Api.addNote(visit).then((value) {
      Utils.showToast("Visit Added Successfully");
    }).catchError((error) {
      Utils.showToast(Utils.getErrorMessage(error));
    });
    //return visitCollection.add(visit.toEntity().toDocument());
  }

  @override
  Future<void> deleteVisit(Visit visit) async {
    Utils.showToast("Visit deleted Successfully");
    return Api.deleteVisit(visit).then((value) {}).catchError((error) {
      Utils.showToast(Utils.getErrorMessage(error));
    });
  }

  @override
  Future<List<Visit>> visit() async {
    try {
      var response = await http.get("${VISIT_API}",
          headers: {"Authorization": "Bearer ${Utils.loginToken}"});
      if (response.statusCode == 200) {
        List<Visit> visitLists = List();
        Map map = json.decode(response.body);

        List list = map['documents'];
        if (list != null && !list.isEmpty) {
          for (int i = 0; i < list.length; i++) {
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
            visitLists.add(visit);
          }
        }
        return visitLists;
      } else {
        Map map = json.decode(response.body);
        throw (UserMessageException(map['error']['status']));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future<void> updateVisit(Visit visit) {
    return Api.updateData(visit).then((value) {
      Utils.showToast("Visit Updated Successfully");
    }).catchError((error) {
      Utils.showToast(Utils.getErrorMessage(error));
    });
//    return visitCollection
//        .document(update.id)
//        .updateData(update.toEntity().toDocument());
  }

  @override
  Stream<List<Visit>> visits() {
    throw UnimplementedError();
  }
}
