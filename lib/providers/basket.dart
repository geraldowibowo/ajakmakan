import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ajak_makan/models/restaurant.dart';

class BasketItem {
  final String orderId;
  final Restaurant restaurantClass;
  final String mealId;
  final String catatan;
  final String title;
  final int quantity;
  final int price;

  BasketItem({
    @required this.orderId,
    @required this.restaurantClass,
    @required this.mealId,
    this.catatan = '',
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Basket with ChangeNotifier {
  Map<String, BasketItem> _items = {};

  Map<String, BasketItem> get items {
    return {..._items};
  }

  int get itemCount {
    if (_items.length == 0) {
      return _items.length;
    } else {
      int qty = 0;
      _items.forEach((key, basketItem) {
        qty = basketItem.quantity;
      });

      return qty;
    }
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, basketItem) {
      total += basketItem.price * basketItem.quantity;
    });
    return total;
  }

  int get merchantDiscountAmount {
    int subTotal = totalAmount.toInt();
    Restaurant loadedRestaurant = _items.values.last.restaurantClass;
    if (subTotal >= loadedRestaurant.minPembelianMD &&
        (loadedRestaurant.merchantDiscount / 100) * subTotal >=
            loadedRestaurant.maxDiscountMD) {
      return (-loadedRestaurant.maxDiscountMD);
    } else if (subTotal >= loadedRestaurant.minPembelianMD &&
        (loadedRestaurant.merchantDiscount / 100) * subTotal <=
            loadedRestaurant.maxDiscountMD) {
      return (-subTotal * loadedRestaurant.merchantDiscount ~/ 100);
    } else {
      return 0;
    }
  }

  // int get partnerDiscountAmount {
  // }

  // int get influencerDiscountAmount {
  // }

  int get deliveryFee {
    return 9999;
  }

  int get orderFee {
    return 3000;
  }

  int get priceToPay {
    //STILL INCOMPLETE
    return (totalAmount + deliveryFee + orderFee + merchantDiscountAmount)
        .toInt();
  }

  void addItem(
      Restaurant loadedRestaurant, String mealId, int price, String title) {
    if (_items.containsKey(mealId)) {
      _items.update(
          mealId,
          (existingBasketItem) => BasketItem(
                orderId: existingBasketItem.orderId,
                restaurantClass: existingBasketItem.restaurantClass,
                mealId: existingBasketItem.mealId,
                title: existingBasketItem.title,
                quantity: existingBasketItem.quantity + 1,
                price: existingBasketItem.price,
              ));
    } else {
      _items.putIfAbsent(
          mealId,
          () => BasketItem(
                orderId: DateTime.now().toString(),
                restaurantClass: loadedRestaurant,
                mealId: mealId,
                title: title,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  void removeItem(String mealId) {
    _items.remove(mealId);
    notifyListeners();
  }

  void removeSingleItem(String mealId) {
    if (!_items.containsKey(mealId)) {
      return;
    }

    if (_items[mealId].quantity > 1) {
      _items.update(
          mealId,
          (existingBasketItem) => BasketItem(
                orderId: existingBasketItem.orderId,
                restaurantClass: existingBasketItem.restaurantClass,
                mealId: existingBasketItem.mealId,
                catatan: existingBasketItem.catatan,
                title: existingBasketItem.title,
                quantity: existingBasketItem.quantity - 1,
                price: existingBasketItem.price,
              ));
    } else {
      _items.remove(mealId);
    }
    notifyListeners();
  }

  void editCatatan(String mealId, String catatan) {
    if (_items.containsKey(mealId)) {
      _items.update(
          mealId,
          (existingBasketItem) => BasketItem(
              orderId: existingBasketItem.orderId,
              restaurantClass: existingBasketItem.restaurantClass,
              mealId: existingBasketItem.mealId,
              catatan: catatan,
              title: existingBasketItem.title,
              quantity: existingBasketItem.quantity,
              price: existingBasketItem.price));
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
