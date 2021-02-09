import 'package:equatable/equatable.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';

abstract class ConferenceEvent extends Equatable {
  const ConferenceEvent();

  @override
  List<Object> get props => [];
}

class Loadconference extends ConferenceEvent {

}

class AddConference extends ConferenceEvent {
  final Conference conference;

  const AddConference(this.conference);

  @override
  List<Object> get props => [conference];

  @override
  String toString() => 'AddConference { conference: $conference }';
}

class UpdateConference extends ConferenceEvent {
  final Conference updatedConference;

  const UpdateConference(this.updatedConference);

  @override
  List<Object> get props => [updatedConference];

  @override
  String toString() => 'UpdateConference { updatedConference: $updatedConference }';
}

class DeleteConference extends ConferenceEvent {
  final Conference conference;

  const DeleteConference(this.conference);

  @override
  List<Object> get props => [conference];

  @override
  String toString() => 'DeleteConference { conference: $conference }';
}

class ClearCompleted extends ConferenceEvent {}

class ToggleAll extends ConferenceEvent {}

class ConferenceUpdated extends ConferenceEvent {
  final List<Conference> conference;

  const ConferenceUpdated(this.conference);

  @override
  List<Object> get props => [conference];
}
