import 'dart:async';
import '../securityCheck_repository.dart';

abstract class SecurityCheckRepository {
  ///visit
  Future<SecurityCheck> securityCheck(String docID);
  Future<void> updateSecurityCheckVisit(SecurityCheck visit);
}
