import 'package:equatable/equatable.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';
import 'package:keepapp/models/models.dart';

abstract class FilteredVisitState extends Equatable {
  const FilteredVisitState();

  @override
  List<Object> get props => [];
}

class FilteredVisitLoading extends FilteredVisitState {}

class FilteredVisitLoaded extends FilteredVisitState {
  final List<Visit> filteredVisit;
  final VisibilityFilter activeFilter;

  const FilteredVisitLoaded(
    this.filteredVisit,
    this.activeFilter,
  );

  @override
  List<Object> get props => [filteredVisit, activeFilter];

  @override
  String toString() {
    return 'FilteredVisitLoaded { filteredVisit: $filteredVisit, activeFilter: $activeFilter }';
  }
}
