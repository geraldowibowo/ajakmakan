import 'package:flutter/material.dart';
import 'package:ajak_makan/models/restaurant.dart';
import '../restaurant_meal_choices.dart';

class RestaurantSliverAppBar extends StatelessWidget {
  final Restaurant loadedRestaurant;
  final double scrollLocation;

  RestaurantSliverAppBar(this.loadedRestaurant, this.scrollLocation);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SliverAppBar(
      leading: Container(),
      backgroundColor: Colors.white,
      collapsedHeight: 85,
      shadowColor: Colors.black,
      elevation: 3,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: mediaQuery.size.width * 3 / 4,
              width: double.infinity,
              child: Image.network(
                loadedRestaurant.coverImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: mediaQuery.size.width * 3 / 4 - 30, left: 20, right: 20),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    alignment: Alignment.center,
                    height: 180,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RestaurantTitle(
                            loadedRestaurant: loadedRestaurant, fontSize: 24),
                        RatingsAndOpeningInfo(loadedRestaurant),
                        BottomRestaurantDiscountText(loadedRestaurant),
                        DeliveryInfo(loadedRestaurant),
                        LongDescription(loadedRestaurant.longDescription),
                      ],
                    )),
              ),
            ),
            //BACK BUTTON
            Positioned(
              top: 5,
              left: 5,
              child: IconButton(
                icon: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.6),
                    radius: 13,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white.withOpacity(0.9),
                      size: 15,
                    )),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            //SEARCH BUTTOn
            Positioned(
              top: 5,
              right: 40,
              child: IconButton(
                icon: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.6),
                    radius: 15,
                    child: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.9),
                      size: 20,
                    )),
                onPressed: () {},
              ),
            ),
            //SHARE BUTTON
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                icon: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.6),
                    radius: 15,
                    child: Icon(
                      Icons.share,
                      color: Colors.white.withOpacity(0.9),
                      size: 18,
                    )),
                onPressed: () {},
              ),
            ),
          ],
        ),
        title: MiniAppBar(loadedRestaurant, scrollLocation),
        titlePadding: EdgeInsets.all(0),
        centerTitle: false,
      ),
      expandedHeight: mediaQuery.size.width * 3 / 4 + 157,
    );
  }
}

class RestaurantTitle extends StatelessWidget {
  final Restaurant loadedRestaurant;
  final double fontSize;

  RestaurantTitle({@required this.loadedRestaurant, this.fontSize: 16});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 8),
        child: Text(
          loadedRestaurant.title,
          style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontFamily: 'Roboto Condensed',
              fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  }
}

class RatingsAndOpeningInfo extends StatelessWidget {
  final Restaurant loadedRestaurant;

  RatingsAndOpeningInfo(this.loadedRestaurant);
  @override
  Widget build(BuildContext context) {
    String openStatus;
    if (loadedRestaurant.isOpen) {
      openStatus = 'Pesan Antar Instant';
    } else {
      openStatus = 'Merchant tutup';
    }

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(width: 6),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 8),
          child: Image.asset(
            'assets/images/Star 1.png',
            height: 14,
          ),
        ),
        Text(
          '5 | $openStatus',
          style: TextStyle(fontSize: 14, color: Colors.black),
        )
      ]),
    );
  }
}

class BottomRestaurantDiscountText extends StatelessWidget {
  final Restaurant loadedRestaurant;

  BottomRestaurantDiscountText(this.loadedRestaurant);
  @override
  Widget build(BuildContext context) {
    Map<String, int> displayedDiscount = {
      'food': loadedRestaurant.merchantDiscount,
      'friend': loadedRestaurant.influencerCashback,
      'cashback': loadedRestaurant.partnerCashback,
    };

    var sortedKeys = displayedDiscount.keys.toList()..sort();

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(width: 6),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 8),
          child: Image.asset(
            'assets/images/disc.png',
            height: 14,
          ),
        ),
        Text(
          '${displayedDiscount[sortedKeys[2]]}% ',
          style: TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(227, 0, 0, 1),
              fontWeight: FontWeight.bold),
        ),
        Text(
          '${sortedKeys[2]} + ',
          style: TextStyle(fontSize: 14, color: Color.fromRGBO(227, 0, 0, 1)),
        ),
        Text(
          '${displayedDiscount[sortedKeys[1]]}% ',
          style: TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(227, 0, 0, 1),
              fontWeight: FontWeight.bold),
        ),
        Text(
          '${sortedKeys[1]} + ',
          style: TextStyle(fontSize: 14, color: Color.fromRGBO(227, 0, 0, 1)),
        ),
        Text(
          '${displayedDiscount[sortedKeys[0]]}% ',
          style: TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(227, 0, 0, 1),
              fontWeight: FontWeight.bold),
        ),
        Text(
          '${sortedKeys[0]}',
          style: TextStyle(fontSize: 14, color: Color.fromRGBO(227, 0, 0, 1)),
        ),
      ]),
    );
  }
}

class DeliveryInfo extends StatelessWidget {
  final Restaurant loadedRestaurant;

  DeliveryInfo(this.loadedRestaurant);
  @override
  Widget build(BuildContext context) {
    String menit = '99 menit';
    String harga = '9.999';

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(width: 6),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 8),
          child: Image.asset(
            'assets/images/motor.png',
            height: 14,
          ),
        ),
        Text(
          'Diantar dalam $menit | $harga',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ]),
    );
  }
}

class LongDescription extends StatelessWidget {
  final String longDescription;

  LongDescription(this.longDescription);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
        child: Text(
          '"$longDescription"',
          style: TextStyle(
              fontSize: 13, color: Colors.black87, fontStyle: FontStyle.italic),
        ));
  }
}

//afterscrolled
class MiniAppBar extends StatelessWidget {
  final Restaurant loadedRestaurant;
  final double scrollLocation;

  MiniAppBar(this.loadedRestaurant, this.scrollLocation);

  @override
  Widget build(BuildContext context) {
    // var _controller = TextEditingController();
    final mediaQuery = MediaQuery.of(context);

    double appBarHeight = mediaQuery.size.width * 0.75;

    List<String> mealCategory = loadedRestaurant.meals
        .map((meal) => meal.mealCategory)
        .toSet()
        .toList();

    String categoryBox = mealCategory[0];
    List<double> eachCategoryPixelLocation = [
      appBarHeight,
    ];

    for (int i = 1; i < mealCategory.length; i++) {
      eachCategoryPixelLocation.add(((loadedRestaurant.meals
                  .where((meal) {
                    return (meal.mealCategory == mealCategory[i]);
                  })
                  .toList()
                  .length) *
              eachMealContainerHeight) +
          eachCategoryTitleContainerHeight / 2 +
          eachCategoryPixelLocation[i - 1]);

      if (scrollLocation >= eachCategoryPixelLocation[i]) {
        categoryBox = mealCategory[i];
      }
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                    Text(
                      loadedRestaurant.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Roboto Condensed',
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Icon(
                      Icons.share,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ),
              ]),
          FittedBox(
            child: Row(children: [
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 5, top: 7),
                width: mediaQuery.size.width * 0.65,
                height: 30,
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(230, 230, 230, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(categoryBox,
                          style:
                              TextStyle(color: Colors.black87, fontSize: 14)),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Image.asset(
                          'assets/images/expand button.png',
                          width: 15,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 5, top: 7),
                width: mediaQuery.size.width * 0.22,
                height: 30,
                child: Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(230, 230, 230, 1),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Icon(Icons.search, size: 16),
                        ),
                        Text(
                          'Search',
                          style: TextStyle(color: Colors.black87, fontSize: 14),
                        ),
                      ]),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
