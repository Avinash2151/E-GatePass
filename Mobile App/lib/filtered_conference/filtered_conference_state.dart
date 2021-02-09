import 'package:equatable/equatable.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
import 'package:keepapp/models/models.dart';

abstract class FilteredConferenceState extends Equatable {
  const FilteredConferenceState();

  @override
  List<Object> get props => [];
}

class FilteredConferenceLoading extends FilteredConferenceState {}

class FilteredConferenceLoaded extends FilteredConferenceState {
  final List<Conference> filteredConference;
  final VisibilityFilter activeFilter;

  const FilteredConferenceLoaded(
    this.filteredConference,
    this.activeFilter,
  );

  @override
  List<Object> get props => [filteredConference, activeFilter];

  @override
  String toString() {
    return 'FilteredConferenceLoaded { filteredConference: $filteredConference, activeFilter: $activeFilter }';
  }
}
