import 'package:aluminex_core/aluminex_core.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_web/features/budget/budget_view.dart';
import 'package:test_flutter_web/features/clients/clients_view.dart';
import 'package:test_flutter_web/features/orders/orders_view.dart';
import 'package:test_flutter_web/features/products/products_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  void _changeCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AluminexAppBar(),
      drawer: NavigationDrawer(
        selectedIndex: _currentIndex,
        onDestinationSelected: _changeCurrentIndex,
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        children: const [
          NavigationDrawerDestination(icon: Icon(Icons.monetization_on), label: Text('Orçamentos')),
          NavigationDrawerDestination(icon: Icon(Icons.person_3), label: Text('Clientes')),
          NavigationDrawerDestination(icon: Icon(Icons.house_siding), label: Text('Produtos')),
          NavigationDrawerDestination(icon: Icon(Icons.shopping_cart), label: Text('Pedidos')),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          BudgetView(),
          ClientsView(),
          ProductsView(),
          OrdersView(),
        ],
      ),
    );
  }
}
