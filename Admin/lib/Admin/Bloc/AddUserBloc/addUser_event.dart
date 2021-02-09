import 'package:meta/meta.dart';

@immutable
abstract class AddUserEvent {}

class NameChangedEvent extends AddUserEvent {
  final String name;

  NameChangedEvent({this.name});
}

class EmailChangedEvent extends AddUserEvent {
  final String email;

  EmailChangedEvent({this.email});
}

class PasswordChangedEvent extends AddUserEvent {
  final String password;
  final String confirmPassword;

  PasswordChangedEvent({this.password, this.confirmPassword});
}

class ConfirmPasswordChanged extends AddUserEvent {
  final String password;
  final String confirmPassword;

  ConfirmPasswordChanged({this.password, this.confirmPassword});
}

class SubmitFormEvent extends AddUserEvent {
  final String name;
  final String password;
  final String confirmPassword;
  final String email;
  final String role;
  SubmitFormEvent(
      {this.name, this.password, this.confirmPassword, this.email, this.role});
}
