import 'package:equatable/equatable.dart';
import 'package:keepapp/seccurityCheck_Conference_repository/lib/securityCheck_Conference_repository.dart';

abstract class SecurityCheckConferenceState extends Equatable {
  const SecurityCheckConferenceState();

  @override
  List<Object> get props => [];
}

///Conference
class SecurityCheckLoadingConference extends SecurityCheckConferenceState {}

class DocIDCheckLoadedConference extends SecurityCheckConferenceState {
  final SecurityCheck_Conference securityCheck;

  const DocIDCheckLoadedConference([this.securityCheck]);

  @override
  List<Object> get props => [securityCheck];

  @override
  String toString() =>
      'DocIDCheckLoadedConference { SecurityCheck: $securityCheck }';
}

class SecurityCheckNotLoadedConference extends SecurityCheckConferenceState {
  final String error;

  const SecurityCheckNotLoadedConference(this.error);

  List<Object> get props => [error];

  String toString() => 'SecurityCheckNotLoadedConference { error : $error}';
}
