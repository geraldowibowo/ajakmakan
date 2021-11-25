class Address {
  final String addressLine1;
  final String addressLine2;
  final String addressDescription;
  final double latitude;
  final double longitude;

  Address({
    this.addressLine1,
    this.addressLine2 = '',
    this.addressDescription = '',
    this.latitude,
    this.longitude,
  });
}
