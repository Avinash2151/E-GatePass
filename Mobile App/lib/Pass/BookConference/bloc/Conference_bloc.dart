import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:keepapp/Pass/BookConference/bloc/Conference.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
import 'package:meta/meta.dart';

class ConferenceBloc extends Bloc<ConferenceEvent, ConferenceState> {
  final ConferenceRepository _ConferenceRepository;
  StreamSubscription _ConferenceSubscription;

  ConferenceBloc(
      {@required ConferenceRepository ConferenceRepository,
      ConferenceBloc conferenceBloc})
      : assert(ConferenceRepository != null),
        _ConferenceRepository = ConferenceRepository;

  @override
  ConferenceState get initialState => ConferenceLoading();

  @override
  Stream<ConferenceState> mapEventToState(ConferenceEvent event) async* {
    if (event is Loadconference) {
      yield* _mapLoadConferenceToState();
    } else if (event is AddConference) {
      yield* _mapAddConferenceToState(event);
    } else if (event is UpdateConference) {
      yield* _mapUpdateConferenceToState(event);
    } else if (event is DeleteConference) {
      yield* _mapDeleteConferenceToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if (event is ConferenceUpdated) {
      yield* _mapConferenceUpdateToState(event);
    }
  }

  Stream<ConferenceState> _mapLoadConferenceToState() async* {
    _ConferenceSubscription?.cancel();
    _ConferenceSubscription =
        _ConferenceRepository.conference().asStream().listen(
              (Conference) => add(ConferenceUpdated(Conference)),
            );
  }

  Stream<ConferenceState> _mapAddConferenceToState(AddConference event) async* {
    _ConferenceRepository.addNewConference(event.conference);
  }

  Stream<ConferenceState> _mapUpdateConferenceToState(
      UpdateConference event) async* {
    _ConferenceRepository.updateConference(event.updatedConference);
  }

  Stream<ConferenceState> _mapDeleteConferenceToState(
      DeleteConference event) async* {
    _ConferenceRepository.deleteConference(event.conference);
  }

  Stream<ConferenceState> _mapToggleAllToState() async* {
    final currentState = state;
    if (currentState is ConferenceLoaded) {
      //final allcomplete =currentState.conference.map((conference) => conference.status == "req") as String;
      final allComplete = currentState.conference
          .every((conference) => conference.status == "req");
      final List<Conference> updatedConference = currentState.conference
          .map((conference) =>
              conference.copyWith(status: allComplete.toString()))
          .toList();
      updatedConference.forEach((updatedConference) {
        _ConferenceRepository.updateConference(updatedConference);
      });
    }
  }

  Stream<ConferenceState> _mapClearCompletedToState() async* {
    final currentState = state;
    if (currentState is ConferenceLoaded) {
      final List<Conference> completedConference = currentState.conference
          .where((conference) => conference.status == "req")
          .toList();
      completedConference.forEach((completedConference) {
        _ConferenceRepository.deleteConference(completedConference);
      });
    }
  }

  Stream<ConferenceState> _mapConferenceUpdateToState(
      ConferenceUpdated event) async* {
    yield ConferenceLoaded(event.conference);
  }

  @override
  Future<void> close() {
    _ConferenceSubscription?.cancel();
    return super.close();
  }
}
