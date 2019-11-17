import 'package:owomark/models/category_item.dart';
import 'package:owomark/models/user_model.dart';

class Message {
  final User sender;
  final String time;
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    this.sender,
    this.text,
    this.time,
    this.isLiked,
    this.unread,
  });
}

//You - Current user

final User currentUser = User(
  id: 0,
  name: 'Current User',
  imageUrl: 'assets/images/greg.jpg',
);

//Category
/*
final Category quiz = Category(
  id: "1",
  name: 'Owoquiz',
  imageUrl: 'assets/images/clothes.jpg',
);

final Category friday = Category(
  id: "1",
  name: 'Friday',
  imageUrl: 'assets/images/glass.jpg',
);

final Category books = Category(
  id: "1",
  name: 'Books',
  imageUrl: 'assets/images/clothes.jpg',
);

final Category wallet = Category(
  id: "1",
  name: 'Wallet',
  imageUrl: 'assets/images/glass.jpg',
);


 */
//Users

final User greg = User(
  id: 1,
  name: 'Greg',
  imageUrl: 'assets/images/greg.jpg',
);

final User james = User(
  id: 2,
  name: 'James',
  imageUrl: 'assets/images/james.jpg',
);

final User john = User(
  id: 3,
  name: 'John',
  imageUrl: 'assets/images/john.jpg',
);

final User olivia = User(
  id: 4,
  name: 'Olivia',
  imageUrl: 'assets/images/olivia.jpg',
);

final User sam = User(
  id: 5,
  name: 'Sam',
  imageUrl: 'assets/images/sam.jpg',
);

final User sophia = User(
  id: 6,
  name: 'Sophia',
  imageUrl: 'assets/images/sophia.jpg',
);

final User steven = User(
  id: 7,
  name: 'Steven',
  imageUrl: 'assets/images/steven.jpg',
);



//FAVIOURITE CONTACTS

List<User> favourite = [sam, olivia, sophia, steven, john];


//Categories

//List<Category> category = [quiz,books,friday,wallet];

List<Message> chats = [
  Message(
    sender: steven,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? wht did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: olivia,
    time: '5:25 PM',
    text: 'I am fine and you',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: sam,
    time: '4:37 PM',
    text: 'owomark is best app for shopping',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: john,
    time: '2:30 PM',
    text: 'Lets catchup today',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: sophia,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? wht did you do today?',
    isLiked: false,
    unread: false,
  ),
];

//EXAMPLE Message in chat screen

List<Message> messages = [
  Message(
    sender: currentUser,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? wht did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: sam,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? wht did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: steven,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? wht did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: john,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? wht did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? wht did you do today?',
    isLiked: false,
    unread: true,
  ),
];
