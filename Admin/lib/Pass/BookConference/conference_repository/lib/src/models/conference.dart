import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Conference {
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
  Conference({
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
    this.doc_id,
  });
  Conference.store(
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
      this.facility_3);
  Conference copyWith({
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
  }) {
    return Conference(
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
    );
  }

  @override
  int get hashCode =>
      status.hashCode ^
      name.hashCode ^
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
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
      other is Conference &&
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
          facility_3 == other.facility_3;
  @override
  String toString() {
    return 'Conference{status: $status,id : $id , name : $name, startTime: $startTime , endTime: $endTime, mob: $mob, '
        'idproof: $idproof,address: $address, purpose : $purpose, facility_1 : $facility_1, facility_2 : $facility_2, facility_3 : $facility_3}';
  }

  ConferenceEntity toEntity() {
    return ConferenceEntity(status, id, name, startTime, endTime, mob, idproof,
        address, purpose, facility_1, facility_2, facility_3);
  }

  static Conference fromEntity(ConferenceEntity entity) {
    return Conference(
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
    );
  }
}
