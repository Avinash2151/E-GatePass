import 'package:equatable/equatable.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
import 'package:keepapp/models/models.dart';

abstract class FilteredConferenceEvent extends Equatable {
  const FilteredConferenceEvent();
}

class UpdateFilter extends FilteredConferenceEvent {
  final VisibilityFilter filter;

  const UpdateFilter(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}

class UpdateConferences extends FilteredConferenceEvent {
  final List<Conference> conference;

  const UpdateConferences(this.conference);

  @override
  List<Object> get props => [conference];

  @override
  String toString() => 'UpdateConferences   { conference: $conference }';
}
