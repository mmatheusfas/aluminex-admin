import 'dart:async';

import 'package:aluminex_core/aluminex_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/budget/cubit/budget_cubit_states.dart';

import '../../../models/door.dart';
import '../../../models/glass.dart';
import '../../../models/profile.dart';
import '../../../models/puller.dart';
import '../../../repositorys/glasses/glass_repository.dart';
import '../../../repositorys/glasses/glass_repository_impl.dart';
import '../../../repositorys/profiles/profile_repository.dart';
import '../../../repositorys/profiles/profile_repository_impl.dart';
import '../../../repositorys/pullers/puller_repository.dart';
import '../../../repositorys/pullers/pullers_repository_impl.dart';

class BudgetCubit extends Cubit<BudgetCubitStates> {
  BudgetCubit() : super(BudgetInitialState());

  final ProfileRepository _profileRepository = ProfileRepositoryImpl();
  final PullerRepository _pullerRepository = PullerRepositoryImpl();
  final GlassRepository _glassRepository = GlassRepositoryImpl();

  List<Glass> _glasses = [];
  List<Profile> _profiles = [];
  List<Puller> _pullers = [];

  final _heightEC = TextEditingController();
  final _widthEC = TextEditingController();
  final _qtdEC = TextEditingController();

  String _profile = '';
  String _glass = '';
  String? _puller;

  final List<Door> _cart = [];

  List<Door> get cart => _cart;
  TextEditingController get widthEC => _widthEC;
  TextEditingController get qtdEC => _qtdEC;
  TextEditingController get heightEC => _heightEC;
  List<Profile> get profiles => _profiles;
  List<Puller> get pullers => _pullers;
  List<Glass> get glasses => _glasses;

  void initialize() async {
    emit(BudgetLoadingState());

    try {
      await _getGlasses();
      await _getProfiles();
      await _getPullers();
      emit(
        BudgetLoadedState(
          profiles: _profiles,
          pullers: _pullers,
          glasses: _glasses,
        ),
      );
    } on RepositoryException catch (_) {
      emit(BudgetErrorState(message: 'Erro ao buscar produtos'));
    }
  }

  void disposeTextEditingControllers() {
    _qtdEC.dispose();
    _widthEC.dispose();
    _heightEC.dispose();
  }

  void addDorToCart() {
    final price = _calculaPrecoPorta();
    cart.add(
      Door(
        altura: double.parse(_heightEC.text),
        largura: double.parse(_widthEC.text),
        perfil: _profile,
        quantidade: int.parse(_qtdEC.text),
        vidro: _glass,
        puxador: _puller,
        preco: price,
      ),
    );
    _qtdEC.clear();
    _widthEC.clear();
    _heightEC.clear();
    emit(BudgetDoorInsertedState());
  }

  void updateProfile(String? newProfile) {
    if (newProfile == null) return;

    _profile = newProfile;
  }

  void updateGlass(String? newGlass) {
    if (newGlass == null) return;

    _glass = newGlass;
  }

  void updatePuller(String? newPuller) {
    if (newPuller == null) return;

    _puller = newPuller;
  }

  double _calculaPrecoPorta() {
    var profilePrice = 0.0;
    var glassPrice = 0.0;

    for (var profile in _profiles) {
      if (profile.name == _profile) {
        profilePrice = profile.price;
      }
    }

    for (var glass in _glasses) {
      if (glass.name == _glass) {
        glassPrice = glass.price;
      }
    }
    final price = (((double.parse(_heightEC.text) * double.parse(_widthEC.text)) * profilePrice) +
        ((double.parse(_heightEC.text) * double.parse(_widthEC.text)) * glassPrice) * int.parse(_qtdEC.text));

    return price;
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
