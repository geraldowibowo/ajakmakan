import 'package:ajak_makan/Orders/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ajak_makan/models/order.dart';
import 'package:ajak_makan/models/restaurant.dart';

class OrderScreen extends StatefulWidget {
  static const routename = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    CollectionReference orderFirestore =
        FirebaseFirestore.instance.collection('order');

    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Pesanan Saya',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: orderFirestore.snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                var firestoreOrders = snapshot.data.docs.where((element) =>
                    element['customer']['customerUID'] ==
                    _auth.currentUser.uid);

                //TODO: Complete this calling from firestore (gk boleh salah ketik/salah format)
                List<Order> orders = firestoreOrders.map((e) {
                  return Order(
                      date: DateTime.parse(e['date'].toDate().toString()),
                      orderId: e.id,
                      chosenRestaurant: Restaurant(
                        title: e['restaurant']['restaurantTitle'],
                      ),
                      mealQuantity: List.from(e['meals']['mealQuantity']),
                      mealTitle: List.from(e['meals']['mealTitle']),
                      mealPrice: List.from(e['meals']['mealPrice']),
                      mealCatatan: List.from(e['meals']['mealCatatan']),
                      totalAmount: e['totalAmount'],
                      deliveryFee: e['deliveryFee'],
                      orderFee: e['orderFee'],
                      merchantDiscountAmount: e['merchantDiscountAmount'],
                      influencerCashbackAmount: e['influencerCashbackAmount'],
                      partnerCashbackAmount: e['partnerCashbackAmount'],
                      pricePaid: e['pricePaid'],
                      status: e['status']);
                }).toList();
                orders.sort((a, b) => b.date.compareTo(a.date));

                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 150,
                  child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (ctx, index) =>
                          OrderItemCard(orders[index])),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    ));
  }
}
