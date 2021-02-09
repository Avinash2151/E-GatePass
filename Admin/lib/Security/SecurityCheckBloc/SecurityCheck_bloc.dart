import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:keepapp/Security/SecurityCheckBloc/SecurityCheck.dart';
import 'package:keepapp/Security/seccurityCheck_repository/lib/securityCheck_repository.dart';
import 'package:keepapp/utils/LocalDataStorage.dart';
import 'package:meta/meta.dart';

class SecurityCheckBloc extends Bloc<SecurityCheckEvent, SecurityCheckState> {
  final SecurityCheckRepository _securityCheckRepository;
  StreamSubscription _securityCheckSubscription;

  SecurityCheckBloc({
    @required SecurityCheckRepository securityCheckRepository,
  })  : assert(securityCheckRepository != null),
        _securityCheckRepository = securityCheckRepository;

  LocalDataStorage localDataStorage = LocalDataStorage();
  @override
  SecurityCheckState get initialState => SecurityCheckLoading();

  @override
  Stream<SecurityCheckState> mapEventToState(SecurityCheckEvent event) async* {
    if (event is DocIdCheck) {
      yield* _mapSecurityIDCheckToState(event);
    } else if (event is DocIdCheckUpdated) {
      yield* _mapDocIdCheckUpdatedToState(event);
    } else if (event is UpdateSecurityCheckVisit) {
      yield* _mapUpdateSecurityCheckVisitToState(event);
    }
  }

  Stream<SecurityCheckState> _mapSecurityIDCheckToState(
      DocIdCheck event) async* {
    _securityCheckSubscription?.cancel();
    try {
      _securityCheckSubscription =
          _securityCheckRepository.securityCheck(event.docID).asStream().listen(
                (SecurityCheck) => add(DocIdCheckUpdated(SecurityCheck)),
              );
    } catch (e) {
      yield SecurityCheckNotLoaded(e);
    }
  }

  Stream<SecurityCheckState> _mapDocIdCheckUpdatedToState(
      DocIdCheckUpdated event) async* {
    try {
      if (event.securityCheck != null) {
        yield DocIDCheckLoaded(event.securityCheck);
      } else {
        yield SecurityCheckNotLoaded("No Data Found");
      }
    } catch (e) {
      yield SecurityCheckNotLoaded(e);
    }
  }

  Stream<SecurityCheckState> _mapUpdateSecurityCheckVisitToState(
      UpdateSecurityCheckVisit event) async* {
    _securityCheckRepository
        .updateSecurityCheckVisit(event.updatedSecurityCheckVisit);
  }

  @override
  Future<void> close() {
    _securityCheckSubscription?.cancel();
    return super.close();
  }
}
