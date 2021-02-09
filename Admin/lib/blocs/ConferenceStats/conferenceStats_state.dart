import 'package:equatable/equatable.dart';

abstract class ConferenceStatsState extends Equatable {
  const ConferenceStatsState();

  @override
  List<Object> get props => [];
}

class ConferenceStatsLoading extends ConferenceStatsState {}

class ConferenceStatsLoaded extends ConferenceStatsState {
  final int conferenceNumActive;
  final int conferenceNumCompleted;
  final int conferenceNumPending;
  const ConferenceStatsLoaded(this.conferenceNumActive,
      this.conferenceNumCompleted, this.conferenceNumPending);

  @override
  List<Object> get props =>
      [conferenceNumActive, conferenceNumCompleted, conferenceNumPending];

  @override
  String toString() {
    return 'ConferenceStatsLoaded { conferenceNumCompleted: $conferenceNumActive, conferenceNumCompleted: $conferenceNumCompleted, conferenceNumPending: $conferenceNumPending}';
  }
}
