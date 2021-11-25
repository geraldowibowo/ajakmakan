import 'address.dart';

class Driver {
  final String driverId;
  final String driverName;
  final String driverPhoneNumber;
  final String driverProfilePicture;
  final Address driverAddress;
  final bool isAvailable;

  Driver({
    this.driverId,
    this.driverName,
    this.driverPhoneNumber,
    this.driverProfilePicture,
    this.driverAddress,
    this.isAvailable,
  });
}
