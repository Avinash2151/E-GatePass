import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';
import 'package:keepapp/blocs/filtered_visit/filtered_visit.dart';
import 'package:keepapp/Pass/BookVisit/bloc/Visit.dart';
import 'package:keepapp/models/models.dart';

//import 'filtered_visit_event.dart';
class FilteredVisitBloc extends Bloc<FilteredVisitEvent, FilteredVisitState> {
  final VisitBloc _visitBloc;
  StreamSubscription _visitSubscription;

  FilteredVisitBloc({@required VisitBloc visitBloc})
      : assert(visitBloc != null),
        _visitBloc = visitBloc {
    _visitSubscription = visitBloc.listen((state) {
      if (state is VisitLoaded) {
        add(UpdateVisits((visitBloc.state as VisitLoaded).visit));
      }
    });
  }

  @override
  FilteredVisitState get initialState {
    final currentState = _visitBloc.state;
    return currentState is VisitLoaded
        ? FilteredVisitLoaded(currentState.visit, VisibilityFilter.all)
        : FilteredVisitLoading();
  }

  @override
  Stream<FilteredVisitState> mapEventToState(FilteredVisitEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateVisits) {
      yield* _mapVisitUpdatedToState(event);
    }
  }

  Stream<FilteredVisitState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    final currentState = _visitBloc.state;
    if (currentState is VisitLoaded) {
      yield FilteredVisitLoaded(
        _mapVisitToFilteredVisit(currentState.visit, event.filter),
        event.filter,
      );
    }
  }

  Stream<FilteredVisitState> _mapVisitUpdatedToState(
    UpdateVisits event,
  ) async* {
    final visibilityFilter = state is FilteredVisitLoaded
        ? (state as FilteredVisitLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredVisitLoaded(
      _mapVisitToFilteredVisit(
        (_visitBloc.state as VisitLoaded).visit,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Visit> _mapVisitToFilteredVisit(
      List<Visit> visit, VisibilityFilter filter) {
    return visit.where((visit) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return visit.status =="req";
      } else {
        return visit.status =="complete";
      }
    }).toList();
  }

  @override
  Future<void> close() {
    _visitSubscription?.cancel();
    return super.close();
  }
}
