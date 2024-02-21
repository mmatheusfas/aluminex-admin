import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/budget/cubit/budget_cubit.dart';
import 'package:test_flutter_web/features/budget/cubit/budget_cubit_states.dart';
import 'package:validatorless/validatorless.dart';

import 'components/cart_widget.dart';

class BudgetView extends StatefulWidget {
  const BudgetView({super.key});

  @override
  State<BudgetView> createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {
  final budgetCubit = BudgetCubit();

  @override
  void initState() {
    super.initState();
    budgetCubit.initialize();
  }

  @override
  void dispose() {
    budgetCubit.disposeTextEditingControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocBuilder<BudgetCubit, BudgetCubitStates>(
      bloc: budgetCubit,
      builder: (context, state) {
        if (state is BudgetLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BudgetDoorInsertedState) {
          const snackbar = SnackBar(content: Center(child: Text('Porta adicionada com sucesso!')));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          });

          budgetCubit.initialize();
        }
        if (state is BudgetLoadedState) {
          var sizeOf = MediaQuery.sizeOf(context);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: showCartModal,
              child: const Icon(Icons.shopping_bag),
            ),
            body: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: sizeOf.width * .7,
                margin: const EdgeInsets.only(top: 80),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const Text(
                            'ORÇAMENTO',
                            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 64),
                          const Text('Vidro:'),
                          const SizedBox(height: 12),
                          DropdownButtonFormField(
                            icon: const Icon(Icons.arrow_drop_down),
                            menuMaxHeight: 200,
                            items: budgetCubit.glasses.map((glass) {
                              return DropdownMenuItem(
                                value: glass.name,
                                child: Text(glass.name),
                              );
                            }).toList(),
                            onChanged: budgetCubit.updateGlass,
                          ),
                          const SizedBox(height: 24),
                          const Text('Perfil:'),
                          const SizedBox(height: 12),
                          DropdownButtonFormField(
                            icon: const Icon(Icons.arrow_drop_down),
                            menuMaxHeight: 200,
                            items: budgetCubit.profiles.map((profile) {
                              return DropdownMenuItem(
                                value: profile.name,
                                child: Text(profile.name),
                              );
                            }).toList(),
                            onChanged: budgetCubit.updateProfile,
                          ),
                          const SizedBox(height: 24),
                          const Text('Puxador:'),
                          const SizedBox(height: 12),
                          DropdownButtonFormField(
                            icon: const Icon(Icons.arrow_drop_down),
                            menuMaxHeight: 200,
                            items: budgetCubit.pullers.map((puller) {
                              return DropdownMenuItem(
                                value: puller.name,
                                child: Text(puller.name),
                              );
                            }).toList(),
                            onChanged: budgetCubit.updatePuller,
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            validator: Validatorless.required('Altura não pode ser vazia!'),
                            keyboardType: TextInputType.number,
                            controller: budgetCubit.heightEC,
                            decoration: const InputDecoration(
                              label: Text('Digite a altura em CM'),
                              filled: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            validator: Validatorless.required('Largura não pode ser vazia!'),
                            keyboardType: TextInputType.number,
                            controller: budgetCubit.widthEC,
                            decoration: const InputDecoration(
                              label: Text('Digite a largura em CM'),
                              filled: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            validator: Validatorless.required('Quantidade não pode ser vazia!'),
                            keyboardType: TextInputType.number,
                            controller: budgetCubit.qtdEC,
                            decoration: const InputDecoration(
                              label: Text('Quantidade'),
                              filled: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              final valid = formKey.currentState!.validate();
                              if (valid) {
                                budgetCubit.addDorToCart();
                              }
                            },
                            style: const ButtonStyle(),
                            child: const Text('Adicionar porta'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return const Text('Erro');
      },
    );
  }

  Future<dynamic> showCartModal() {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        if (budgetCubit.cart.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: 240,
                  image: NetworkImage(
                    'https://cdn0.iconfinder.com/data/icons/shopping-cart-26/1000/Shopping-Basket-17-512.png',
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Seu carrinho está vazio!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return CarWidget(budgetCubit: budgetCubit);
      },
    );
  }
}
