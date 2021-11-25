import 'package:ajak_makan/models/address.dart';
// import 'package:ajak_makan/models/customer.dart';
import 'package:ajak_makan/models/food_category.dart';
// import 'package:ajak_makan/models/meal.dart';
// import 'package:ajak_makan/models/restaurant.dart';
import 'package:ajak_makan/models/driver.dart';

const DUMMY_CATEGORIES = const [
  FoodCategory(
      id: 'c1',
      title: 'Terbaru',
      imageUrl: 'assets/images/categories/newtaste.jpg'),
  FoodCategory(
      id: 'c2',
      title: 'Terlaris',
      imageUrl: 'assets/images/categories/crowded.jfif'),
  FoodCategory(
      id: 'c3', title: '>40%', imageUrl: 'assets/images/categories/promo.png'),
  FoodCategory(
      id: 'c4',
      title: 'Indonesian',
      imageUrl: 'assets/images/categories/indonesian.jfif'),
  FoodCategory(
      id: 'c5',
      title: 'Chinese',
      imageUrl: 'assets/images/categories/newtaste.jpg'),
  FoodCategory(
      id: 'c6',
      title: 'Western',
      imageUrl: 'assets/images/categories/indonesian.jfif'),
  FoodCategory(
      id: 'c7',
      title: 'Breakfast',
      imageUrl: 'assets/images/categories/newtaste.jpg'),
  FoodCategory(
      id: 'c8',
      title: 'Korean',
      imageUrl: 'assets/images/categories/promo.png'),
  FoodCategory(
      id: 'c9',
      title: 'Japanese',
      imageUrl: 'assets/images/categories/indonesian.jfif'),
  FoodCategory(
      id: 'c10',
      title: 'Drinks',
      imageUrl: 'assets/images/categories/newtaste.jpg'),
];

