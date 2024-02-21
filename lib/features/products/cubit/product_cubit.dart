import 'package:aluminex_core/aluminex_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/budget/cubit/budget_cubit.dart';
import 'package:test_flutter_web/features/products/cubit/product_cubit_states.dart';
import 'package:test_flutter_web/models/glass.dart';
import 'package:test_flutter_web/models/profile.dart';
import 'package:test_flutter_web/models/puller.dart';
import 'package:test_flutter_web/repositorys/glasses/glass_repository.dart';
import 'package:test_flutter_web/repositorys/glasses/glass_repository_impl.dart';
import 'package:test_flutter_web/repositorys/profiles/profile_repository.dart';
import 'package:test_flutter_web/repositorys/profiles/profile_repository_impl.dart';
import 'package:test_flutter_web/repositorys/pullers/puller_repository.dart';
import 'package:test_flutter_web/repositorys/pullers/pullers_repository_impl.dart';

class ProductCubit extends Cubit<ProductCubitStates> {
  ProductCubit({required this.budgetCubit}) : super(ProductInitialState());

  final BudgetCubit budgetCubit;

  final ProfileRepository _profileRepository = ProfileRepositoryImpl();
  final PullerRepository _pullerRepository = PullerRepositoryImpl();
  final GlassRepository _glassRepository = GlassRepositoryImpl();
  List<Profile> _profiles = [];
  List<Puller> _pullers = [];
  List<Glass> _glasses = [];

  void initialize() async {
    emit(ProductLoadingState());

    try {
      await _getGlasses();
      await _getProfiles();
      await _getPullers();
      emit(
        ProductLoadedState(
          profiles: _profiles,
          pullers: _pullers,
          glasses: _glasses,
        ),
      );
    } on RepositoryException catch (_) {
      emit(ProductErrorState(message: 'Erro ao buscar produtos'));
    }
  }

  void insertNewProduct(String produtType, String name, String price) async {
    emit(ProductLoadingState());
    switch (produtType) {
      case 'Profiles':
        await _insertNewProfile(name, price);
        budgetCubit.initialize();
        emit(ProductInsertedState());
      case ('Pullers'):
        await _insertNewPuller(name, price);
        budgetCubit.initialize();
        emit(ProductInsertedState());
      case ('Glasses'):
        await _insertNewGlass(name, price);
        budgetCubit.initialize();
        emit(ProductInsertedState());
      default:
        emit(ProductErrorState(message: 'Erro ao adicionar novo produto'));
    }
  }

  Future<void> _insertNewProfile(String name, String price) async {
    final profile = Profile(name: name, price: double.parse(price));

    final result = await _profileRepository.addNewProfile(profile);

    switch (result) {
      case Left(value: RepositoryException()):
        emit(ProductErrorState(message: 'Erro ao adicionar perfil'));
      case Right():
        return;
    }
  }

  Future<void> _insertNewPuller(String name, String price) async {
    final puller = Puller(name: name, price: double.parse(price));

    final result = await _pullerRepository.addNewPuller(puller);

    switch (result) {
      case Left(value: RepositoryException()):
        emit(ProductErrorState(message: 'Erro ao adicionar puxador'));
      case Right():
        return;
    }
  }

  Future<void> _insertNewGlass(String name, String price) async {
    final glass = Glass(name: name, price: double.parse(price));

    final result = await _glassRepository.addNewGlass(glass);

    switch (result) {
      case Left(value: RepositoryException()):
        emit(ProductErrorState(message: 'Erro ao adicionar vidro'));
      case Right():
        return;
    }
  }

  Future<void> _getProfiles() async {
    final result = await _profileRepository.getProfiles();

    switch (result) {
      case Left(value: RepositoryException()):
        return;
      case Right(value: final profilesList):
        _profiles = profilesList;
    }
  }

  Future<void> _getPullers() async {
    final result = await _pullerRepository.getPullers();

    switch (result) {
      case Left(value: RepositoryException()):
        return;
      case Right(value: final pullersList):
        _pullers = pullersList;
    }
  }

  Future<void> _getGlasses() async {
    final result = await _glassRepository.getGlasses();

    switch (result) {
      case Left(value: RepositoryException()):
        return;
      case Right(value: final glassesList):
        _glasses = glassesList;
    }
  }
}
