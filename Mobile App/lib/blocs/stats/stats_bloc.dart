import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:keepapp/Pass/BookConference/bloc/Conference.dart';
import 'package:keepapp/Pass/BookVisit/bloc/Visit.dart';
import 'package:keepapp/blocs/stats/stats.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StreamSubscription _visitSubscription;
  StreamSubscription _conferenceSubcription;
  StatsBloc({VisitBloc visitBloc, ConferenceBloc conferenceBloc})
      : assert(visitBloc != null),
        assert(conferenceBloc != null) {
    _visitSubscription = visitBloc.listen((state) {
      if (state is VisitLoaded) {
        add(UpdateStats_Visit(state.visit));
      }
    });
    _conferenceSubcription = conferenceBloc.listen((state) {
      if (state is ConferenceLoaded) {
        add(UpdateStats_Conference(state.conference));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats_Visit) {
      int numActive =
          event.visit.where((visit) => visit.status == "req").toList().length;
      int numCompleted = event.visit
          .where((visit) => visit.status == "complete")
          .toList()
          .length;
      numActive = numActive != null ? numActive : 0;
      numCompleted = numCompleted != null ? numCompleted : 0;
// String personName=name.first;
      yield VisitStatsLoaded(numActive, numCompleted);
    }
    if (event is UpdateStats_Conference) {
      int numActive = event.conference
          .where((conference) => conference.status == "req")
          .toList()
          .length;
      int numCompleted = event.conference
          .where((conferece) => conferece.status == "complete")
          .toList()
          .length;

      numActive = numActive != null ? numActive : 0;
      numCompleted = numCompleted != null ? numCompleted : 0;
      print("conference stats");
      print(numActive);
      print(numCompleted);
      yield ConferenceStatsLoaded(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    _visitSubscription?.cancel();
    return super.close();
  }
}
