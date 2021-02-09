import 'package:equatable/equatable.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/src/models/models.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];
}

class StatsLoading extends StatsState {}

class VisitStatsLoaded extends StatsState {
  final int numActive;
  final int numCompleted;
//  final String name;
  const VisitStatsLoaded(
    this.numActive,
    this.numCompleted,
  );

  @override
  List<Object> get props => [
        numActive,
        numCompleted,
      ];

  @override
  String toString() {
    return 'VisitStatsLoaded { numActive: $numActive, numCompleted: $numCompleted}';
  }
}

class ConferenceStatsLoaded extends StatsState {
  final int conference_numActive;
  final int conference_numCompleted;
//  final String name;
  const ConferenceStatsLoaded(
    this.conference_numActive,
    this.conference_numCompleted,
  );

  @override
  List<Object> get props => [conference_numActive, conference_numCompleted];

  @override
  String toString() {
    return 'VisitStatsLoaded { conference_numCompleted: $conference_numActive, conference_numCompleted: $conference_numCompleted,}';
  }
}
