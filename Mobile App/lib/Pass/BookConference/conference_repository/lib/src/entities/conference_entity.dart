
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ConferenceEntity extends Equatable {
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

  const ConferenceEntity(
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
      this.facility_3);

  Map<String, Object> toJson() {
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
        facility_3
      ];

  @override
  String toString() {
    return 'ConferenceEntity {status: $status, id: $id,  name: $name, startTime :$startTime, endTime : $endTime mob :$mob, idproof : $idproof, address:$address'
        'purpose :$purpose, facility_1: $facility_1, facility_2: $facility_2, facility_3: $facility_3 }';
  }

  static ConferenceEntity fromJson(Map<String, Object> json) {
    return ConferenceEntity(
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
    );
  }


  Map<String, Object> toDocument() {
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
      "facility_3": facility_3
    };
  }
}
