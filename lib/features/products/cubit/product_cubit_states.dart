import 'package:test_flutter_web/models/glass.dart';
import 'package:test_flutter_web/models/profile.dart';

import '../../../models/puller.dart';

abstract class ProductCubitStates {}

class ProductInitialState extends ProductCubitStates {}

class ProductLoadingState extends ProductCubitStates {}

class ProductLoadedState extends ProductCubitStates {
  final List<Profile> profiles;
  final List<Puller> pullers;
  final List<Glass> glasses;

  ProductLoadedState({
    required this.profiles,
    required this.pullers,
    required this.glasses,
  });
}

class ProductErrorState extends ProductCubitStates {
  final String message;

  ProductErrorState({required this.message});
}

class ProductInsertedState extends ProductCubitStates {}