// ignore: non_constant_identifier_names
// var DUMMY_RESTAURANTS = [
//   Restaurant(
//     restaurantId: 'AROMA9411',
//     title: 'Aroma Pondok Sunda',
//     shortDescription: 'Makanan Sunda terbaik',
//     longDescription:
//         'Super duper enak, mohon dipanaskan sebelum dimakan, lorem ipsum Super duper enak, mohon dipanaskan sebelum dimakan',
//     categories: ['c1', 'c2', 'c4'],
//     meals: [
//       Meal(
//           mealId: 'kentanggorengAROMA9411',
//           title: 'Kentang Goreng',
//           mealCategory: 'Snack',
//           imageUrl:
//               'https://www.willflyforfood.net/wp-content/uploads/2019/06/bebek-unti3.jpg',
//           description: 'Ayam goreng crispy berempah, enak leza mantap',
//           price: 24000,
//           isAvailable: true),
//       Meal(
//           mealId: 'ayamgorengAROMA9411',
//           title: 'Ayam Goreng',
//           imageUrl:
//               'https://www.willflyforfood.net/wp-content/uploads/2019/06/bebek-unti3.jpg',
//           description: 'Ayam goreng crispy berempah, enak leza mantap',
//           price: 24000,
//           isAvailable: true),
//       Meal(
//           mealId: 'tahugorengAROMA9411',
//           title: 'Tahu Goreng',
//           imageUrl:
//               'https://img-global.cpcdn.com/recipes/33285f91f3b22e50/1200x630cq70/photo.jpg',
//           description: 'Tahu goreng crispy berempah, enak leza mantap',
//           price: 5000,
//           isAvailable: true),
//       Meal(
//           mealId: 'nasiputihAROMA9411',
//           title: 'Nasi Putih',
//           mealCategory: 'Minuman',
//           imageUrl:
//               'https://www.lenterabijak.com/wp-content/uploads/2020/08/nasi-putih.jpg',
//           description: 'Nasi Putih pulen',
//           price: 5000,
//           isAvailable: true),
//       Meal(
//           mealId: 'esTEHAROMA9411',
//           title: 'es teh manis',
//           mealCategory: 'Minuman',
//           imageUrl:
//               'https://www.lenterabijak.com/wp-content/uploads/2020/08/nasi-putih.jpg',
//           description: 'Nasi Putih pulen',
//           price: 5000,
//           isAvailable: true),
//       Meal(
//           mealId: 'eskrimAROMA9411',
//           title: 'Eskrim',
//           mealCategory: 'Dessert',
//           imageUrl:
//               'https://www.lenterabijak.com/wp-content/uploads/2020/08/nasi-putih.jpg',
//           description: 'Nasi Putih pulen',
//           price: 5000,
//           isAvailable: true),
//       Meal(
//           mealId: 'coklatAROMA9411',
//           title: 'Kue Putih',
//           mealCategory: 'Dessert',
//           imageUrl:
//               'https://www.lenterabijak.com/wp-content/uploads/2020/08/nasi-putih.jpg',
//           description: 'Nasi Putih pulen',
//           price: 5000,
//           isAvailable: true),
//       Meal(
//           mealId: 'DonutAROMA9411',
//           title: 'Donut Coklat',
//           mealCategory: 'Dessert',
//           imageUrl:
//               'https://www.lenterabijak.com/wp-content/uploads/2020/08/nasi-putih.jpg',
//           description: 'Nasi Putih pulen',
//           price: 5000,
//           isAvailable: true),
//     ],
//     restaurantAddress: Address(
//         addressLine1: 'Bojong Timur Indah',
//         addressLine2: 'Blok A8 No.14',
//         addressDescription: 'Pagar Hitam',
//         latitude: -6.173286,
//         longitude: 106.680575),
//     minPembelianMD: 20000,
//     maxDiscountMD: 10000,
//     merchantDiscount: 20,
//     minPembelianIC: 30000,
//     maxCashbackIC: 15000,
//     influencerCashback: 30,
//     minPembelianPC: 45000,
//     maxCashbackPC: 13000,
//     partnerCashback: 15,
//     isOpen: true,
//   ),
//   Restaurant(
//     restaurantId: 'A653',
//     title: 'A & W Family Daan Mogot',
//     shortDescription: 'All american food',
//     longDescription: 'If you wish, just order it',
//     thumbnailImage:
//         'https://www.hargaria.com/wp-content/uploads/harga-menu-aw-terkini.jpg',
//     categories: ['c1', 'c3', 'c5'],
//     meals: [
//       Meal(
//           mealId: 'friedChickenA653',
//           title: 'Fried Chicken',
//           imageUrl:
//               'https://vagusnet.com/wp-content/uploads/2021/08/fried-chicken.jpg',
//           description: 'The best american chicken',
//           price: 35000,
//           isAvailable: true),
//       Meal(
//           mealId: 'friesA653',
//           title: 'Fries',
//           imageUrl:
//               'http://www.jakartaracing.com/wp-content/uploads/2015/12/french-fries.jpg',
//           description: 'Crispy delicious fries',
//           price: 12000,
//           isAvailable: true),
//     ],
//     restaurantAddress: Address(
//         addressLine1: 'Kelapa botak 8',
//         addressLine2: 'Lantai 8, no.3',
//         addressDescription: 'Rame lah pokoknya',
//         latitude: -6.135993,
//         longitude: 106.688415),
//     merchantDiscount: 15,
//     influencerCashback: 15,
//     partnerCashback: 10,
//     isOpen: true,
//   ),
//   Restaurant(
//     restaurantId: 'A654',
//     title: 'A & W Family Puri',
//     shortDescription: 'All american food',
//     longDescription: 'If you wish, just order it',
//     thumbnailImage:
//         'https://www.hargaria.com/wp-content/uploads/harga-menu-aw-terkini.jpg',
//     categories: ['c1', 'c3', 'c5'],
//     meals: [
//       Meal(
//           mealId: 'friedChickenA654',
//           title: 'Fried Chicken',
//           imageUrl:
//               'https://vagusnet.com/wp-content/uploads/2021/08/fried-chicken.jpg',
//           description: 'The best american chicken',
//           price: 35000,
//           isAvailable: true),
//       Meal(
//           mealId: 'friesA654',
//           title: 'Fries',
//           imageUrl:
//               'http://www.jakartaracing.com/wp-content/uploads/2015/12/french-fries.jpg',
//           description: 'Crispy delicious fries',
//           price: 12000,
//           isAvailable: true),
//     ],
//     restaurantAddress: Address(
//         addressLine1: 'Kelapa botak 8',
//         addressLine2: 'Lantai 8, no.3',
//         addressDescription: 'Rame lah pokoknya',
//         latitude: -6.135993,
//         longitude: 106.688415),
//     merchantDiscount: 15,
//     influencerCashback: 15,
//     partnerCashback: 10,
//     isOpen: true,
//   ),
//   Restaurant(
//     restaurantId: 'A655',
//     title: 'A & W Family Pecenongan',
//     shortDescription: 'All american food',
//     longDescription: 'If you wish, just order it',
//     thumbnailImage: 'https://biaya.info/wp-content/uploads/2021/04/AW.jpg',
//     categories: ['c1', 'c3', 'c5'],
//     meals: [
//       Meal(
//           mealId: 'friedChickenA655',
//           title: 'Fried Chicken',
//           imageUrl:
//               'https://vagusnet.com/wp-content/uploads/2021/08/fried-chicken.jpg',
//           description: 'The best american chicken',
//           price: 35000,
//           isAvailable: true),
//       Meal(
//           mealId: 'friesA655',
//           title: 'Fries',
//           imageUrl:
//               'http://www.jakartaracing.com/wp-content/uploads/2015/12/french-fries.jpg',
//           description: 'Crispy delicious fries',
//           price: 12000,
//           isAvailable: true),
//     ],
//     restaurantAddress: Address(
//         addressLine1: 'Kelapa botak 8',
//         addressLine2: 'Lantai 8, no.3',
//         addressDescription: 'Rame lah pokoknya',
//         latitude: -6.135993,
//         longitude: 106.688415),
//     merchantDiscount: 15,
//     influencerCashback: 15,
//     partnerCashback: 10,
//     isOpen: true,
//   ),
//   Restaurant(
//     restaurantId: 'A635',
//     title: 'A & W Family Puri',
//     shortDescription: 'All american food',
//     longDescription: 'If you wish, just order it',
//     thumbnailImage:
//         'https://cdn-2.tstatic.net/kaltim/foto/bank/images/aw-restoran-balikpapan.jpg',
//     categories: ['c1', 'c3', 'c5'],
//     meals: [
//       Meal(
//           mealId: 'friedChickenA635',
//           title: 'Fried Chicken',
//           imageUrl:
//               'https://vagusnet.com/wp-content/uploads/2021/08/fried-chicken.jpg',
//           description: 'The best american chicken',
//           price: 35000,
//           isAvailable: true),
//       Meal(
//           mealId: 'friesA635',
//           title: 'Fries',
//           imageUrl:
//               'http://www.jakartaracing.com/wp-content/uploads/2015/12/french-fries.jpg',
//           description: 'Crispy delicious fries',
//           price: 12000,
//           isAvailable: true),
//     ],
//     restaurantAddress: Address(
//         addressLine1: 'Kelapa botak 8',
//         addressLine2: 'Lantai 8, no.3',
//         addressDescription: 'Rame lah pokoknya',
//         latitude: -6.135993,
//         longitude: 106.688415),
//     merchantDiscount: 15,
//     influencerCashback: 15,
//     partnerCashback: 10,
//     isOpen: true,
//   ),
// ];

