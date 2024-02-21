class Client {
  final String cpf;
  final String name;
  final String email;
  final String phone;
  bool hasOrder;

  Client({
    required this.cpf,
    required this.name,
    required this.email,
    required this.phone,
    this.hasOrder = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'document': cpf,
      'name': name,
      'email': email,
      'phone_number': phone,
      'has_order': hasOrder,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      cpf: map['document'],
      name: map['name'],
      email: map['email'],
      phone: map['phone_number'],
      hasOrder: map['has_order'],
    );
  }

  static List<Client> fromMapList(List mapList) {
    return mapList.map((clientMap) => Client.fromMap(clientMap)).toList();
  }
}
