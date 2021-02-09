import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:keepapp/Pass/BookConference/bloc/Conference.dart';
import 'package:keepapp/blocs/ConferenceStats/conferenceStats.dart';

class ConferenceStatsBloc
    extends Bloc<ConferenceStatsEvent, ConferenceStatsState> {
  StreamSubscription _conferenceSubcription;
  ConferenceStatsBloc({ConferenceBloc conferenceBloc})
      : assert(conferenceBloc != null) {
    _conferenceSubcription = conferenceBloc.listen((state) {
      if (state is ConferenceLoaded) {
        add(UpdateStats_Conference(state.conference));
      }
    });
  }

  @override
  ConferenceStatsState get initialState => ConferenceStatsLoading();

  @override
  Stream<ConferenceStatsState> mapEventToState(
      ConferenceStatsEvent event) async* {
    if (event is UpdateStats_Conference) {
      int numPending = event.conference
          .where((conference) => conference.status == "req")
          .toList()
          .length;
      int numActive = event.conference
          .where((conference) => conference.status == "inProgress")
          .toList()
          .length;
      int numCompleted = event.conference
          .where((conferece) => conferece.status == "complete")
          .toList()
          .length;

      numActive = numActive != null ? numActive : 0;
      numCompleted = numCompleted != null ? numCompleted : 0;
      numPending = numPending != null ? numPending : 0;
      yield ConferenceStatsLoaded(numActive, numCompleted, numPending);
    }
  }

  @override
  Future<void> close() {
    _conferenceSubcription?.cancel();
    return super.close();
  }
}
