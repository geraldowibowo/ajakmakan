import 'package:ajak_makan/models/address.dart';
import 'package:ajak_makan/models/meal.dart';

class Restaurant {
  final String restaurantId;
  final String title;
  final String phone;
  final String email;
  final String shortDescription;
  final String longDescription;
  final String thumbnailImage;
  final String coverImage;
  final List<String> categories;
  final List<Meal> meals;
  final Address restaurantAddress;
  final int merchantDiscount;
  final int minPembelianMD;
  final int maxDiscountMD;
  final int influencerCashback;
  final int minPembelianIC;
  final int maxCashbackIC;
  final int partnerCashback;
  final int minPembelianPC;
  final int maxCashbackPC;
  final bool isOpen;

  Restaurant({
    this.restaurantId,
    this.title,
    this.phone = '',
    this.email = '',
    this.shortDescription = '',
    this.longDescription = '',
    this.thumbnailImage =
        'https://static01.nyt.com/images/2021/01/26/well/well-foods-microbiome/well-foods-microbiome-superJumbo.jpg',
    this.coverImage =
        'https://thefatkidinside.com/wp-content/uploads/2019/08/jakarta-header-716x375.jpg',
    this.categories = const [],
    this.meals,
    this.restaurantAddress,
    this.merchantDiscount = 0,
    this.minPembelianMD = 0,
    this.maxDiscountMD = 999999,
    this.influencerCashback = 0,
    this.minPembelianIC = 0,
    this.maxCashbackIC = 999999,
    this.partnerCashback = 0,
    this.minPembelianPC = 0,
    this.maxCashbackPC = 999999,
    this.isOpen,
  });
}
