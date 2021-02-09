import 'package:equatable/equatable.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';

abstract class ConferenceStatsEvent extends Equatable {
  const ConferenceStatsEvent();
}

class UpdateStats_Conference extends ConferenceStatsEvent {
  final List<Conference> conference;

  const UpdateStats_Conference(this.conference);

  @override
  List<Object> get props => [conference];

  @override
  String toString() => 'UpdateStats_Conference { conference: $conference }';
}
