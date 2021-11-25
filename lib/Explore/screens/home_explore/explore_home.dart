import '../home_explore/ads_slider.dart';
import '../home_explore/categories.dart';
import '../home_explore/custom_app_bar/custom_sliver_app_bar.dart';
import './explore_choices.dart';
import 'package:flutter/material.dart';
import 'package:ajak_makan/providers/customer.dart';
import 'package:provider/provider.dart';

class ExploreHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    Customer customerData = Provider.of<Customer>(context);
    if (customerData == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          CustomSliverAppBar(mediaQuery, customerData),
          buildContents(mediaQuery, customerData),
        ],
      ),
    );
  }
}

Widget buildContents(mediaQuery, customerData) => SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SLIDER
          AdsSlider(mediaQuery),
          Categories(mediaQuery),
          ExploreChoices(mediaQuery, customerData),
        ],
      ),
    );
