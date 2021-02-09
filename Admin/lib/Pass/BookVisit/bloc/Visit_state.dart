import 'package:equatable/equatable.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';
abstract class VisitState extends Equatable {
  const VisitState();

  @override
  List<Object> get props => [];
}

class VisitLoading extends VisitState {}

class VisitLoaded extends VisitState {
  final List<Visit> visit;

  const VisitLoaded([this.visit = const []]);

  @override
  List<Object> get props => [visit];

  @override
  String toString() => 'VisitLoaded { Visit: $visit }';
}

class VisitNotLoaded extends VisitState {}
