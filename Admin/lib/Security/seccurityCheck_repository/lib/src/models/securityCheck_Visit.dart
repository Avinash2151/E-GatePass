import 'package:flutter/cupertino.dart';
import 'package:keepapp/Security/seccurityCheck_repository/lib/src/entities/entities.dart';
import 'package:meta/meta.dart';

@immutable
class SecurityCheck {
  String doc_id;
  String status;
  String id;
  String name;
  int dateTime;
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
  SecurityCheck(
      {this.doc_id,
      this.status,
      this.id,
      this.name,
      this.dateTime,
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
  SecurityCheck.store(
      this.doc_id,
      this.status,
      this.id,
      this.name,
      this.dateTime,
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

  SecurityCheck copyWith({
    String status,
    String id,
    String name,
    int dateTime,
    int mob,
    int idproof,
    String address,
    String purpose,
    String facility_1,
    String facility_2,
    String facility_3,
    int entryTime,
  }) {
    return SecurityCheck(
        status: status ?? this.status,
        id: id ?? this.id,
        name: name ?? this.name,
        dateTime: dateTime ?? this.dateTime,
        mob: mob ?? this.mob,
        idproof: idproof ?? this.idproof,
        address: address ?? this.address,
        purpose: purpose ?? this.purpose,
        facility_1: facility_1 ?? this.facility_1,
        facility_2: facility_2 ?? this.facility_2,
        facility_3: facility_3 ?? this.facility_3,
        entryTime: entryTime ?? this.entryTime);
  }

  @override
  int get hashCode =>
      status.hashCode ^
      name.hashCode ^
      dateTime.hashCode ^
      id.hashCode ^
      mob.hashCode ^
      idproof.hashCode ^
      address.hashCode ^
      purpose.hashCode ^
      facility_1.hashCode ^
      facility_2.hashCode ^
      facility_3.hashCode ^
      entryTime.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecurityCheck &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          id == other.id &&
          name == other.name &&
          dateTime == other.dateTime &&
          mob == other.mob &&
          idproof == other.idproof &&
          address == other.address &&
          purpose == other.purpose &&
          facility_1 == other.facility_1 &&
          facility_2 == other.facility_2 &&
          facility_3 == other.facility_3 &&
          entryTime == other.entryTime;
  @override
  String toString() {
    return 'Visit{status: $status,id : $id , name : $name, dateTime: $dateTime, mob: $mob, '
        'idproof: $idproof,address: $address, purpose : $purpose, facility_1 : $facility_1,'
        ' facility_2 : $facility_2, facility_3 : $facility_3, entryTime : $entryTime, exitTime: $exitTime, photoUrl: $photoUrl}';
  }

  SecurityCheckEntity toEntity() {
    return SecurityCheckEntity(status, id, name, dateTime, mob, idproof,
        address, purpose, facility_1, facility_2, facility_3, entryTime);
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "id": id,
      "name": name,
      "dateTime": dateTime,
      "mob": mob,
      "idproof": idproof,
      "address": address,
      "purpose": purpose,
      "facility_1": facility_1,
      "facility_2": facility_2,
      "facility_3": facility_3,
      "entryTime": entryTime
    };
  }

  factory SecurityCheck.fromJson(Map<String, dynamic> json) {
    return SecurityCheck(
        doc_id: json["name"] as String,
        status: json["status"] as String,
        name: json["name"] as String,
        dateTime: json["dateTime"] as int,
        mob: json["mob"] as int,
        idproof: json["idproof"] as int,
        address: json["address"] as String,
        purpose: json["purpose"] as String,
        facility_1: json["facility_1"] as String,
        facility_2: json["facility_2"] as String,
        facility_3: json["facility_3"] as String,
        entryTime: json["entryTime"] as int);
  }
  static SecurityCheck fromEntity(SecurityCheck entity) {
    return SecurityCheck(
      status: entity.status,
      id: entity.id,
      name: entity.name,
      dateTime: entity.dateTime,
      mob: entity.mob,
      idproof: entity.idproof,
      address: entity.address,
      purpose: entity.purpose,
      facility_1: entity.facility_1,
      facility_2: entity.facility_2,
      facility_3: entity.facility_3,
      entryTime: entity.entryTime,
    );
  }
}
