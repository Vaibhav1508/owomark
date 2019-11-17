class Cart {
  final String title;
  final String price;
  final String text;
  final String image;

  final bool delivered;

  Cart({
    this.title,
    this.text,
    this.price,
    this.image,
    this.delivered,
  });
}

List<Cart> cart = [
  Cart(
    title: 'Disaster Management',
    price: '83',
    text: '2 item(s)',
    delivered: false,
    image: 'assets/images/glass.jpg',
  ),
  Cart(
    title: 'Human Embrology',
    price: '450',
    text: '1 item(s)',
    image: 'assets/images/clothes.jpg',
    delivered: true,
  ),

];
