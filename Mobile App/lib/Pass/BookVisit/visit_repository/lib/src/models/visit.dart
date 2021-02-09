import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Visit {
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

  Visit(
      {
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
      this.facility_3});
  Visit.store(
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
      this.facility_3);
  Visit copyWith(
      {String status,
      String id,
      String name,
      int dateTime,
      int mob,
      int idproof,
      String address,
      String purpose,
      String facility_1,
      String facility_2,
      String facility_3}) {
    return Visit(
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
    );
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
      facility_3.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Visit &&
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
          facility_3 == other.facility_3;
  @override
  String toString() {
    return 'Visit{status: $status,id : $id , name : $name, dateTime: $dateTime, mob: $mob, '
        'idproof: $idproof,address: $address, purpose : $purpose, facility_1 : $facility_1,'
        ' facility_2 : $facility_2, facility_3 : $facility_3}';
  }

  VisitEntity toEntity() {
    return VisitEntity(
        status, id, name, dateTime, mob, idproof, address, purpose, facility_1,facility_2,facility_3);
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
    };
  }

  static Visit fromEntity(VisitEntity entity) {
    return Visit(
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
        facility_3: entity.facility_3
    );
  }
}
