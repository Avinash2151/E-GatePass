import 'package:equatable/equatable.dart';
import 'package:keepapp/Security/seccurityCheck_repository/lib/securityCheck_repository.dart';

abstract class SecurityCheckEvent extends Equatable {
  const SecurityCheckEvent();

  @override
  List<Object> get props => [];
}

class DocIdCheck extends SecurityCheckEvent {
  final String docID;
  const DocIdCheck(this.docID);

  List<Object> get props => [docID];
}

class DocIdCheckUpdated extends SecurityCheckEvent {
  final SecurityCheck securityCheck;

  const DocIdCheckUpdated(this.securityCheck);

  @override
  List<Object> get props => [securityCheck];
}

class UpdateSecurityCheckVisit extends SecurityCheckEvent {
  final SecurityCheck updatedSecurityCheckVisit;

  const UpdateSecurityCheckVisit(this.updatedSecurityCheckVisit);

  @override
  List<Object> get props => [updatedSecurityCheckVisit];

  @override
  String toString() =>
      'UpdateSecurityCheckVisit { updatedSecurityCheckVisit: $updatedSecurityCheckVisit }';
}
