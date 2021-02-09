import 'package:equatable/equatable.dart';
import 'package:keepapp/seccurityCheck_Conference_repository/lib/securityCheck_Conference_repository.dart';

abstract class SecurityCheckConferenceEvent extends Equatable {
  const SecurityCheckConferenceEvent();

  @override
  List<Object> get props => [];
}

class DocIdCheckConference extends SecurityCheckConferenceEvent {
  final String docIdConference;
  const DocIdCheckConference(this.docIdConference);

  List<Object> get props => [docIdConference];
}

class DocIdCheckUpdatedConference extends SecurityCheckConferenceEvent {
  final SecurityCheck_Conference securityCheck_Conference;

  const DocIdCheckUpdatedConference(this.securityCheck_Conference);

  @override
  List<Object> get props => [securityCheck_Conference];

  String toString() =>
      'DocIdCheckUpdatedConference{ securityCheck_conference : $securityCheck_Conference}';
}

class UpdateSecurityCheckConference extends SecurityCheckConferenceEvent {
  final SecurityCheck_Conference updatedSecurityCheckConference;

  const UpdateSecurityCheckConference(this.updatedSecurityCheckConference);

  @override
  List<Object> get props => [updatedSecurityCheckConference];

  @override
  String toString() =>
      'UpdateSecurityCheckConference { updatedSecurityCheckVisit: $updatedSecurityCheckConference }';
}
