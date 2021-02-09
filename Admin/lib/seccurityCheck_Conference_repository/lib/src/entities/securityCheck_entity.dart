import 'package:equatable/equatable.dart';

class SecurityCheckConferenceEntity extends Equatable {
  final String status;
  final String id;
  final String name;
  final int startTime;
  final int endTime;
  final int mob;
  final int idproof;
  final String address;
  final String purpose;
  final String facility_1;
  final String facility_2;
  final String facility_3;
  final int entryTime;
  final int exitTime;
  final String photoUrl;
  const SecurityCheckConferenceEntity(
      this.status,
      this.id,
      this.name,
      this.startTime,
      this.endTime,
      this.mob,
      this.idproof,
      this.address,
      this.purpose,
      this.facility_1,
      this.facility_2,
      this.facility_3,
      this.entryTime,
      this.exitTime,
      this.photoUrl);

  Map<dynamic, Object> toJson() {
    return {
      "status": status,
      "id": id,
      "name": name,
      "startTime": startTime,
      "endTime": endTime,
      "mob": mob,
      "idproof": idproof,
      "address": address,
      "purpose": purpose,
      "facility_1": facility_1,
      "facility_2": facility_2,
      "facility_3": facility_3,
      "entryTime": entryTime,
      "exitTime": exitTime,
      "photoUrl": photoUrl
    };
  }

  @override
  List<Object> get props => [
        status,
        id,
        name,
        startTime,
        endTime,
        mob,
        idproof,
        address,
        purpose,
        facility_1,
        facility_2,
        facility_3,
        entryTime,
        exitTime,
        photoUrl
      ];

  @override
  String toString() {
    return 'VisitEntity {status: $status, id: $id,  name: $name, StartTime: $startTime, endTime: $endTime mob :$mob, idproof : $idproof, address:$address'
        'purpose :$purpose, facility_1: $facility_1, facility_2: $facility_2, facility_3: $facility_3,entryTime : $entryTime,exitTime :$exitTime, photoUrl: $photoUrl }';
  }

  static SecurityCheckConferenceEntity fromJson(Map<String, Object> json) {
    return SecurityCheckConferenceEntity(
        json["status"] as String,
        json["id"] as String,
        json["name"] as String,
        json["startTime"] as int,
        json["endTime"] as int,
        json["mob"] as int,
        json["idproof"] as int,
        json["address"] as String,
        json["purpose"] as String,
        json["facility_1"] as String,
        json["facility_2"] as String,
        json["facility_3"] as String,
        json["entryTime"] as int,
        json["exitTime"] as int,
        json["photoUrl"] as String);
  }

  Map<String, dynamic> toDocument() {
    return {
      "status": status,
      "id": id.toString(),
      "name": name,
      "startTime": startTime,
      "endTime": endTime,
      "mob": mob.toString(),
      "idproof": idproof.toString(),
      "address": address,
      "purpose": purpose,
      "facility_1": facility_1,
      "facility_2": facility_2,
      "facility_3": facility_3,
      "entryTime": entryTime,
      "exitTime": exitTime,
      "photoUrl": photoUrl
      //List<dynamic>.from(facility.map((x) => x)),
    };
  }
}
