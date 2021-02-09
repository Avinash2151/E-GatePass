import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:keepapp/Pass/src/data/api/user_repository.dart';
import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  //StreamSubscription _authenticationSubscription;
  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final isSignIn = await _userRepository.isSignedIn();
    if (isSignIn) {
      yield Authenticated();
    } else {
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    try {
      yield Authenticated();
    } catch (Exception) {
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield UnAuthenticated();
    //_authenticationSubscription?.cancel();
    _userRepository.signOut();
  }

  // @override
  // Future<void> close() {
  //   _authenticationSubscription?.cancel();
  //   return super.close();
  // }
}
