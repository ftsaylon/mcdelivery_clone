import 'package:mcdelivery_clone/models/category.dart';
import 'package:uuid/uuid.dart';

import 'providers/product.dart';

var dummyCategories = [
  Category(
    id: 'c1',
    title: 'Chicken',
  ),
  Category(
    id: 'c2',
    title: 'Fries and Pasta',
  ),
  Category(
    id: 'c3',
    title: 'Burgers and Sandwiches',
  ),
  Category(
    id: 'c4',
    title: 'Spicy Chicken McDo',
  ),
  Category(
    id: 'c5',
    title: 'McShare Box',
  ),
  Category(
    id: 'c6',
    title: 'Drinks and Desserts',
  ),
  Category(
    id: 'c7',
    title: 'Extras',
  ),
];

var dummyProducts = [
  Product(
    id: Uuid().v1(),
    title: '2pc Chicken McDo',
    categoryId: 'c1',
    description:
        '2 pieces of our crispy and juicy Chicken McDo with rice and gravy. Choose from Original or Spicy chicken',
    price: 150,
    imageUrl:
        'https://mcdelivery.com.ph/uploads/images/2pcChickenMcDomeal435X320-V1.png',
  ),
  Product(
    id: Uuid().v1(),
    title: 'McCrispy Chicken Fillet',
    categoryId: 'c1',
    description: 'Our crispy chicken fillet served with rice and gravy',
    price: 59,
    imageUrl:
        'https://mcdelivery.com.ph/uploads/images/ChickenFilletNew+Rice-435x320-V1.png',
  ),
  Product(
    id: Uuid().v1(),
    title: '1pc Chicken McDo',
    categoryId: 'c1',
    description:
        'Crispy and juicy Chicken McDo served with rice and gravy. Choose from Original or Spicy chicken',
    price: 75,
    imageUrl:
        'https://mcdelivery.com.ph/uploads/images/1-pc.-Chicken-McDo-with-Rice-&-Fries-ala435X320-V1.png',
  ),
  Product(
    id: Uuid().v1(),
    title: 'BFF Fries',
    categoryId: 'c2',
    description:
        'Our World Famous Fries, served hot and crispy. Good for 3-4 persons.',
    price: 134,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Fries',
    categoryId: 'c2',
    description: 'Our World Famous Fries, served hot and crispy.',
    price: 42,
  ),
  Product(
    id: Uuid().v1(),
    title: 'BFF Shake Shake Fries',
    categoryId: 'c2',
    description:
        'BFF-sized World Famous Fries served with a packet of savory Cheese and BBQ powder/flavoring',
    price: 149,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Shake Shake Fries',
    categoryId: 'c2',
    description:
        'Medium-sized World Famous Fries served with a packet of savory Cheese and BBQ powder/flavoring',
    price: 65,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Large Shake Shake Fries',
    categoryId: 'c2',
    description:
        'Larged-sized World Famous Fries served with a packet of savory Cheese and BBQ powder/flavoring',
    price: 87,
  ),
  Product(
    id: Uuid().v1(),
    title: 'McCrispy Chicken Fillet Sandwich',
    categoryId: 'c3',
    description:
        'Our crispy chicken fillet with mayo sandwiched between toasted buns',
    price: 45,
  ),
  Product(
    id: Uuid().v1(),
    title: '1pc Spicy Chicken McDo',
    categoryId: 'c4',
    description:
        'A spicy and delicious take on our 1-pc Chicken McDo. Served with gravy and rice',
    price: 78,
  ),
  Product(
    id: Uuid().v1(),
    title: '1pc Spicy Chicken McDo with Fries',
    categoryId: 'c4',
    description:
        'A spicy and delicious take on our 1-pc Chicken McDo. Served with fries, gravy, rice, and medium drink',
    price: 133,
  ),
  Product(
    id: Uuid().v1(),
    title: 'McShare Box',
    categoryId: 'c5',
    description:
        '8 pcs of our crispy and juicy Chicken McDo served with gravy. Choose from Original or Spicy chicken',
    price: 510,
  ),
  Product(
    id: Uuid().v1(),
    title: 'McShare Box 6pc Chicken',
    categoryId: 'c5',
    description:
        '6 pcs of our crispy and juicy Chicken McDo served with gravy. Choose from Original or Spicy chicken',
    price: 390,
  ),
  Product(
    id: Uuid().v1(),
    title: 'McShare Box 4pc Spicy 4pc Original',
    categoryId: 'c5',
    description: '',
    price: 510,
  ),
  Product(
    id: Uuid().v1(),
    title: 'McShare Box 3pc Spicy 3pc Original',
    categoryId: 'c5',
    description: '',
    price: 399,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Coke',
    categoryId: 'c6',
    description: '',
    price: 58,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Sprite',
    categoryId: 'c6',
    description: '',
    price: 58,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Apple Pie',
    categoryId: 'c6',
    description:
        'Our deliciously sweet Apple pie, with a crispy crust and a chunky filling of Apples and cinnamon',
    price: 37,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Iced Coffee Sweet Black',
    categoryId: 'c6',
    description:
        'Made with 100% Arabica beans - our refreshing, sweetened Premium Roast Iced Coffee',
    price: 39,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Coke Zero',
    categoryId: 'c6',
    description: '',
    price: 58,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Iced Coffee Milky with Chocolate',
    categoryId: 'c6',
    description:
        'Your favorite Iced Coffee Milky blend, with a delicious boost of Chocolate',
    price: 59,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Pineapple Juice',
    categoryId: 'c6',
    description: '',
    price: 61,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Iced Coffee Sweet Black with Chocolate',
    categoryId: 'c6',
    description:
        'Your favorite Iced Coffee Sweet Black, with a delicious boost of Chocolate',
    price: 49,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Iced Coffee Chocolate',
    categoryId: 'c6',
    description:
        'Your favorite Iced Coffee Original blend, with a delicious boost of Chocolate',
    price: 49,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Iced Coffee Milky',
    categoryId: 'c6',
    description:
        'Made with 100% Arabica beans - our refreshing, sweetened Premium Roast Iced Coffee made creamy with double the milk',
    price: 49,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Iced Tea',
    categoryId: 'c6',
    description: '',
    price: 61,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Iced Coffee Milky with Vanilla',
    categoryId: 'c6',
    description: '',
    price: 59,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Iced Coffee Sweet Black with Vanilla',
    categoryId: 'c6',
    description: '',
    price: 49,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Iced Coffee Original with Vanilla',
    categoryId: 'c6',
    description: '',
    price: 49,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Hot Chocolate',
    categoryId: 'c6',
    description: '',
    price: 37,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Premium Roast Coffee',
    categoryId: 'c6',
    description:
        'Made with 100% Arabica beans - our premium roast coffee served hot',
    price: 58,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Extra Plain Rice',
    categoryId: 'c7',
    description: '',
    price: 25,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Extra Garlic Rice',
    categoryId: 'c7',
    description: '',
    price: 28,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Extra Anchor Butter',
    categoryId: 'c7',
    description: '',
    price: 10,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Extra Mayonnaise',
    categoryId: 'c7',
    description: '',
    price: 15,
  ),
  Product(
    id: Uuid().v1(),
    title: 'Extra Gravy',
    categoryId: 'c7',
    description: '',
    price: 10,
  ),
];
