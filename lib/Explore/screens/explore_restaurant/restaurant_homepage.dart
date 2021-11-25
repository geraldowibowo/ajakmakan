import 'package:ajak_makan/Explore/screens/basket_screen/basket_screen.dart';
import 'package:ajak_makan/models/address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '/providers/basket.dart';
import '/Explore/screens/explore_restaurant/restaurant_sliver_app_bar/restaurant_sliver_bar.dart';
import 'restaurant_meal_choices.dart';
import 'package:ajak_makan/models/restaurant.dart';
import 'package:ajak_makan/models/meal.dart';

class RestaurantHomepage extends StatefulWidget {
  static const routeName = '/restaurant-page';

  @override
  _RestaurantHomepageState createState() => _RestaurantHomepageState();
}

double scrollLocation = 0;

class _RestaurantHomepageState extends State<RestaurantHomepage> {
  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot loadedArguments =
        ModalRoute.of(context).settings.arguments;

    // final loadedRestaurant =
    //     Provider.of<RestaurantsProvider>(context, listen: false)
    //         .findById(restaurantId);
    final basketContents = Provider.of<Basket>(context);
    ScrollController scrollController = ScrollController();

    Restaurant loadedRestaurant = Restaurant(
      title: loadedArguments['title'],
      categories: List.from(loadedArguments['categories']),
      restaurantId: loadedArguments['restaurantId'],
      shortDescription: loadedArguments['shortDescription'],
      longDescription: loadedArguments['longDescription'],
      isOpen: loadedArguments['isOpen'],
      merchantDiscount: loadedArguments['merchantDiscount'],
      minPembelianMD: loadedArguments['minPembelianMD'],
      maxDiscountMD: loadedArguments['maxDiscountMD'],
      influencerCashback: loadedArguments['influencerCashback'],
      minPembelianIC: loadedArguments['minPembelianIC'],
      maxCashbackIC: loadedArguments['maxCashbackIC'],
      partnerCashback: loadedArguments['partnerCashback'],
      minPembelianPC: loadedArguments['minPembelianPC'],
      maxCashbackPC: loadedArguments['maxCashbackPC'],
      restaurantAddress: Address(
        addressLine1: loadedArguments['restaurantAddress']['addressLine1'],
        addressLine2: loadedArguments['restaurantAddress']['addressLine2'],
        addressDescription: loadedArguments['restaurantAddress']
            ['addressDescription'],
        latitude: loadedArguments['restaurantAddress']['geolocation'].latitude,
        longitude:
            loadedArguments['restaurantAddress']['geolocation'].longitude,
      ),
      meals: List.from(loadedArguments['Meal'].map((meal) {
        return Meal(
          title: meal['title'],
          mealId: meal['mealId'],
          price: meal['price'],
          description: meal['description'],
          mealCategory: meal['mealCategory'],
          isAvailable: meal['isAvailable'],
        );
      })),
    );

    return SafeArea(
      child: Scaffold(
        body: NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            //TODO: make a dropdown button for faster page navigation
            // setState(() {
            //   scrollLocation = notification.metrics.pixels;
            // });

            return true;
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              RestaurantSliverAppBar(loadedRestaurant, scrollLocation),
              buildContents(loadedRestaurant),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: (basketContents.items.values.toList().length == 0)
            ? null
            : ToBasketBottomButton(basketContents, loadedRestaurant),
      ),
    );
  }
}

Widget buildContents(loadedRestaurant) =>
    SliverToBoxAdapter(child: RestaurantMealChoices(loadedRestaurant));

class ToBasketBottomButton extends StatelessWidget {
  final Basket basketContents;
  final Restaurant loadedRestaurant;

  ToBasketBottomButton(this.basketContents, this.loadedRestaurant);

  @override
  Widget build(BuildContext context) {
    int basketItemCount = 0;
    basketContents.items.forEach((key, value) {
      basketItemCount += value.quantity;
    });

    int basketPrice = basketContents.totalAmount.toInt();

    var formatter =
        NumberFormat.currency(locale: 'eu', decimalDigits: 0, name: '');
    String basketPriceToDisplay = formatter.format(basketPrice);

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

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TAMBAHAN

          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: (godaanBuatDiskon == '')
                ? null
                : Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text(
                      godaanBuatDiskon,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color.fromRGBO(227, 0, 0, 1),
                      ),
                    ),
                  ),
          ),
          //BUTTON
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).pushNamed(BasketScreen.routeName,
                  arguments: loadedRestaurant);
            },
            backgroundColor: Color.fromRGBO(227, 0, 0, 1),
            label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //BASKET & NUMBER OF ITEMS
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Basket',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(Icons.circle,
                                    color: Colors.white, size: 5),
                              ),
                              Text('$basketItemCount Items')
                            ],
                          ),
                          // Text('Pesan Antar Instan', style: TextStyle(fontSize: 8))
                        ],
                      ),
                    ),
                  ),
                  (basketPrice < sortedKeys[0].value)
                      ? Text('$basketPriceToDisplay >>')
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.36,
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text('$basketPriceToDisplay- Disc. >>')),
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
