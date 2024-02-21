abstract class LoginCubitState {}

class LoginInitialState extends LoginCubitState {}

class LoginLoadingState extends LoginCubitState {}

class LoginLoggedState extends LoginCubitState {}

class LoginErrorState extends LoginCubitState {
  final String message;

  LoginErrorState({required this.message});
}
