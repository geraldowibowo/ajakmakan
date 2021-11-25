import 'package:flutter/material.dart';
import 'package:ajak_makan/providers/customer.dart';
import 'package:ajak_makan/Profile/screens/edit_profile_address.dart';

class AlamatPengantaran extends StatelessWidget {
  final Customer customerData;

  AlamatPengantaran(this.customerData);

  @override
  Widget build(BuildContext context) {
    String phoneNumberSeperator(String phoneNumber) {
      try {
        phoneNumber = phoneNumber.substring(0, 3) +
            ' ' +
            phoneNumber.substring(3, 6) +
            ' ' +
            phoneNumber.substring(6);
      } catch (error) {
        phoneNumber = phoneNumber;
      }

      return phoneNumber;
    }

    Customer dummyCustomer = customerData;
    if (dummyCustomer == null) {
      return Center(child: Text('Loading...'));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      color: Colors.grey.withOpacity(0.5),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'Alamat Pengantaran',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            //Alamat Pengantaran
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(EditProfileAddress.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 10),
                        child: Image.asset('assets/images/Delivery Icon.png',
                            height: 25),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 150,
                        child: FittedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(
                                  '${dummyCustomer.receiverName} | ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                Text(
                                  '${phoneNumberSeperator(dummyCustomer.phoneNumber)}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ]),
                              Container(
                                width: MediaQuery.of(context).size.width - 150,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  '${dummyCustomer.addressLine1}, ${dummyCustomer.addressLine2} ',
                                  overflow: TextOverflow.clip,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              (dummyCustomer.addressDescription == '')
                                  ? Container(
                                      child: Text(
                                        'Edit deskripsi alamat (Opsional)',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    )
                                  : Text(
                                      'Deskripsi: ${dummyCustomer.addressDescription}',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      Text('Ubah',
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Transform.rotate(
                        angle: 270 * 22 / 7 / 180,
                        child: Icon(Icons.expand_more,
                            color: Color.fromRGBO(227, 0, 0, 1)),
                      )
                    ])
                  ],
                ),
              ),
            ),
            //Instant Delivery
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      child: FittedBox(
                        fit: BoxFit.none,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 10),
                              child: Image.asset('assets/images/motor.png',
                                  height: 25),
                            ),
                            Text('Antar Langsung'),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.circle,
                                  size: 5, color: Color.fromRGBO(227, 0, 0, 1)),
                            ),
                            Text('99 km (99 min)',
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                    Row(children: [
                      Text('+ Catatan',
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Transform.rotate(
                        angle: 270 * 22 / 7 / 180,
                        child: Icon(Icons.expand_more,
                            color: Color.fromRGBO(227, 0, 0, 1)),
                      )
                    ])
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
