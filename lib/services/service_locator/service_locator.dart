import 'package:aluminex_core/aluminex_core.dart';
import 'package:get_it/get_it.dart';
import 'package:test_flutter_web/core/env.dart';
import 'package:test_flutter_web/features/budget/cubit/budget_cubit.dart';
import 'package:test_flutter_web/repositorys/clients/client_repository.dart';
import 'package:test_flutter_web/repositorys/clients/client_repository_impl.dart';

final getIt = GetIt.instance;

void setupServices() {
  getIt.registerSingleton<RestClient>(RestClient(Env.backendBaseUrl));
  getIt.registerSingleton<BudgetCubit>(BudgetCubit());
  getIt.registerSingleton<ClientRepository>(ClientRepositoryImpl());
}
