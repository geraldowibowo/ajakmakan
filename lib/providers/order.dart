import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ajak_makan/providers/customer.dart';
import 'package:ajak_makan/models/restaurant.dart';

class OrderDataBaseService {
  final String uid;

  OrderDataBaseService(this.uid);

  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('order');
  final _auth = FirebaseAuth.instance;

  Future<void> addOrder({
    DateTime date,
    Customer customer,
    Restaurant chosenRestaurant,
    String orderId,
    List<int> mealQuantity,
    List<String> mealId,
    List<String> mealTitle,
    List<String> mealCatatan,
    List<int> mealPrice,
    int totalAmount,
    int merchantDiscountAmount,
    int partnerCashbackAmount,
    int influencerCashbackAmount,
    int deliveryFee,
    int orderFee,
    int pricePaid,
  }) async {
    return await orderCollection
        .doc(orderId + _auth.currentUser.uid + chosenRestaurant.restaurantId)
        .set({
      'date': date,
      'customer': {
        'customerUID': _auth.currentUser.uid,
        'customerUsername': customer.username,
        'customerName': customer.name,
        'customerPhoneNumber': customer.phoneNumber,
        'customerPoints': customer.points,
        'customerAddress': {
          'receiverName': customer.receiverName,
          'addressLine1': customer.addressLine1,
          'addressLine2': customer.addressLine2,
          'geolocation': GeoPoint(customer.latitude, customer.longitude),
          'addressDescription': customer.addressDescription,
        }
      },
      'restaurant': {
        'restaurantId': chosenRestaurant.restaurantId,
        'restaurantTitle': chosenRestaurant.title,
        'restaurantPhone': chosenRestaurant.phone,
        'restaurantAddress': {
          'addressLine1': chosenRestaurant.restaurantAddress.addressLine1,
          'addressLine2': chosenRestaurant.restaurantAddress.addressLine2,
          'geolocation': GeoPoint(chosenRestaurant.restaurantAddress.latitude,
              chosenRestaurant.restaurantAddress.longitude),
          'addressDescription':
              chosenRestaurant.restaurantAddress.addressDescription,
        }
      },
      'orderId': orderId,
      'meals': {
        'mealQuantity': FieldValue.arrayUnion(mealQuantity),
        'mealTitle': FieldValue.arrayUnion(mealTitle),
        'mealId': FieldValue.arrayUnion(mealId),
        'mealCatatan': FieldValue.arrayUnion(mealCatatan),
        'mealPrice': FieldValue.arrayUnion(mealPrice)
      },
      'totalAmount': totalAmount,
      'merchantDiscountAmount': merchantDiscountAmount,
      'partnerCashbackAmount': partnerCashbackAmount,
      'influencerCashbackAmount': influencerCashbackAmount,
      'deliveryFee': deliveryFee,
      'orderFee': orderFee,
      'pricePaid': pricePaid,
      'status': 'findingDriver',
    });
  }
}
