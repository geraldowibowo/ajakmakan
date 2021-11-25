import 'package:ajak_makan/Explore/screens/meal_detail_screen/meal_detail_screen.dart';
import 'package:ajak_makan/providers/basket.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ajak_makan/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:ajak_makan/models/res_and_meal.dart';

double eachCategoryTitleContainerHeight = 30;
double eachMealContainerHeight = 110;

class RestaurantMealChoices extends StatelessWidget {
  final Restaurant loadedRestaurant;

  RestaurantMealChoices(this.loadedRestaurant);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    List<String> mealCategory = loadedRestaurant.meals
        .map((meal) => meal.mealCategory)
        .toSet()
        .toList();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15, right: 5, top: 8),
          padding: EdgeInsets.all(0),
          // color: Colors.amber,
          height: (eachMealContainerHeight *
                  loadedRestaurant.meals.length.toDouble()) +
              (eachCategoryTitleContainerHeight * mealCategory.length),
          width: mediaQuery.size.width,
          child: ListView.builder(
              clipBehavior: Clip.none,
              padding: EdgeInsets.all(0),
              itemCount: mealCategory.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (contex, categoryIndex) {
                return Column(
                  children: [
                    Container(
                        // color: Colors.red,
                        margin:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                        height: eachCategoryTitleContainerHeight,
                        alignment: Alignment.centerLeft,
                        width: mediaQuery.size.width,
                        child: Text(
                          mealCategory[categoryIndex],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto Condensed'),
                        )),
                    Container(
                      height: eachMealContainerHeight *
                          loadedRestaurant.meals
                              .where((meal) {
                                return (meal.mealCategory ==
                                    mealCategory[categoryIndex]);
                              })
                              .toList()
                              .length,
                      // color: Colors.green,
                      child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: loadedRestaurant.meals
                              .where((meal) {
                                return (meal.mealCategory ==
                                    mealCategory[categoryIndex]);
                              })
                              .toList()
                              .length,
                          itemBuilder: (ctx, mealIndex) {
                            return SingleMealCardDisplay(
                                eachMealContainerHeight,
                                loadedRestaurant,
                                mealCategory,
                                categoryIndex,
                                mealIndex,
                                mediaQuery);
                          }),
                    ),
                  ],
                );
              }),
        ),
        SizedBox(height: 600),
      ],
    );
  }
}

class SingleMealCardDisplay extends StatelessWidget {
  final double eachMealContainerHeight;
  final Restaurant loadedRestaurant;
  final List<String> mealCategory;
  final int categoryIndex;
  final int mealIndex;
  final MediaQueryData mediaQuery;

  SingleMealCardDisplay(this.eachMealContainerHeight, this.loadedRestaurant,
      this.mealCategory, this.categoryIndex, this.mealIndex, this.mediaQuery);

