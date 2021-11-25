import 'package:ajak_makan/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:ajak_makan/models/meal.dart';
import 'package:ajak_makan/models/res_and_meal.dart';
import 'package:ajak_makan/providers/basket.dart';
// import 'package:ajak_makan/Explore/screens/explore_restaurant/restaurant_homepage.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail-screen';
  @override
  Widget build(BuildContext context) {
    final resAndMeal = ModalRoute.of(context).settings.arguments as ResAndMeal;
    final mealDetail = resAndMeal.selectedMeal;
    final loadedRestaurant = resAndMeal.loadedRestaurant;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            MealDetailAppBar(mealDetail),
            buildContents(mealDetail, loadedRestaurant),
          ],
        ),
      ),
      floatingActionButton: ToBasketBottomButton(loadedRestaurant, mealDetail),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class MealDetailAppBar extends StatelessWidget {
  final Meal mealDetail;

  MealDetailAppBar(this.mealDetail);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SliverAppBar(
      leading: Container(),
      backgroundColor: Colors.white,
      collapsedHeight: 45,
      toolbarHeight: 0,
      shadowColor: Colors.black,
      elevation: 3,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.topCenter,
          children: [
            //IMAGE
            Container(
              height: mediaQuery.size.width,
              width: double.infinity,
              child: Image.network(
                mealDetail.imageUrl,
                fit: BoxFit.cover,
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
        title: MiniAppBar(mealDetail),
        titlePadding: EdgeInsets.all(0),
        centerTitle: false,
      ),
      expandedHeight: mediaQuery.size.width,
    );
  }
}

class MiniAppBar extends StatelessWidget {
  final Meal mealDetail;

  MiniAppBar(this.mealDetail);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 5),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                //BACK BUTTON
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ),
                Text(
                  mealDetail.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto Condensed',
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            //SHARE BUTTON
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
    );
  }
}

Widget buildContents(mealDetail, loadedRestaurant) =>
    MealDetailContent(mealDetail, loadedRestaurant);

class MealDetailContent extends StatelessWidget {
  final Meal mealDetail;
  final Restaurant loadedRestaurant;

  MealDetailContent(this.mealDetail, this.loadedRestaurant);

