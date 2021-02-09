import 'dart:async';
import '../securityCheck_Conference_repository.dart';

abstract class SecurityCheckConferenceRepository {
  ///conference
  Future<SecurityCheck_Conference> securityCheckConference(String docID);
  Future<void> updateSecurityCheckConference(
      SecurityCheck_Conference conference);
}
