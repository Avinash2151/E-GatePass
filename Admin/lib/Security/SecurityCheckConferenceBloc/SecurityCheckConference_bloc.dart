import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:keepapp/Security/SecurityCheckConferenceBloc/SecurityCheckConference.dart';
import 'package:keepapp/seccurityCheck_Conference_repository/lib/securityCheck_Conference_repository.dart';
import 'package:keepapp/utils/LocalDataStorage.dart';
import 'package:meta/meta.dart';

class SecurityCheckConferenceBloc
    extends Bloc<SecurityCheckConferenceEvent, SecurityCheckConferenceState> {
  final SecurityCheckConferenceRepository _securityCheckConferenceRepository;
  StreamSubscription _securityCheckSubscription;

  SecurityCheckConferenceBloc(
      {@required
          SecurityCheckConferenceRepository securityCheckConferenceRepository})
      : assert(securityCheckConferenceRepository != null),
        _securityCheckConferenceRepository = securityCheckConferenceRepository;

  @override
  SecurityCheckConferenceState get initialState =>
      SecurityCheckLoadingConference();

  @override
  Stream<SecurityCheckConferenceState> mapEventToState(
      SecurityCheckConferenceEvent event) async* {
    if (event is DocIdCheckConference) {
      yield* _mapSecurityIDCheckConferenceToState(event);
    } else if (event is DocIdCheckUpdatedConference) {
      yield* _mapDocIdCheckUpdatedConferenceToState(event);
    } else if (event is UpdateSecurityCheckConference) {
      yield* _mapUpdateSecurityCheckConferenceToState(event);
    }
  }

  ///Conference
  Stream<SecurityCheckConferenceState> _mapSecurityIDCheckConferenceToState(
      DocIdCheckConference event) async* {
    _securityCheckSubscription?.cancel();
    try {
      _securityCheckSubscription = _securityCheckConferenceRepository
          .securityCheckConference(event.docIdConference)
          .asStream()
          .listen(
            (SecurityCheck_Conference) =>
                add(DocIdCheckUpdatedConference(SecurityCheck_Conference)),
          );
    } catch (e) {
      yield SecurityCheckNotLoadedConference(e);
    }
  }

  Stream<SecurityCheckConferenceState> _mapDocIdCheckUpdatedConferenceToState(
      DocIdCheckUpdatedConference event) async* {
    print("Doc ID Check Updated called");
    try {
      if (event.securityCheck_Conference != null) {
        yield DocIDCheckLoadedConference(event.securityCheck_Conference);
        print("got the data");
      } else {
        yield SecurityCheckNotLoadedConference("No Data Found");
      }
    } catch (e) {
      yield SecurityCheckNotLoadedConference(e);
    }
  }

  Stream<SecurityCheckConferenceState> _mapUpdateSecurityCheckConferenceToState(
      UpdateSecurityCheckConference event) async* {
    _securityCheckConferenceRepository
        .updateSecurityCheckConference(event.updatedSecurityCheckConference);
  }

  @override
  Future<void> close() {
    _securityCheckSubscription?.cancel();
    return super.close();
  }
}
