import 'dart:async';

import '../conference_repository.dart';

abstract class ConferenceRepository {
  Future<void> addNewConference(Conference conference);

  Future<void> deleteConference(Conference conference);

  Future<List<Conference>> conference();

  Future<void> updateConference(Conference conference);
}