  @override
  Widget build(BuildContext context) {
    var formatter =
        NumberFormat.currency(locale: 'eu', decimalDigits: 0, name: '');

    TextEditingController controllerCatatan = TextEditingController();

    final basket = Provider.of<Basket>(context);

    if (basket.items.values
        .where((element) => element.mealId == mealDetail.mealId)
        .toList()
        .isNotEmpty) {
      controllerCatatan.text = basket.items.values.firstWhere((element) {
        return (element.mealId == mealDetail.mealId);
      }).catatan;
    }

    void editCatatan() {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          context: context,
          backgroundColor: Colors.white,
          isScrollControlled: true,
          builder: (BuildContext ctx) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30, bottom: 5, left: 15, right: 15),
                        child: Text(
                          "Tambahkan catatan untuk restoran",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextField(
                          cursorColor: Color.fromRGBO(227, 0, 0, 1),
                          autofocus: true,
                          style: TextStyle(fontSize: 15),
                          maxLength: 200,
                          maxLines: 5,
                          controller: controllerCatatan,
                          decoration: InputDecoration(
                              hintText: 'Contoh: Tidak ingin pedas ya!',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
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
                            bottom: MediaQuery.of(ctx).viewInsets.bottom + 10,
                            right: 15),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Color.fromRGBO(227, 0, 0, 1),
                            textColor: Colors.white,
                            onPressed: () {
                              basket.editCatatan(
                                  mealDetail.mealId, controllerCatatan.text);
                              Navigator.of(ctx).pop();
                            },
                            child: Text('Submit'))),
                  ),
                ],
              ),
            );
          });
    }

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
                              loadedRestaurant.restaurantId,
                              mealDetail.mealId,
                              mealDetail.price,
                              mealDetail.title);
                          Navigator.of(context).pop();
                          return;
                        },
                        child: Text('Yes'))
                  ],
                ));
      } else {
        basket.addItem(loadedRestaurant, mealDetail.mealId, mealDetail.price,
            mealDetail.title);
      }
    }

    return SliverToBoxAdapter(
        child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Title makanan
          Padding(
            padding:
                const EdgeInsets.only(right: 12, top: 15, left: 12, bottom: 8),
            child: Text(
              mealDetail.title,
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
          ),
          //deskripsi makanan
          Padding(
            padding:
                const EdgeInsets.only(right: 12, top: 3, left: 12, bottom: 3),
            child: Text(
              mealDetail.description,
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          // harga makanan
          Padding(
            padding:
                const EdgeInsets.only(right: 12, top: 5, left: 12, bottom: 10),
            child: Text(
              formatter.format(mealDetail.price),
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            height: 7,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.25),
          ),
          // Tulisan instruksi
          Padding(
            padding:
                const EdgeInsets.only(top: 18, bottom: 8, left: 15, right: 15),
            child: FittedBox(
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(
                  "Tambahkan catatan untuk restoran",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.clip,
                ),
                SizedBox(width: 5),
                Text(
                  'Opsional',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ]),
            ),
          ),
          //text catatan
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 100,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(width: 0.5, color: Colors.grey))),
            child: GestureDetector(
                onTap: editCatatan,
                child: Container(
                  color: Colors.white,
                  height: 100,
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: controllerCatatan.text == ''
                      ? Text(
                          'Contoh: ingin cabe ekstra..., ingin saos tomat...\nPermintaan akan diteruskan ke Merchant',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text(
                          controllerCatatan.text,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                )),
          ),
          //PLUS MINUS QUANTITY
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //REMOVE PRODUCT
                GestureDetector(
                  onTap: () {
                    basket.removeSingleItem(mealDetail.mealId);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Color.fromRGBO(227, 0, 0, 1))),
                    child: Icon(Icons.remove,
                        color: Color.fromRGBO(227, 0, 0, 1), size: 30),
                  ),
                ),
                //NUMBER
                Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    child: (basket.items.values
                            .where((element) =>
                                element.mealId == mealDetail.mealId)
                            .toList()
                            .isEmpty)
                        ? Text('0', style: TextStyle(fontSize: 18))
                        : Text(
                            basket.items.values
                                .firstWhere((element) {
                                  return (element.mealId == mealDetail.mealId);
                                })
                                .quantity
                                .toString(),
                            style: TextStyle(fontSize: 18))),
                //ADD PRODUCT
                GestureDetector(
                  onTap: () {
                    checkIfRestaurantChanged(
                        loadedRestaurant.restaurantId, basket);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Color.fromRGBO(227, 0, 0, 1))),
                    child: Icon(Icons.add,
                        color: Color.fromRGBO(227, 0, 0, 1), size: 30),
                  ),
                ),
              ]),
          SizedBox(height: 150),
        ],
      ),
    ));
  }
}

class ToBasketBottomButton extends StatelessWidget {
  final Restaurant loadedRestaurant;
  final Meal mealDetail;

  ToBasketBottomButton(this.loadedRestaurant, this.mealDetail);

  @override
  Widget build(BuildContext context) {
    final basket = Provider.of<Basket>(context);

    final basketContents = Provider.of<Basket>(context);

    int basketPrice = basketContents.totalAmount.toInt();

    var formatter =
        NumberFormat.currency(locale: 'eu', decimalDigits: 0, name: '');

    Map<String, int> minimumAmountToDiscount = {
      'lagi untuk food discount': loadedRestaurant.minPembelianMD,
      'lagi untuk cashback temanmu': loadedRestaurant.minPembelianIC,
      'lagi untuk dapat cashback buat kamu': loadedRestaurant.minPembelianPC,
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
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      alignment: Alignment.center,
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
              if (basket.items.values.toList().isEmpty) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
              }
            },
            backgroundColor: Color.fromRGBO(227, 0, 0, 1),
            label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.center,
              child: (basket.items.values
                      .where((element) => element.mealId == mealDetail.mealId)
                      .toList()
                      .isEmpty)
                  ? Text('Kembali ke Menu', style: TextStyle(fontSize: 18))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //BASKET & NUMBER OF ITEMS
                        Row(children: [
                          Text('Update Basket',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w800)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(Icons.circle,
                                color: Colors.white, size: 5),
                          ),
                          Text(
                              basket.items.values
                                  .firstWhere((element) {
                                    return (element.mealId ==
                                        mealDetail.mealId);
                                  })
                                  .quantity
                                  .toString(),
                              style: TextStyle(fontSize: 18)),
                        ]),
                        Text(
                          '${formatter.format(mealDetail.price * basket.items.values.firstWhere((element) {
                                return (element.mealId == mealDetail.mealId);
                              }).quantity)} >>',
                          style: TextStyle(
                            fontSize: 17,
                          ),
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
