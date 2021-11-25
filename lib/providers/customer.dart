import 'package:flutter/foundation.dart';

class Customer with ChangeNotifier {
  String username;
  String customerId;
  String name;
  String phoneNumber;
  int points;
  String receiverName;
  String addressLine1;
  String addressLine2;
  double latitude;
  double longitude;
  String addressDescription;

  Customer(
      {@required this.username,
      @required this.customerId,
      @required this.name,
      @required this.phoneNumber,
      @required this.points,
      @required this.receiverName,
      @required this.addressLine1,
      this.addressLine2 = '',
      @required this.latitude,
      @required this.longitude,
      this.addressDescription = ''});
}
