import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  final String? email;

  RegisterEmailChanged({this.email});

  @override
  List<Object?> get props => [email];
}

class RegisterUsernameChanged extends RegisterEvent {
  final String? username;

  RegisterUsernameChanged({this.username});

  @override
  List<Object?> get props => [username];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String? password;

  RegisterPasswordChanged({this.password});

  @override
  List<Object?> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {
  final String? email;
  final String? username;
  final String? password;

  RegisterSubmitted({this.email, this.username, this.password});

  @override
  List<Object> get props => [email!, username!, password!];
}
