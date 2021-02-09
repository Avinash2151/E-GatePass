import 'package:equatable/equatable.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
abstract class ConferenceState extends Equatable {
  const ConferenceState();

  @override
  List<Object> get props => [];
}

class ConferenceLoading extends ConferenceState {}

class ConferenceLoaded extends ConferenceState {
  final List<Conference> conference;

  const ConferenceLoaded([this.conference = const []]);

  @override
  List<Object> get props => [conference];

  @override
  String toString() => 'ConferenceLoaded { Conference: $conference }';
}


class ConferenceNotLoaded extends ConferenceState {}
