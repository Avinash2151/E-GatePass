import 'package:equatable/equatable.dart';
import 'package:keepapp/Security/seccurityCheck_repository/lib/securityCheck_repository.dart';

abstract class SecurityCheckState extends Equatable {
  const SecurityCheckState();

  @override
  List<Object> get props => [];
}

class SecurityCheckLoading extends SecurityCheckState {}

class DocIDCheckLoaded extends SecurityCheckState {
  final SecurityCheck securityCheck;

  const DocIDCheckLoaded([this.securityCheck]);

  @override
  List<Object> get props => [securityCheck];

  @override
  String toString() => 'DocIDCheckLoaded { SecurityCheck: $securityCheck }';
}

class SecurityCheckNotLoaded extends SecurityCheckState {
  final String error;

  const SecurityCheckNotLoaded(this.error);

  List<Object> get props => [error];

  String toString() => 'SecurityCheckNotLoaded { error : $error}';
}
