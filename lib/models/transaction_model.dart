class Transactions {
  final String title;
  final String price;
  final String text;

  final bool delivered;

  Transactions({
    this.title,
    this.text,
    this.price,
    this.delivered,
  });
}

List<Transactions> transactions = [
  Transactions(
    title: 'Money debited from wallet',
    price: '210',
    text: 'On 05/11/2019',
    delivered: false,
  ),
  Transactions(
    title: 'Money added to wallet',
    price: '450',
    text: 'On 27/10/2019',
    delivered: true,
  ),
  Transactions(
    title: 'Money added to wallet',
    price: '780',
    text: 'On 17/10/2019',
    delivered: true,
  ),
  Transactions(
    title: 'Money debited from wallet',
    price: '345',
    text: 'On 05/10/2019',
    delivered: false,
  ),
  Transactions(
    title: 'Money added to wallet',
    price: '345',
    text: 'On 05/10/2019',
    delivered: true,
  ),
];
