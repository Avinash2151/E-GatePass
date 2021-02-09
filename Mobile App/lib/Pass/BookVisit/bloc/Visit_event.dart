import 'package:equatable/equatable.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';

abstract class VisitEvent extends Equatable {
  const VisitEvent();

  @override
  List<Object> get props => [];
}

class Loadvisit extends VisitEvent {

}

class AddVisit extends VisitEvent {
  final Visit visit;

  const AddVisit(this.visit);

  @override
  List<Object> get props => [visit];

  @override
  String toString() => 'AddVisit { visit: $visit }';
}

class UpdateVisit extends VisitEvent {
  final Visit updatedVisit;

  const UpdateVisit(this.updatedVisit);

  @override
  List<Object> get props => [updatedVisit];

  @override
  String toString() => 'UpdateVisit { updatedVisit: $updatedVisit }';
}

class DeleteVisit extends VisitEvent {
  final Visit visit;

  const DeleteVisit(this.visit);

  @override
  List<Object> get props => [visit];

  @override
  String toString() => 'DeleteVisit { visit: $visit }';
}

class ClearCompleted extends VisitEvent {}

class ToggleAll extends VisitEvent {}

class VisitUpdated extends VisitEvent {
  final List<Visit> visit;

  const VisitUpdated(this.visit);

  @override
  List<Object> get props => [visit];
}
