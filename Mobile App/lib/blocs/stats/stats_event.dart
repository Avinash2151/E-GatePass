import 'package:equatable/equatable.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class UpdateStats_Visit extends StatsEvent {
  final List<Visit> visit;

  const UpdateStats_Visit(this.visit);

  @override
  List<Object> get props => [visit];

  @override
  String toString() => 'UpdateStats_Visit { visit: $visit}';
}

class UpdateStats_Conference extends StatsEvent {
  final List<Conference> conference;

  const UpdateStats_Conference(this.conference);

  @override
  List<Object> get props => [conference];

  @override
  String toString() => 'UpdateStats_Conference { conference: $conference }';
}
