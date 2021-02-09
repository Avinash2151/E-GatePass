import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:keepapp/Pass/src/data/api/user_repository.dart';
import 'package:keepapp/Pass/src/utils/validators.dart';
import 'package:keepapp/utils/Utils.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  final UserRepository _userRepository;

  AddUserBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AddUserState get initialState => AddUserState.empty();

  @override
  Stream<Transition<AddUserEvent, AddUserState>> transformEvents(
    Stream<AddUserEvent> events,
    TransitionFunction<AddUserEvent, AddUserState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChangedEvent && event is! PasswordChangedEvent);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChangedEvent || event is PasswordChangedEvent);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<AddUserState> mapEventToState(
    AddUserEvent event,
  ) async* {
    if (event is NameChangedEvent) {
      yield state.update(isValidName: event.name.isNotEmpty);
    } else if (event is EmailChangedEvent) {
      yield state.update(isValidEmail: Validators.isValidEmail(event.email));
    } else if (event is PasswordChangedEvent) {
      yield state.update(isValidPassword: event.password.isNotEmpty);
    } else if (event is ConfirmPasswordChanged) {
      yield state.update(
          isValidConfirmPassword: event.password.isNotEmpty,
          isPasswordMatch: event.password == event.confirmPassword);
    } else if (event is SubmitFormEvent) {
      yield AddUserState.loading();
      //Utils.showToast("Adding User....");
      try {
        await _userRepository.signUp(
            email: event.email, password: event.password, role: event.role);
        yield AddUserState.success();

        //   Utils.showToast("User Added Successfully");
      } catch (e) {
        yield AddUserState.failure(e.message);

        //   Utils.showToast(e.message);
      }
    }
  }
}
