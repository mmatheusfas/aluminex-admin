import '../../../models/glass.dart';
import '../../../models/profile.dart';
import '../../../models/puller.dart';

abstract class BudgetCubitStates {}

class BudgetInitialState extends BudgetCubitStates {}

class BudgetLoadingState extends BudgetCubitStates {}

class BudgetLoadedState extends BudgetCubitStates {
  final List<Glass> glasses;
  final List<Profile> profiles;
  final List<Puller> pullers;

  BudgetLoadedState({
    required this.glasses,
    required this.profiles,
    required this.pullers,
  });
}

class BudgetDoorInsertedState extends BudgetCubitStates {}

class BudgetDoneOrderState extends BudgetCubitStates {}

class BudgetErrorState extends BudgetCubitStates {
  final String message;

  BudgetErrorState({required this.message});
}
