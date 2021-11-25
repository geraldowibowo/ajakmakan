import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:ajak_makan/providers/customer.dart';

import 'package:ajak_makan/Profile/screens/edit_profile_address.dart';

class TopBar extends StatelessWidget {
  final Customer customerData;

  TopBar(this.customerData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(EditProfileAddress.routeName);
      },
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Image.asset(
            'assets/images/Delivery Icon.png',
            fit: BoxFit.cover,
            height: 45,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kirim sekarang ke',
              style: TextStyle(fontSize: 12, color: Colors.black54),
              textAlign: TextAlign.left,
            ),
            Text(
              customerData.receiverName,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
        Container(
          height: 40,
          alignment: Alignment.bottomCenter,
          child: Icon(
            Icons.expand_more,
            color: Color.fromRGBO(227, 0, 27, 1),
            size: 28,
          ),
        )
      ]),
    );
  }
}
