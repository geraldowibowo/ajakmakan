import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/basket.dart' show Basket;

import 'package:ajak_makan/Explore/screens/basket_screen/widget/alamat_pengantaran.dart';
import 'package:ajak_makan/Explore/screens/basket_screen/widget/bottom_order_button.dart';
import 'package:ajak_makan/Explore/screens/basket_screen/widget/order_summary.dart';
import 'package:ajak_makan/Explore/screens/basket_screen/widget/payment_method.dart';

import 'package:ajak_makan/models/restaurant.dart';
import 'package:ajak_makan/providers/customer.dart';

class BasketScreen extends StatelessWidget {
  static const routeName = '/basket';

  @override
  Widget build(BuildContext context) {
    final basket = Provider.of<Basket>(context);

    final loadedRestaurant =
        ModalRoute.of(context).settings.arguments as Restaurant;

    final Customer customerData = Provider.of<Customer>(context);
    if (customerData == null) {
      return Center(child: CircularProgressIndicator());
    }

    void noDataExit() async {
      await Future.delayed(Duration(milliseconds: 100));
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }

    if (basket.items.values.toList().isEmpty) {
      noDataExit();
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            iconSize: 18,
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.black,
          ),
          title: Text(
            loadedRestaurant.title,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  color: Colors.black,
                  size: 18,
                ))
          ],
          elevation: 3,
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AlamatPengantaran(customerData),
            OrderSummary(basket, loadedRestaurant),
            PaymentMethod(),
          ],
        ),
      ),
      floatingActionButton:
          BottomOderButton(basket, loadedRestaurant, customerData),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
