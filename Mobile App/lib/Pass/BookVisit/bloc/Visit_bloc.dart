import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:keepapp/Pass/BookVisit/bloc/Visit.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';
import 'package:keepapp/utils/LocalDataStorage.dart';
import 'package:meta/meta.dart';
class VisitBloc extends Bloc<VisitEvent, VisitState> {
  final VisitRepository _VisitRepository;
  StreamSubscription _VisitSubscription;

  VisitBloc({@required VisitRepository VisitRepository})
      : assert(VisitRepository != null),
        _VisitRepository = VisitRepository;

   LocalDataStorage localDataStorage = LocalDataStorage();
  @override
  VisitState get initialState => VisitLoading();

  @override
  Stream<VisitState> mapEventToState(VisitEvent event) async* {
    if (event is Loadvisit) {
      yield* _mapLoadVisitToState();
    } else if (event is AddVisit) {
      yield* _mapAddVisitToState(event);
    } else if (event is UpdateVisit) {
      yield* _mapUpdateVisitToState(event);
    } else if (event is DeleteVisit) {
      yield* _mapDeleteVisitToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if (event is VisitUpdated) {
      yield* _mapVisitUpdateToState(event);
    }
  }

  Stream<VisitState> _mapLoadVisitToState() async* {
    _VisitSubscription?.cancel();
    _VisitSubscription = _VisitRepository.visit().asStream().listen
      (
          (Visit) => add(VisitUpdated(Visit)),
        );
  }

  Stream<VisitState> _mapAddVisitToState(AddVisit event) async* {
    _VisitRepository.addNewVisit(event.visit);
  }

  Stream<VisitState> _mapUpdateVisitToState(UpdateVisit event) async* {
    _VisitRepository.updateVisit(event.updatedVisit);
  }

  Stream<VisitState> _mapDeleteVisitToState(DeleteVisit event) async* {
    _VisitRepository.deleteVisit(event.visit);
  }

  Stream<VisitState> _mapToggleAllToState() async* {
    final currentState = state;
    if (currentState is VisitLoaded) {
      //final allcomplete =currentState.visit.map((visit) => visit.status == "req") as String;
      final allComplete = currentState.visit.every((visit) => visit.status =="req");
      final List<Visit> updatedVisit = currentState.visit.map((visit) => visit.copyWith(status: allComplete.toString())).toList();
      updatedVisit.forEach((updatedVisit) {
        _VisitRepository.updateVisit(updatedVisit);
      });
    }
  }

  Stream<VisitState> _mapClearCompletedToState() async* {
    final currentState = state;
    if (currentState is VisitLoaded) {
      final List<Visit> completedVisit =
          currentState.visit.where((visit) => visit.status == "complete").toList();
      completedVisit.forEach((completedVisit) {
        _VisitRepository.deleteVisit(completedVisit);
      });
    }
  }

  Stream<VisitState> _mapVisitUpdateToState(VisitUpdated event) async* {
    yield VisitLoaded(event.visit);
  }

  @override
  Future<void> close() {
    _VisitSubscription?.cancel();
    return super.close();
  }
}
