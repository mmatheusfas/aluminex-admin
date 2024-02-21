import 'package:aluminex_core/aluminex_core.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_web/features/auth/login/login_view.dart';
import 'package:test_flutter_web/features/clients/client_details/client_details_view.dart';
import 'package:test_flutter_web/features/close_order/close_order_view.dart';
import 'package:test_flutter_web/features/home/home_view.dart';
import 'package:test_flutter_web/services/service_locator/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AluminexCoreConfig(
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginView(),
        '/home': (_) => const HomeView(),
        '/client-detail': (_) => const ClientDetailsView(),
        '/close-order': (_) => const CloseOrderView(),
      },
    );
  }
}
