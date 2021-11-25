import 'package:ajak_makan/models/restaurant.dart';
import 'package:ajak_makan/providers/customer.dart';

class Order {
  DateTime date;
  Customer customer;
  Restaurant chosenRestaurant;
  String orderId;
  List<int> mealQuantity;
  List<String> mealId;
  List<String> mealTitle;
  List<String> mealCatatan;
  List<int> mealPrice;
  int totalAmount;
  int merchantDiscountAmount;
  int partnerCashbackAmount;
  int influencerCashbackAmount;
  int deliveryFee;
  int orderFee;
  int pricePaid;
  String status;

  Order({
    this.date,
    this.customer,
    this.chosenRestaurant,
    this.orderId,
    this.mealQuantity,
    this.mealId,
    this.mealTitle,
    this.mealCatatan,
    this.mealPrice,
    this.totalAmount,
    this.merchantDiscountAmount,
    this.partnerCashbackAmount,
    this.influencerCashbackAmount,
    this.deliveryFee,
    this.orderFee,
    this.pricePaid,
    this.status,
  });
}
