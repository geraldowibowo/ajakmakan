import 'package:ajak_makan/Explore/screens/meal_detail_screen/meal_detail_screen.dart';
import 'package:ajak_makan/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:ajak_makan/providers/basket.dart';
import 'package:intl/intl.dart';

import 'package:ajak_makan/models/res_and_meal.dart';

class OrderSummary extends StatelessWidget {
  final Basket basket;
  final Restaurant loadedRestaurant;

  OrderSummary(this.basket, this.loadedRestaurant);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        color: Colors.grey.withOpacity(0.5),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     RestaurantHomepage.routeName,
                      //     ModalRoute.withName('/'),
                      //     arguments: loadedRestaurant.restaurantId);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Tambah lagi >',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(227, 0, 0, 1)),
                    ),
                  ),
                ],
              ),
              //order summary
              ItemsListViewBuilder(basket, loadedRestaurant),
              TotalCalculation(basket, loadedRestaurant),
            ],
          ),
        ));
  }
}

class ItemsListViewBuilder extends StatelessWidget {
  final Basket basket;
  final Restaurant loadedRestaurant;

  ItemsListViewBuilder(this.basket, this.loadedRestaurant);

  @override
  Widget build(BuildContext context) {
    var formatter =
        NumberFormat.currency(locale: 'eu', decimalDigits: 0, name: '');

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: basket.items.values.length,
        itemBuilder: (ctx, index) => Card(
              elevation: 0,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(MealDetailScreen.routeName,
                      arguments: ResAndMeal(
                          loadedRestaurant,
                          (loadedRestaurant.meals.firstWhere((meal) =>
                              meal.mealId ==
                              basket.items.values.toList()[index].mealId))));
                },
                child: ListTile(
                  leading: Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(width: 0.5, color: Colors.grey)),
                    child: Text(
                      basket.items.values.toList()[index].quantity.toString(),
                      style: TextStyle(
                          color: Color.fromRGBO(227, 0, 0, 1), fontSize: 14),
                    ),
                  ),
                  title: Text(
                    basket.items.values.toList()[index].title.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  subtitle:
                      basket.items.values.toList()[index].catatan.toString() ==
                              ''
                          ? Text('Edit',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(227, 0, 0, 1)))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    basket.items.values
                                        .toList()[index]
                                        .catatan
                                        .toString(),
                                    style: TextStyle(fontSize: 12)),
                                Text('Edit',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(227, 0, 0, 1)))
                              ],
                            ),
                  trailing: Text(
                    formatter.format(basket.items.values.toList()[index].price),
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ));
  }
}

class TotalCalculation extends StatelessWidget {
  final Basket basket;
  final Restaurant loadedRestaurant;

  TotalCalculation(this.basket, this.loadedRestaurant);

  @override
  Widget build(BuildContext context) {
    int subTotal = basket.totalAmount.toInt();

    return Column(
      children: [
        //SUBTOTAL
        SpacedNameAndPrice(amountTitle: 'Subtotal', amount: subTotal),
        //DELIVERY FEE
        SpacedNameAndPrice(
          amountTitle: 'Delviery Fee',
          originalPrice: basket.deliveryFee + 12000,
          amount: basket.deliveryFee,
          color: Color.fromRGBO(227, 0, 0, 1),
        ),
        //ORDER FEE
        SpacedNameAndPrice(amountTitle: 'Order Fee', amount: basket.orderFee),
        //FOOD DISCOUNT
        (basket.merchantDiscountAmount != 0)
            ? SpacedNameAndPrice(
                amountTitle: '${loadedRestaurant.merchantDiscount}% food',
                amount: basket.merchantDiscountAmount,
                color: Color.fromRGBO(227, 0, 0, 1))
            : Container(),
        SpacedNameAndPrice(
          amountTitle: 'Dummy Cashback',
          amount: 9999,
          color: Color.fromRGBO(227, 0, 0, 1),
        ),
        SpacedNameAndPrice(
          amountTitle: 'Dummy Cashback',
          amount: 9999,
          color: Color.fromRGBO(227, 0, 0, 1),
        ),
      ],
    );
  }
}

class SpacedNameAndPrice extends StatelessWidget {
  final String amountTitle;
  final int amount;
  final int originalPrice;
  final Color color;

  SpacedNameAndPrice(
      {@required this.amountTitle,
      @required this.amount,
      this.originalPrice = 0,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    var formatter =
        NumberFormat.currency(locale: 'eu', decimalDigits: 0, name: '');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(amountTitle, style: TextStyle(color: color)),
        originalPrice == 0
            ? Text(formatter.format(amount), style: TextStyle(color: color))
            : Row(
                children: [
                  Text(formatter.format(originalPrice),
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough)),
                  Text(' ${formatter.format(amount)}',
                      style: TextStyle(color: color)),
                ],
              ),
      ],
    );
  }
}

// class MerchantDiscount extends StatelessWidget {
//   final double totalAmount;
//   final Restaurant loadedRestaurant;
//   MerchantDiscount({this.totalAmount, this.loadedRestaurant});
//   @override
//   Widget build(BuildContext context) {
//     int subTotal = totalAmount.toInt();
//     if (subTotal >= loadedRestaurant.minPembelianMD &&
//         (loadedRestaurant.merchantDiscount / 100) * subTotal >=
//             loadedRestaurant.maxDiscountMD) {
//       return SpacedNameAndPrice(
//           amountTitle: '${loadedRestaurant.merchantDiscount}% food',
//           amount: -loadedRestaurant.maxDiscountMD,
//           color: Color.fromRGBO(227, 0, 0, 1));
//     } else if (subTotal >= loadedRestaurant.minPembelianMD &&
//         (loadedRestaurant.merchantDiscount / 100) * subTotal <=
//             loadedRestaurant.maxDiscountMD) {
//       return SpacedNameAndPrice(
//           amountTitle: '${loadedRestaurant.merchantDiscount}% food',
//           amount: -subTotal * loadedRestaurant.merchantDiscount ~/ 100,
//           color: Color.fromRGBO(227, 0, 0, 1));
//     } else {
//       return Container();
//     }
//   }
// }
