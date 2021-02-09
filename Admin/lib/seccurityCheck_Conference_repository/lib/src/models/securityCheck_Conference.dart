import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:keepapp/seccurityCheck_Conference_repository/lib/src/entities/entities.dart';
import 'package:meta/meta.dart';

@immutable
class SecurityCheck_Conference {
  String doc_id;
  String status;
  String id;
  String name;
  int startTime;
  int endTime;
  int mob;
  int idproof;
  String address;
  String purpose;
  String facility_1;
  String facility_2;
  String facility_3;
  int entryTime;
  int exitTime;
  String photoUrl;
  SecurityCheck_Conference(
      {this.doc_id,
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
      this.photoUrl});
  SecurityCheck_Conference.store(
      this.doc_id,
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

  SecurityCheck_Conference copyWith({
    String status,
    String id,
    String name,
    int startTime,
    int endTime,
    int mob,
    int idproof,
    String address,
    String purpose,
    String facility_1,
    String facility_2,
    String facility_3,
    int entryTime,
    int exitTime,
    String photoUrl,
  }) {
    return SecurityCheck_Conference(
      status: status ?? this.status,
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      mob: mob ?? this.mob,
      idproof: idproof ?? this.idproof,
      address: address ?? this.address,
      purpose: purpose ?? this.purpose,
      facility_1: facility_1 ?? this.facility_1,
      facility_2: facility_2 ?? this.facility_2,
      facility_3: facility_3 ?? this.facility_3,
      entryTime: entryTime ?? this.entryTime,
      exitTime: exitTime ?? this.exitTime,
      photoUrl: photoUrl ?? photoUrl,
    );
  }

  @override
  int get hashCode =>
      status.hashCode ^
      name.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      id.hashCode ^
      mob.hashCode ^
      idproof.hashCode ^
      address.hashCode ^
      purpose.hashCode ^
      facility_1.hashCode ^
      facility_2.hashCode ^
      facility_3.hashCode ^
      entryTime.hashCode ^
      exitTime.hashCode ^
      photoUrl.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecurityCheck_Conference &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          id == other.id &&
          name == other.name &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          mob == other.mob &&
          idproof == other.idproof &&
          address == other.address &&
          purpose == other.purpose &&
          facility_1 == other.facility_1 &&
          facility_2 == other.facility_2 &&
          facility_3 == other.facility_3 &&
          entryTime == other.entryTime &&
          exitTime == other.exitTime &&
          photoUrl == other.photoUrl;
  @override
  String toString() {
    return 'Conference{status: $status,id : $id , name : $name, startTime: $startTime, endTime : $endTime mob: $mob, '
        'idproof: $idproof,address: $address, purpose : $purpose, facility_1 : $facility_1,'
        ' facility_2 : $facility_2, facility_3 : $facility_3, entryTime : $entryTime, exitTime: $exitTime, photoUrl: $photoUrl}';
  }

  SecurityCheckConferenceEntity toEntity() {
    return SecurityCheckConferenceEntity(
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
        photoUrl);
  }

  Map<String, dynamic> toJson() {
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

  factory SecurityCheck_Conference.fromJson(Map<String, dynamic> json) {
    return SecurityCheck_Conference(
      doc_id: json["name"] as String,
      status: json["status"] as String,
      name: json["name"] as String,
      startTime: json["startTime"] as int,
      endTime: json["endTime"] as int,
      mob: json["mob"] as int,
      idproof: json["idproof"] as int,
      address: json["address"] as String,
      purpose: json["purpose"] as String,
      facility_1: json["facility_1"] as String,
      facility_2: json["facility_2"] as String,
      facility_3: json["facility_3"] as String,
      entryTime: json["entryTime"] as int,
      exitTime: json["exitTime"] as int,
      photoUrl: json["photoUrl"] as String,
    );
  }
  static SecurityCheck_Conference fromEntity(SecurityCheck_Conference entity) {
    return SecurityCheck_Conference(
        status: entity.status,
        id: entity.id,
        name: entity.name,
        startTime: entity.startTime,
        endTime: entity.endTime,
        mob: entity.mob,
        idproof: entity.idproof,
        address: entity.address,
        purpose: entity.purpose,
        facility_1: entity.facility_1,
        facility_2: entity.facility_2,
        facility_3: entity.facility_3,
        entryTime: entity.entryTime,
        exitTime: entity.exitTime,
        photoUrl: entity.photoUrl);
  }
}
