import 'package:ajak_makan/models/restaurant.dart';
import 'package:ajak_makan/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ajak_makan/providers/basket.dart';
import 'package:ajak_makan/providers/order.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:ajak_makan/providers/customer.dart';

class BottomOderButton extends StatelessWidget {
  final Basket basket;
  final Restaurant loadedRestaurant;
  final Customer customerData;

  BottomOderButton(this.basket, this.loadedRestaurant, this.customerData);

  @override
  Widget build(BuildContext context) {
    if (basket.items.values.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final _auth = FirebaseAuth.instance;

    int basketPrice = basket.totalAmount.toInt();

    var formatter =
        NumberFormat.currency(locale: 'eu', decimalDigits: 0, name: '');

    Map<String, int> minimumAmountToDiscount = {
      'lagi untuk ${loadedRestaurant.merchantDiscount}% food discount':
          loadedRestaurant.minPembelianMD,
      'lagi untuk ${loadedRestaurant.influencerCashback}% cashback temanmu':
          loadedRestaurant.minPembelianIC,
      'lagi untuk ${loadedRestaurant.partnerCashback}%  cashback kamu':
          loadedRestaurant.minPembelianPC,
    };

    var sortedKeys = minimumAmountToDiscount.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    String godaanBuatDiskon = '';

    if (basketPrice < sortedKeys[0].value) {
      godaanBuatDiskon =
          'Nambah ${formatter.format(sortedKeys[0].value - basketPrice)}${sortedKeys[0].key}, Nambah ${formatter.format(sortedKeys[1].value - basketPrice)}${sortedKeys[1].key}, Nambah ${formatter.format(sortedKeys[2].value - basketPrice)}${sortedKeys[2].key}';
    } else if (basketPrice < sortedKeys[1].value) {
      godaanBuatDiskon =
          'Nambah ${formatter.format(sortedKeys[1].value - basketPrice)}${sortedKeys[1].key}, Nambah ${formatter.format(sortedKeys[2].value - basketPrice)}${sortedKeys[2].key}';
    } else if (basketPrice < sortedKeys[2].value) {
      godaanBuatDiskon =
          'Nambah ${formatter.format(sortedKeys[2].value - basketPrice)}${sortedKeys[2].key}';
    }

    void orderSubmitted() async {
      await Future.delayed(Duration(milliseconds: 100));
      Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
      basket.clear();
    }

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TAMBAHAN
          Padding(
            padding: const EdgeInsets.only(bottom: 3, left: 15),
            child: (godaanBuatDiskon == '')
                ? null
                : Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      godaanBuatDiskon,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color.fromRGBO(230, 0, 0, 1),
                      ),
                    ),
                  ),
          ),
          //BUTTON
          FloatingActionButton.extended(
            onPressed: () {
              OrderDataBaseService(_auth.currentUser.uid)
                  .addOrder(
                date: DateTime.now(),
                customer: customerData,
                chosenRestaurant: loadedRestaurant,
                orderId: basket.items.values.last.orderId,
                mealQuantity:
                    basket.items.values.map((e) => e.quantity).toList(),
                mealId: basket.items.values.map((e) => e.mealId).toList(),
                mealTitle: basket.items.values.map((e) => e.title).toList(),
                mealCatatan: basket.items.values.map((e) => e.catatan).toList(),
                mealPrice: basket.items.values.map((e) => e.price).toList(),
                totalAmount: basket.totalAmount.toInt(),
                merchantDiscountAmount: basket.merchantDiscountAmount,
                partnerCashbackAmount: 99999, //STILL DUMMY
                influencerCashbackAmount: 99999, //STILL DUMMY
                deliveryFee: basket.deliveryFee,
                orderFee: basket.orderFee,
                pricePaid: basket.priceToPay,
              )
                  .then((value) {
                orderSubmitted();
              });
            },
            backgroundColor: Color.fromRGBO(227, 0, 0, 1),
            label: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                child: FittedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("PESAN SEKARANG - "),
                      (basket.totalAmount +
                                  basket.deliveryFee +
                                  basket.orderFee) >
                              (basket.priceToPay)
                          ? Text(
                              '${formatter.format(basket.totalAmount + basket.deliveryFee + basket.orderFee)}',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w300),
                            )
                          : Container(),
                      Text(
                        '  ${formatter.format(basket.priceToPay)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
