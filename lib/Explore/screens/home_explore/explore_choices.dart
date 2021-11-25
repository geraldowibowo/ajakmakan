import 'package:ajak_makan/Explore/screens/explore_restaurant/restaurant_homepage.dart';
import 'package:flutter/material.dart';

import 'dart:math' show cos, sqrt, asin;

import 'package:ajak_makan/providers/customer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ExploreChoices extends StatelessWidget {
  final MediaQueryData mediaQuery;
  final Customer customerData;

  ExploreChoices(this.mediaQuery, this.customerData);

  @override
  Widget build(BuildContext context) {
    String imagePath;

    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    CollectionReference restaurantsFirestore =
        fireStore.collection('restaurant');

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //TEXT: FEATURED
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
        child: Text(
          'Featured',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
      ),
      StreamBuilder<QuerySnapshot>(
          stream: restaurantsFirestore.snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              var restaurants = snapshot.data.docs;

              return Container(
                height: mediaQuery.size.width * 0.51 * restaurants.length + 150,
                width: mediaQuery.size.width,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 3),
                      height: 200,
                      width: mediaQuery.size.width * 0.8,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            RestaurantHomepage.routeName,
                            arguments: restaurants[index]),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //RESTAURANT THUMBNAIL
                                Material(
                                  borderRadius: BorderRadius.circular(15),
                                  elevation: 1,
                                  child: Container(
                                    height: mediaQuery.size.width * 0.35,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: imagePath != null
                                                ? NetworkImage(
                                                    imagePath) //TODO: Thumbnail for restaurant
                                                : NetworkImage(
                                                    'https://static01.nyt.com/images/2021/01/26/well/well-foods-microbiome/well-foods-microbiome-superJumbo.jpg'),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                //RESTAURANT NAME
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    restaurants[index]['title'],
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontFamily: 'Roboto Condensed',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                //SHORT DESCRIPTION
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 4),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, right: 3),
                                        child: Image.asset(
                                          'assets/images/Star 1.png',
                                          height: 13,
                                        ),
                                      ),
                                      Text(
                                        '5',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Text(
                                          '-',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                      Text(
                                        '"${restaurants[index]['shortDescription']}"',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ]),
                                BottomDiscountText(
                                  mD: restaurants[index]['merchantDiscount'],
                                  iC: restaurants[index]['influencerCashback'],
                                  pC: restaurants[index]['partnerCashback'],
                                )
                              ],
                            ),
                            DiscountCircle(
                              mD: restaurants[index]['merchantDiscount'],
                              iC: restaurants[index]['influencerCashback'],
                              pC: restaurants[index]['partnerCashback'],
                            ),
                            DistanceContainer(
                              resLatitude: restaurants[index]
                                      ['restaurantAddress']['geolocation']
                                  .latitude,
                              resLongitude: restaurants[index]
                                      ['restaurantAddress']['geolocation']
                                  .longitude,
                              customerData: customerData,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Text('Loading');
            }
          }),
      SizedBox(height: 50)
    ]);
  }
}

class BottomDiscountText extends StatelessWidget {
  final int mD;
  final int iC;
  final int pC;

  BottomDiscountText({this.mD, this.iC, this.pC});
  @override
  Widget build(BuildContext context) {
    Map<String, int> displayedDiscount = {
      'food': mD,
      'friend': iC,
      'cashback': pC,
    };

    var sortedKeys = displayedDiscount.keys.toList()..sort();

    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(width: 6),
      Padding(
        padding: const EdgeInsets.only(left: 4, right: 3),
        child: Image.asset(
          'assets/images/disc.png',
          height: 13,
        ),
      ),
      Text(
        '${displayedDiscount[sortedKeys[2]]}% ',
        style: TextStyle(
            fontSize: 13,
            color: Color.fromRGBO(227, 0, 0, 1),
            fontWeight: FontWeight.bold),
      ),
      Text(
        '${sortedKeys[2]} + ',
        style: TextStyle(fontSize: 13, color: Color.fromRGBO(227, 0, 0, 1)),
      ),
      Text(
        '${displayedDiscount[sortedKeys[1]]}% ',
        style: TextStyle(
            fontSize: 13,
            color: Color.fromRGBO(227, 0, 0, 1),
            fontWeight: FontWeight.bold),
      ),
      Text(
        '${sortedKeys[1]} + ',
        style: TextStyle(fontSize: 13, color: Color.fromRGBO(227, 0, 0, 1)),
      ),
      Text(
        '${displayedDiscount[sortedKeys[0]]}% ',
        style: TextStyle(
            fontSize: 13,
            color: Color.fromRGBO(227, 0, 0, 1),
            fontWeight: FontWeight.bold),
      ),
      Text(
        '${sortedKeys[0]}',
        style: TextStyle(fontSize: 13, color: Color.fromRGBO(227, 0, 0, 1)),
      ),
    ]);
  }
}

class DiscountCircle extends StatelessWidget {
  final int mD;
  final int iC;
  final int pC;

  DiscountCircle({this.mD, this.iC, this.pC});

  @override
  Widget build(BuildContext context) {
    final String displayedDiscount =
        (mD + iC + pC - (mD * iC) / 100 - (mD * pC) / 100).toStringAsFixed(0);

    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 8),
      child: Stack(clipBehavior: Clip.none, children: [
        Positioned(
          top: 1.5,
          left: 1,
          child: CircleAvatar(
            backgroundColor: Color.fromRGBO(227, 0, 0, 1),
            radius: 27,
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 27,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 3),
                Stack(children: [
                  Positioned(
                    top: 0.5,
                    left: 0.2,
                    child: Text(
                      'up to',
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Roboto Condensed',
                          color: Color.fromRGBO(227, 0, 0, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'up to',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Roboto Condensed',
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
                Stack(children: [
                  Positioned(
                    top: 1,
                    left: 0.5,
                    child: Text(
                      '$displayedDiscount%',
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'Roboto Condensed',
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(227, 0, 0, 1)),
                    ),
                  ),
                  Text(
                    '$displayedDiscount%',
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Roboto Condensed',
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class DistanceContainer extends StatelessWidget {
  final double resLatitude;
  final double resLongitude;
  final Customer customerData;

  DistanceContainer({this.resLatitude, this.resLongitude, this.customerData});

  @override
  Widget build(BuildContext context) {
    double distanceFromRestaurantToCustomer = calculateDistance(resLatitude,
        resLongitude, customerData.latitude, customerData.longitude);

    return Positioned(
      bottom: 35,
      right: 22,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 3,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(children: [
            Text(
              'Sekitar',
              style: TextStyle(fontSize: 11, color: Colors.black54),
            ),
            Text(
              '${distanceFromRestaurantToCustomer.toStringAsFixed(1)} km',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
