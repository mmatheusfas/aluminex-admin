enum OrderStatus {
  pedidoFeito,
  emProducao,
  emFinalizacao,
  pronto,
  vazio;

  static OrderStatus getOrderStatusByName(String orderStatusName) {
    switch (orderStatusName) {
      case 'pedidoFeito':
        return OrderStatus.pedidoFeito;
      case 'emProducao':
        return OrderStatus.emProducao;
      case 'emFinalizacao':
        return OrderStatus.emFinalizacao;
      case 'pronto':
        return OrderStatus.pronto;
    }
    return vazio;
  }
}
