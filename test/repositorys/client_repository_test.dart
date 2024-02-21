import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_web/models/client.dart';
import 'package:test_flutter_web/repositorys/clients/client_repository.dart';
import 'package:test_flutter_web/repositorys/clients/client_repository_impl.dart';
import 'package:test_flutter_web/services/service_locator/service_locator.dart';

void main() {
  setUp(() {
    // setupServices();
    WidgetsFlutterBinding.ensureInitialized();
  });

  test('Test if function getAllClients is returning a List of Client', () async {
    setupServices();
    final ClientRepository repository = ClientRepositoryImpl();
    final result = await repository.getAllClients();
    expect(result, isNotEmpty);
    expect(result, isA<List<Client>>());
  });
}
