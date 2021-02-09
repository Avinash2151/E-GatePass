import 'package:equatable/equatable.dart';

class SecurityCheckEntity extends Equatable {
  final String status;
  final String id;
  final String name;
  final int dateTime;
  final int mob;
  final int idproof;
  final String address;
  final String purpose;
  final String facility_1;
  final String facility_2;
  final String facility_3;
  final int entryTime;
  const SecurityCheckEntity(
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
      this.entryTime);

  Map<dynamic, Object> toJson() {
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

  @override
  List<Object> get props => [
        status,
        id,
        name,
        dateTime,
        mob,
        idproof,
        address,
        purpose,
        facility_1,
        facility_2,
        facility_3,
        entryTime
      ];

  @override
  String toString() {
    return 'VisitEntity {status: $status, id: $id,  name: $name, dateTime: $dateTime, mob :$mob, idproof : $idproof, address:$address'
        'purpose :$purpose, facility_1: $facility_1, facility_2: $facility_2, facility_3: $facility_3,entryTime : $entryTime }';
  }

  static SecurityCheckEntity fromJson(Map<String, Object> json) {
    return SecurityCheckEntity(
        json["status"] as String,
        json["id"] as String,
        json["name"] as String,
        json["dateTime"] as int,
        json["mob"] as int,
        json["idproof"] as int,
        json["address"] as String,
        json["purpose"] as String,
        json["facility_1"] as String,
        json["facility_2"] as String,
        json["facility_3"] as String,
        json["entryTime"] as int,
        );
  }

  Map<String, dynamic> toDocument() {
    return {
      "status": status,
      "id": id.toString(),
      "name": name,
      "dateTime": dateTime,
      "mob": mob.toString(),
      "idproof": idproof.toString(),
      "address": address,
      "purpose": purpose,
      "facility_1": facility_1,
      "facility_2": facility_2,
      "facility_3": facility_3,
      "entryTime" : entryTime
      //List<dynamic>.from(facility.map((x) => x)),
    };
  }
}
