class Order {
  final String orderid;
  final String price;
  final String text;

  final bool delivered;

  Order({
    this.orderid,
    this.text,
    this.price,
    this.delivered,
  });
}

List<Order> orders = [
  Order(
    orderid: 'ORD4517435',
    price: '200',
    text: 'Ordered - 05/11/2019',
    delivered: false,
  ),
  Order(
    orderid: 'ORD4517874',
    price: '520',
    text: 'Ordered - 27/10/2019',
    delivered: true,
  ),
  Order(
    orderid: 'ORD4517968',
    price: '780',
    text: 'Ordered - 17/10/2019',
    delivered: true,
  ),
  Order(
    orderid: 'ORD4517774',
    price: '345',
    text: 'Ordered - 05/10/2019',
    delivered: true,
  ),
];
