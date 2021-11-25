import 'package:ajak_makan/Profile/screens/feedback_screen.dart';
import 'package:ajak_makan/Profile/screens/profile_picture.dart';
// import 'package:ajak_makan/login_screen/auth_screen.dart';
import 'package:ajak_makan/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_profile_address.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ajak_makan/providers/customer.dart';

import 'package:share/share.dart';

class ProfileHome extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var customerData = Provider.of<Customer>(context);
    if (customerData == null) {
      return Center(child: CircularProgressIndicator());
    }

    String displayedAjakPoints = '';
    if (customerData.points >= 1000000) {
      displayedAjakPoints = '${customerData.points ~/ 1000000}Jt';
    } else if (customerData.points >= 1000) {
      displayedAjakPoints = '${customerData.points ~/ 1000}k';
      // '${snapshot.data['points'] ~/ 1000.toStringAsFixed(2)}k';
    } else {
      displayedAjakPoints = customerData.points.toString();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  // snapshot.data['username'],
                  customerData.username,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ),
                Icon(Icons.expand_more, color: Colors.black)
              ],
            ),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Share.share(
                      'Hi there, download Ajakmakan, and check out my profile: ${customerData.username}',
                      subject: 'Ngajak teman download Ajakmakan');
                },
                child: Icon(Icons.share, color: Colors.black)),
            SizedBox(width: 8),
          ],
        ),
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 60, bottom: 50),
                child: ProfilePicture()),
            Text(
              // '${snapshot.data['name']}',
              customerData.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      '227',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
                    ),
                    Text('Friends')
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text('28',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w800)),
                    Text('Orders')
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text('23',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w800)),
                    Text('Affiliates')
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(displayedAjakPoints,
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w800)),
                    Text('Ajakpoints')
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // ignore: deprecated_member_use
            RaisedButton(
                elevation: 0.5,
                color: Colors.white.withOpacity(0.9),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProfileAddress.routeName);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(width: 0.5, color: Colors.grey)),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: Text(
                    'Edit profile / address',
                    style: TextStyle(fontFamily: 'CreatoDisplay'),
                  ),
                )),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () async {
                await _auth.signOut().then((value) {
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //     AuthScreen.routeName, (Route<dynamic> route) => false);
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (_, __, ___) => MyApp(),
                    ),
                  );
                });
              },
              child: Text('Log Out',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 20),
            Text(
              'Your feedback matters the most',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(FeedbackScreen.routeName);
              },
              child: Text(
                'Tap here for feedback',
                style: TextStyle(
                    color: Color.fromRGBO(227, 0, 21, 1),
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 20),
            Text('Help center:'),
            Text('geraldowibowo@gmail.com'),
            Text('+62 813 8517 9578')
          ],
        ),
      ),
    );
  }
}
