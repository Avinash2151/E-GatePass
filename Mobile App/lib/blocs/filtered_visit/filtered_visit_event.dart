import 'package:equatable/equatable.dart';
import 'package:keepapp/models/models.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';
abstract class FilteredVisitEvent extends Equatable {
  const FilteredVisitEvent();
}

class UpdateFilter extends FilteredVisitEvent {
  final VisibilityFilter filter;

  const UpdateFilter(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}

class UpdateVisits extends FilteredVisitEvent {
  final List<Visit> visit;

  const UpdateVisits(this.visit);

  @override
  List<Object> get props => [visit];

  @override
  String toString() => 'UpdateVisits   { visit: $visit }';
}
