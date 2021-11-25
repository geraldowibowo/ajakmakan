import 'package:flutter/material.dart';
import 'package:ajak_makan/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackScreen extends StatelessWidget {
  static const routeName = '/feedback-screen';
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 5, left: 15, right: 15),
            child: Text(
              "We will try our best for you",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                cursorColor: Color.fromRGBO(227, 0, 0, 1),
                autofocus: true,
                style: TextStyle(fontSize: 15),
                maxLines: 100,
                controller: controller,
                decoration: InputDecoration(
                    hintText: 'Contoh: appnya memiliki bug di bagian login',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    counterText: ''),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.bottomRight,
            color: Colors.transparent,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                // ignore: deprecated_member_use
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Color.fromRGBO(227, 0, 27, 1),
                    textColor: Colors.white,
                    onPressed: () {
                      DatabaseService(uid: _auth.currentUser.uid)
                          .addFeedback(feedback: controller.text);
                      Navigator.of(context).pop();
                    },
                    child: Text('Submit'))),
          ),
        ],
      ),
    ));
  }
}