// ignore: non_constant_identifier_names
// var DUMMY_CUSTOMERS = [
//   Customer(
//       customerId: 'geraldowibowo',
//       name: 'Geraldo Wibowo',
//       phoneNumber: '081385179578',
//       points: 15000,
//       customerAddress: Address(
//         addressLine1: 'Budi Indah',
//         addressLine2: 'Blok C No.35',
//         latitude: -6.162169,
//         longitude: 106.680589,
//         addressDescription: 'deket pangkalan ojek',
//       )),
//   Customer(
//       customerId: 'andisutiyoso',
//       name: 'Andi Sutiyoso',
//       phoneNumber: '081385179500',
//       points: 5000,
//       customerAddress: Address(
//         addressLine1: 'Kupang Indah',
//         addressLine2: 'Blok D Jl. kesenengan',
//         latitude: -6.137935,
//         longitude: 106.694145,
//         addressDescription: 'daerah situlah pokoknya',
//       )),
//   Customer(
//       customerId: 'budihartanto',
//       name: 'Budi Ganteng',
//       phoneNumber: '081385189578',
//       points: 3000,
//       customerAddress: Address(
//         addressLine1: 'Indomaret',
//         addressLine2: 'Warung gantung',
//         latitude: -6.136527,
//         longitude: 106.683394,
//         addressDescription: 'pagar putih',
//       )),
// ];

// ignore: non_constant_identifier_names
var DUMMY_DRIVERS = [
  Driver(
      driverId: 'sitompul71',
      driverName: 'Sitompul',
      driverPhoneNumber: '081354687854',
      driverProfilePicture:
          'https://i.pinimg.com/236x/1f/25/5d/1f255d7f9cf3afe7cd9cd97626d08fbf.jpg',
      driverAddress: Address(
          addressLine1: 'Driver\'s Address',
          latitude: -6.143546,
          longitude: 106.682557),
      isAvailable: true),
  Driver(
      driverId: 'cihuy32',
      driverName: 'Cihuy',
      driverPhoneNumber: '081354685854',
      driverProfilePicture:
          'https://i.pinimg.com/236x/1f/25/5d/1f255d7f9cf3afe7cd9cd97626d08fbf.jpg',
      driverAddress: Address(
          addressLine1: 'Driver\'s Address',
          latitude: -6.157733,
          longitude: 106.701601),
      isAvailable: true)
];
