import 'package:flutter/material.dart';
import 'search_bar.dart';
import 'top_bar.dart';
import 'package:ajak_makan/providers/customer.dart';

class CustomSliverAppBar extends StatelessWidget {
  final MediaQueryData mediaQuery;
  final Customer customerData;

  CustomSliverAppBar(this.mediaQuery, this.customerData);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(children: [
          TopBar(customerData),
          SizedBox(
            height: 50,
          )
        ]),
        centerTitle: false,
        titlePadding: EdgeInsets.all(0),
        title: FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.contain,
          child: SearchBar(mediaQuery),
        ),
      ),
      expandedHeight: 95,
    );
  }
}
