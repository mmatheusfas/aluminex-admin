class Door {
  double altura;
  double largura;
  String perfil;
  String? puxador;
  int quantidade;
  String vidro;
  double preco;

  Door({
    required this.altura,
    required this.largura,
    required this.perfil,
    this.puxador,
    required this.quantidade,
    required this.vidro,
    required this.preco,
  });

  factory Door.fromMap(Map<String, dynamic> map) {
    return Door(
      altura: map['altura'],
      largura: map['largura'],
      perfil: map['perfil'],
      puxador: map['puxador'],
      quantidade: map['quantidade'],
      vidro: map['vidro'],
      preco: map['preco'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'altura': altura,
      'largura': largura,
      'perfil': perfil,
      'puxador': puxador,
      'quantidade': quantidade,
      'vidro': vidro,
      'preco': preco,
    };
  }

  static List<Door> fromMapList(List mapList) {
    return mapList.map((map) => Door.fromMap(map)).toList();
  }
}
