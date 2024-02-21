import 'package:aluminex_core/aluminex_core.dart';
import 'package:bloc/bloc.dart';
import 'package:test_flutter_web/features/auth/login/cubit/login_cubit_states.dart';
import 'package:test_flutter_web/repositorys/adm_user/login_adm/user_login_service.dart';
import 'package:test_flutter_web/repositorys/adm_user/login_adm/user_login_service_impl.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  final UserLoginService _loginService = UserLoginServiceImpl();

  LoginCubit() : super(LoginInitialState());

  void loginAdmUser({required String email, required String password}) async {
    emit(LoginLoadingState());
    final loginResult = await _loginService.execute(email, password);

    switch (loginResult) {
      case Left(value: ServiceException(:final message)):
        emit(LoginErrorState(message: message));
      case Right(value: _):
        emit(LoginLoggedState());
    }
  }
}
