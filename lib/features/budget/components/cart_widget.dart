import 'package:flutter/material.dart';
import 'package:test_flutter_web/features/budget/cubit/budget_cubit.dart';
import 'package:test_flutter_web/support/components/door_tile.dart';

class CarWidget extends StatelessWidget {
  final BudgetCubit budgetCubit;

  const CarWidget({super.key, required this.budgetCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: budgetCubit.cart.length,
            itemBuilder: (_, index) {
              final door = budgetCubit.cart[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: DoorTile(door: door),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/close-order', arguments: budgetCubit.cart);
          },
          child: const Text('Fechar pedido'),
        ),
        const SizedBox(height: 36),
      ],
    );
  }
}
