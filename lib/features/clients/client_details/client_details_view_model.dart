import 'package:flutter/foundation.dart';
import 'package:test_flutter_web/models/client_order.dart';

class ClientDetailsViewModel extends ChangeNotifier {
  final List<ClientOrder> _orders = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<ClientOrder> get orders => _orders;

  void _changeIsLoading({required bool isLoading}) {
    _isLoading = isLoading;
    notifyListeners();
  }
}
