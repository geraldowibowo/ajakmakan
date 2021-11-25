import 'package:ajak_makan/login_screen/widgets/fill_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FillUsername extends StatelessWidget {
  static const routeName = '/fill-username';

  final _formKey = GlobalKey<FormState>();
  final CollectionReference document =
      FirebaseFirestore.instance.collection('customer');

  @override
  Widget build(BuildContext context) {
    String _namaLengkap = '';
    String _username = '';

    void _trySubmit() {
      final _isValid = _formKey.currentState.validate();

      if (_isValid) {
        FocusScope.of(context).unfocus();
        _formKey.currentState.save();
        Navigator.of(context).pushNamed(FillAddress.routeName,
            arguments: [_namaLengkap, _username]);
      }
    }

    List username = [];

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
                stream: document.snapshots(),
                builder: (context, snapshot) {
                  // List username;
                  try {
                    username = snapshot.data.docs.map((e) {
                      return e['username'];
                    }).toList();
                  } catch (error) {}

                  return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Text(username.toString()),
                          Text(
                            'Buat akun baru',
                            style: TextStyle(
                                fontSize: 34, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Masukkan nama lengkap yang akan ditampilkan di halaman profilemu',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          FittedBox(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.length <= 1) {
                                    return 'Please enter a valid name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _namaLengkap = '$value';
                                },
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                maxLength: 25,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  counterText: '',
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  hintText: 'Nama lengkap',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(207, 0, 21, 1)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                          Text(
                            'Masukkan username yang akan kamu gunakan. Username tidak bisa diganti lagi',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          FittedBox(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.length <= 3) {
                                    return 'Please enter a longer username';
                                  }
                                  if (username.contains(value)) {
                                    return 'username has been used by another user. Please enter another username';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _username = '$value';
                                },
                                onChanged: (value) {},
                                maxLength: 25,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9a-zA-Z]")),
                                ],
                                decoration: InputDecoration(
                                  counterText: '',
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  hintText: 'Username',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(207, 0, 21, 1)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          // ignore: deprecated_member_use
                          RaisedButton(
                              color: Color.fromRGBO(207, 0, 21, 1),
                              onPressed: _trySubmit,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                alignment: Alignment.center,
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                      letterSpacing: 3,
                                      color: Colors.white,
                                      fontFamily: 'CreatoDisplay'),
                                ),
                              )),
                        ],
                      ));
                }),
          ),
        ),
      ),
    );
  }
}
