import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
import 'package:keepapp/filtered_conference/filtered_conference.dart';
import 'package:keepapp/Pass/BookConference/bloc/Conference.dart';
import 'package:keepapp/models/models.dart';

//import 'filtered_visit_event.dart';
class FilteredConferenceBloc
    extends Bloc<FilteredConferenceEvent, FilteredConferenceState> {
  final ConferenceBloc _conferenceBloc;
  StreamSubscription _conferenceSubscription;

  FilteredConferenceBloc({@required ConferenceBloc conferenceBloc})
      : assert(conferenceBloc != null),
        _conferenceBloc = conferenceBloc {
    _conferenceSubscription = conferenceBloc.listen((state) {
      if (state is ConferenceLoaded) {
        add(UpdateConferences(
            (conferenceBloc.state as ConferenceLoaded).conference));
      }
    });
  }

  @override
  FilteredConferenceState get initialState {
    final currentState = _conferenceBloc.state;
    return currentState is ConferenceLoaded
        ? FilteredConferenceLoaded(
            currentState.conference, VisibilityFilter.all)
        : FilteredConferenceLoading();
  }

  @override
  Stream<FilteredConferenceState> mapEventToState(
      FilteredConferenceEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateConferences) {
      yield* _mapConferenceUpdatedToState(event);
    }
  }

  Stream<FilteredConferenceState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    final currentState = _conferenceBloc.state;
    if (currentState is ConferenceLoaded) {
      yield FilteredConferenceLoaded(
        _mapConferenceToFilteredConference(
            currentState.conference, event.filter),
        event.filter,
      );
    }
  }

  Stream<FilteredConferenceState> _mapConferenceUpdatedToState(
    UpdateConferences event,
  ) async* {
    final visibilityFilter = state is FilteredConferenceLoaded
        ? (state as FilteredConferenceLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredConferenceLoaded(
      _mapConferenceToFilteredConference(
        (_conferenceBloc.state as ConferenceLoaded).conference,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Conference> _mapConferenceToFilteredConference(
      List<Conference> conference, VisibilityFilter filter) {
    return conference.where((conference) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return conference.status == "req";
      } else {
        return conference.status == "complete";
      }
    }).toList();
  }

  @override
  Future<void> close() {
    _conferenceSubscription?.cancel();
    return super.close();
  }
}
