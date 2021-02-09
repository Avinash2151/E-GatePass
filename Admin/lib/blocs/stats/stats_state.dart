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
  final int numPending;
  const VisitStatsLoaded(this.numActive, this.numCompleted, this.numPending);

  @override
  List<Object> get props => [numActive, numCompleted, numPending];

  @override
  String toString() {
    return 'VisitStatsLoaded { numActive: $numActive, numCompleted: $numCompleted, numPending: $numPending}';
  }
}
