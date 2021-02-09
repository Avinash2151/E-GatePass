import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:keepapp/Pass/BookConference/bloc/Conference.dart';
import 'package:keepapp/Pass/BookVisit/bloc/Visit.dart';
import 'package:keepapp/blocs/stats/stats.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StreamSubscription _visitSubscription;
  StatsBloc({VisitBloc visitBloc}) : assert(visitBloc != null) {
    _visitSubscription = visitBloc.listen((state) {
      if (state is VisitLoaded) {
        add(UpdateStats_Visit(state.visit));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats_Visit) {
      int numActive = event.visit
          .where((visit) => visit.status == "inProgress")
          .toList()
          .length;
      int numCompleted = event.visit
          .where((visit) => visit.status == "complete")
          .toList()
          .length;
      int numPending =
          event.visit.where((visit) => visit.status == "req").toList().length;

      numActive = numActive != null ? numActive : 0;
      numCompleted = numCompleted != null ? numCompleted : 0;
      numPending = numPending != null ? numPending : 0;
      yield VisitStatsLoaded(numActive, numCompleted, numPending);
    }
  }

  @override
  Future<void> close() {
    _visitSubscription?.cancel();
    return super.close();
  }
}