  @override
  Widget build(BuildContext context) {
    String title = loadedRestaurant.meals
        .where((meal) {
          return (meal.mealCategory == mealCategory[categoryIndex]);
        })
        .toList()
        .map((meal) => meal.title)
        .toList()[mealIndex];

    String description = loadedRestaurant.meals
        .where((meal) {
          return (meal.mealCategory == mealCategory[categoryIndex]);
        })
        .toList()
        .map((meal) => meal.description)
        .toList()[mealIndex];

    String imageUrl = loadedRestaurant.meals
        .where((meal) {
          return (meal.mealCategory == mealCategory[categoryIndex]);
        })
        .toList()
        .map((meal) => meal.imageUrl)
        .toList()[mealIndex];

    String mealId = loadedRestaurant.meals
        .where((meal) {
          return (meal.mealCategory == mealCategory[categoryIndex]);
        })
        .toList()
        .map((meal) => meal.mealId)
        .toList()[mealIndex];

    int priceInInt = loadedRestaurant.meals
        .where((meal) {
          return (meal.mealCategory == mealCategory[categoryIndex]);
        })
        .toList()
        .map((meal) => meal.price)
        .toList()[mealIndex];

    var formatter =
        NumberFormat.currency(locale: 'eu', decimalDigits: 0, name: '');

    String price = formatter.format(priceInInt);

    final basket = Provider.of<Basket>(context);

    TextEditingController controllerCatatan = TextEditingController();

    void checkIfRestaurantChanged(String restaurantIdFunc, basket) {
      List<dynamic> checkRestoIdAsList = [
        restaurantIdFunc,
        ...basket.items.values
            .toList()
            .map((e) => e.restaurantClass.restaurantId)
      ].toSet().toList();
      if (checkRestoIdAsList.length > 1) {
        print(checkRestoIdAsList);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text('Make a new basket?'),
                  actions: [
                    // ignore: deprecated_member_use
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          return;
                        },
                        child: Text('No')),
                    // ignore: deprecated_member_use
                    FlatButton(
                        onPressed: () {
                          basket.clear();
                          basket.addItem(
                              loadedRestaurant, mealId, priceInInt, title);
                          Navigator.of(context).pop();
                          return;
                        },
                        child: Text('Yes'))
                  ],
                ));
      } else {
        basket.addItem(loadedRestaurant, mealId, priceInInt, title);
      }
    }

    if (basket.items.values
        .where((element) => element.mealId == mealId)
        .toList()
        .isNotEmpty) {
      controllerCatatan.text = basket.items.values.firstWhere((element) {
        return (element.mealId == mealId);
      }).catatan;
    }

    return Container(
      // color: Colors.blue,
      height: eachMealContainerHeight,
      child: GestureDetector(
        onTap: () {
          //IF MEAL HAS NOT BEEN ADDED
          if (basket.items.values
              .where((element) => element.mealId == mealId)
              .toList()
              .isEmpty) {
            List<dynamic> checkRestoIdAsList = [
              loadedRestaurant.restaurantId,
              ...basket.items.values
                  .toList()
                  .map((e) => e.restaurantClass.restaurantId)
            ].toSet().toList();
            //IF DIFFERENT RESTO
            if (checkRestoIdAsList.length > 1) {
              print(checkRestoIdAsList);
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Text('Make a new basket?'),
                        actions: [
                          // ignore: deprecated_member_use
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                return;
                              },
                              child: Text('No')),
                          // ignore: deprecated_member_use
                          FlatButton(
                              onPressed: () {
                                basket.clear();
                                basket.addItem(loadedRestaurant, mealId,
                                    priceInInt, title);
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed(
                                    MealDetailScreen.routeName,
                                    arguments: ResAndMeal(
                                        loadedRestaurant,
                                        (loadedRestaurant.meals.firstWhere(
                                            (meal) => meal.mealId == mealId))));
                                return;
                              },
                              child: Text('Yes'))
                        ],
                      ));
            } else {
              //IF SAME RESTO
              basket.addItem(loadedRestaurant, mealId, priceInInt, title);
              Navigator.of(context).pushNamed(MealDetailScreen.routeName,
                  arguments: ResAndMeal(
                      loadedRestaurant,
                      (loadedRestaurant.meals
                          .firstWhere((meal) => meal.mealId == mealId))));
            }
          } else {
            //IF MEAL HAS BEEN ADDED
            Navigator.of(context).pushNamed(MealDetailScreen.routeName,
                arguments: ResAndMeal(
                    loadedRestaurant,
                    (loadedRestaurant.meals
                        .firstWhere((meal) => meal.mealId == mealId))));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //IMAGE
            Container(
                alignment: Alignment.center,
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover))),
            SizedBox(width: 10),
            //MEAL TITLE, DESCRIPTION, AND PRICE
            Stack(alignment: Alignment.bottomRight, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  description != ''
                      ? Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 4),
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            width: mediaQuery.size.width - 120,
                            child: Text(
                              description,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13),
                            ),
                          ),
                        )
                      : SizedBox(),
                  Text(
                    price,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black87),
                  )
                ],
              ),
              Positioned(
                bottom: 8,
                right: 5,
                child: Consumer<Basket>(builder: (context, basket, child) {
                  if (basket.items.values
                      .where((element) => element.mealId == mealId)
                      .toList()
                      .isEmpty) {
                    //ADD BUTTON
                    return GestureDetector(
                      onTap: () {
                        checkIfRestaurantChanged(
                            loadedRestaurant.restaurantId, basket);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 13),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.red)),
                        child: Icon(Icons.add, color: Colors.red, size: 19),
                      ),
                    );
                  } else {
                    return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //TAMBAH CATATAN
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15))),
                                  context: context,
                                  backgroundColor: Colors.white,
                                  isScrollControlled: true,
                                  builder: (BuildContext ctx) {
                                    return Container(
                                      height: mediaQuery.size.height * 0.75,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30,
                                                    bottom: 5,
                                                    left: 15,
                                                    right: 15),
                                                child: Text(
                                                  "Tambahkan catatan untuk restoran",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: TextField(
                                                  cursorColor: Color.fromRGBO(
                                                      227, 0, 0, 1),
                                                  autofocus: true,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  maxLength: 200,
                                                  maxLines: 5,
                                                  controller: controllerCatatan,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          'Contoh: Tidak ingin pedas ya!',
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      counterText: ''),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: double.infinity,
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(ctx)
                                                            .viewInsets
                                                            .bottom +
                                                        10,
                                                    right: 15),
                                                // ignore: deprecated_member_use
                                                child: FlatButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    color: Color.fromRGBO(
                                                        227, 0, 0, 1),
                                                    textColor: Colors.white,
                                                    onPressed: () {
                                                      basket.editCatatan(
                                                          mealId,
                                                          controllerCatatan
                                                              .text);
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text('Submit'))),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            //ADD NOTES
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 15),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: Color.fromRGBO(227, 0, 0, 1))),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '+ Notes ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Icon(
                                      Icons.note_add,
                                      color: Color.fromRGBO(227, 0, 0, 1),
                                      size: 14,
                                    )
                                  ]),
                            ),
                          ),
                          //REMOVE PRODUCT
                          GestureDetector(
                            onTap: () {
                              basket.removeSingleItem(mealId);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Color.fromRGBO(227, 0, 0, 1))),
                              child: Icon(Icons.remove,
                                  color: Color.fromRGBO(227, 0, 0, 1),
                                  size: 19),
                            ),
                          ),
                          //NUMBER
                          Container(
                              width: 21,
                              height: 21,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                          width: 1, color: Colors.black26))),
                              child: Text(basket.items.values
                                  .firstWhere((element) {
                                    return (element.mealId == mealId);
                                  })
                                  .quantity
                                  .toString())),
                          //ADD PRODUCT
                          GestureDetector(
                            onTap: () {
                              checkIfRestaurantChanged(
                                  loadedRestaurant.restaurantId, basket);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 14),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Color.fromRGBO(227, 0, 0, 1))),
                              child: Icon(Icons.add,
                                  color: Color.fromRGBO(227, 0, 0, 1),
                                  size: 19),
                            ),
                          ),
                        ]);
                  }
                }),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
