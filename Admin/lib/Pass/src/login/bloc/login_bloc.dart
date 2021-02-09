import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepapp/Pass/src/data/api/user_repository.dart';
import 'package:keepapp/Pass/src/login/bloc/login_state.dart';
import 'package:keepapp/Pass/src/utils/validators.dart';
import 'package:keepapp/main.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;
  BuildContext context;
  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events, transitionFn) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });

    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(
        nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: password.isNotEmpty);
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {String email, String password}) async* {
    yield LoginState.loading();
    try {
      final result =
          await _userRepository.signInWithCredentials(email, password);
      if (result) {
        yield LoginState.success();
        //openHomePage();
      } else {
        yield LoginState.failure("LoggedIn failed");
      }
    } catch (e) {
      print("Login failed reason");
      print(e);
      yield LoginState.failure(e);
    }
  }

  void openHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => App()),
    );
  }
}
