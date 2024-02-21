import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/budget/cubit/budget_cubit.dart';
import 'package:test_flutter_web/features/products/cubit/product_cubit.dart';
import 'package:test_flutter_web/features/products/cubit/product_cubit_states.dart';
import 'package:test_flutter_web/features/products/widgets/custom_modal_widget.dart';
import 'package:test_flutter_web/features/products/widgets/products_container_widget.dart';
import 'package:test_flutter_web/services/service_locator/service_locator.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final ProductCubit productCubit = ProductCubit(budgetCubit: getIt.get<BudgetCubit>());

  @override
  void initState() {
    super.initState();
    productCubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showModal,
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductCubitStates>(
        bloc: productCubit,
        builder: (context, state) {
          if (state is ProductErrorState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is ProductInsertedState) {
            const snackbar = SnackBar(content: Center(child: Text('Produto adicionado com sucesso!')));
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            });
            productCubit.initialize();
          }

          if (state is ProductLoadedState) {
            return SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 32),
                      const Text(
                        'PRODUTOS',
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 64),
                      Row(
                        children: [
                          Expanded(
                            child: ProductContainerWidget(
                              productType: 'Perfil',
                              products: state.profiles,
                              state: state,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ProductContainerWidget(
                              productType: 'Vidro',
                              products: state.glasses,
                              state: state,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ProductContainerWidget(
                              productType: 'Puxador',
                              products: state.pullers,
                              state: state,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _showModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomModalWidget(productCubit: productCubit);
      },
    );
  }
}
