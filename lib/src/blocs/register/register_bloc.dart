import 'register_event.dart';
import 'register_state.dart';
import '../../assets/utility/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/user_repository.dart';

export 'register_event.dart';
export 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState.initial());

  UserRepository _userRepository = UserRepository();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangeToState(event.email!);
    } else if (event is RegisterUsernameChanged) {
      yield* _mapRegisterUsernameChangeToState(event.username!);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangeToState(event.password!);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(
          email: event.email,
          username: event.username,
          password: event.password);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterUsernameChangeToState(
      String username) async* {
    yield state.update(isUsernameValid: username.isNotEmpty);
  }

  Stream<RegisterState> _mapRegisterPasswordChangeToState(
      String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
      {String? email, String? username, String? password}) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(email, username, password);
      yield RegisterState.success();
    } catch (error) {
      print(error);
      yield RegisterState.failure();
    }
  }
}
