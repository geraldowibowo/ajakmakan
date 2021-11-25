import 'package:flutter/material.dart';
import 'package:ajak_makan/models/order.dart';
import 'package:intl/intl.dart';

class OrderItemCard extends StatelessWidget {
  final Order order;

  OrderItemCard(this.order);

  @override
  Widget build(BuildContext context) {
    String orderStatus = 'unknown';
    if (order.status == 'findingDriver') {
      orderStatus = 'status: mencari driver';
    }

    var formatter =
        NumberFormat.currency(locale: 'eu', decimalDigits: 0, name: '');

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('HH:mm').format(order.date),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              Text(DateFormat('dd MMM').format(order.date)),
            ],
          ),
          title: Text(
            order.chosenRestaurant.title,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${order.mealQuantity.fold(0, (p, c) => p + c)} item(s)'),
              Text(orderStatus),
            ],
          ),
          trailing: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatter.format(order.pricePaid),
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                order.partnerCashbackAmount > 0
                    ? Text(
                        '+PC ${formatter.format(order.partnerCashbackAmount)}')
                    : Container(),
                order.influencerCashbackAmount > 0
                    ? Text(
                        '+IC ${formatter.format(order.influencerCashbackAmount)}')
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
