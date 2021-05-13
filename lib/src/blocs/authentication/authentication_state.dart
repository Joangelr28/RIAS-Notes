import 'package:equatable/equatable.dart';
import 'package:notes_app/src/repository/authentication_repository.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final AuthenticationRepository _authenticatedUser;

  AuthenticationSuccess(this._authenticatedUser);

  @override
  List<Object> get props => [_authenticatedUser];
}

class AuthenticationFailure extends AuthenticationState {}
