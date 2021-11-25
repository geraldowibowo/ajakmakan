import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ajak_makan/login_screen/auth_screen.dart';
import 'package:ajak_makan/services/database.dart';
import 'package:provider/provider.dart';
import 'package:ajak_makan/providers/customer.dart';

class EditProfileAddress extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  static const routeName = '/edit-profile-address';

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    Customer customerData = Provider.of<Customer>(context);
    if (customerData == null) {
      return Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      ));
    }

    String namaLengkap = '';
    String namaPenerima;
    String addressLine1 = '';
    String addressLine2 = '';
    String addressDescription = '';

    void _trySubmit() {
      final _isValid = _formKey.currentState.validate();

      if (_isValid) {
        FocusScope.of(context).unfocus();
        _formKey.currentState.save();
        DatabaseService(uid: _auth.currentUser.uid).updateUserData(
          name: namaLengkap,
          username: customerData.username,
          phoneNumber: customerData.phoneNumber,
          receiverName: namaPenerima,
          addressLine1: addressLine1,
          addressLine2: addressLine2,
          addressDescription: addressDescription,
          latitude: -6.137935, //DUMMY LATITUDE
          longitude: 106.694145, //DUMMY LONGITUDE
          points: customerData.points,
        );
        Navigator.of(context).pop();
      }
    }

    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Edit profile kamu',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Kamu bisa mengedit data profil dan alamatmu di sini',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20),
                  textFormFieldWidget(
                      context: context,
                      instruction: 'Username',
                      initialText: '${customerData.username} (cannot change)',
                      validator: (value) {},
                      enabled: false,
                      onSaved: (value) {}),
                  textFormFieldWidget(
                      context: context,
                      instruction: 'Display name',
                      initialText: customerData.name,
                      validator: (value) {
                        if (value.length <= 3) {
                          return 'Please enter a longer name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        namaLengkap = value;
                      }),
                  textFormFieldWidget(
                      context: context,
                      instruction:
                          'Nomor handphone (masukkan nomor hp dengan +62)',
                      enabled: false,
                      initialText:
                          '${customerData.phoneNumber} (cannot change)',
                      validator: (value) {
                        if (value.length <= 8) {
                          return 'Masukkan nomor hp dengan +62';
                        }
                        return null;
                      },
                      onSaved: (value) {}),
                  textFormFieldWidget(
                      context: context,
                      instruction: 'Nama penerima',
                      initialText: customerData.receiverName,
                      validator: (value) {
                        if (value.length <= 3) {
                          return 'Please enter a longer username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        namaPenerima = value;
                      }),

                  textFormFieldWidget(
                      context: context,
                      instruction: 'Alamat Baris 1',
                      initialText: customerData.addressLine1,
                      maxLength: 50,
                      validator: (value) {
                        if (value.length <= 4) {
                          return 'Please enter a more detailed address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        addressLine1 = value;
                      }),
                  textFormFieldWidget(
                      context: context,
                      instruction: 'Alamat Baris 2 (opsional)',
                      initialText: customerData.addressLine2,
                      maxLength: 50,
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        addressLine2 = value;
                      }),
                  textFormFieldWidget(
                      context: context,
                      instruction: 'Deskripsi tambahan (opsional)',
                      initialText: customerData.addressDescription,
                      maxLength: 50,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        addressDescription = value;
                      }),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.width * 9 / 20,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Google Map Here'),
                        Text('Alamat: ........')
                      ],
                    ),
                  ),
                  // FittedBox(
                  //   child: Container(
                  //     margin: EdgeInsets.symmetric(vertical: 5),
                  //     width: MediaQuery.of(context).size.width * 0.85,
                  //     child: TextFormField(
                  //       validator: (value) {
                  //         if (value.length <= 3) {
                  //           return 'Please enter a longer username';
                  //         }
                  //         if (username.contains(value)) {
                  //           return 'username has been used by another user. Please enter another username';
                  //         }
                  //         return null;
                  //       },
                  //       onSaved: (value) {
                  //         _username = '$value';
                  //       },
                  //       onChanged: (value) {},
                  //       maxLength: 25,
                  //       textAlignVertical: TextAlignVertical.center,
                  //       style: TextStyle(
                  //           fontSize: 15, fontWeight: FontWeight.w400),
                  //       inputFormatters: <TextInputFormatter>[
                  //         FilteringTextInputFormatter.allow(
                  //             RegExp("[0-9a-zA-Z]")),
                  //       ],
                  //       decoration: InputDecoration(
                  //         counterText: '',
                  //         contentPadding:
                  //             const EdgeInsets.symmetric(vertical: 15),
                  //         hintText: 'Username',
                  //         focusedBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(
                  //               color: Color.fromRGBO(207, 0, 21, 1)),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  // ignore: deprecated_member_use
                  RaisedButton(
                      color: Color.fromRGBO(207, 0, 21, 1),
                      onPressed: _trySubmit,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          'Save Profile & Address',
                          style: TextStyle(
                              letterSpacing: 3,
                              color: Colors.white,
                              fontFamily: 'CreatoDisplay'),
                        ),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () async {
                        await _auth.signOut().then((value) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AuthScreen.routeName,
                              (Route<dynamic> route) => false);
                        });
                      },
                      child: Text('Log Out',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              )),
        ),
      ),
    ));
  }
}

Widget textFormFieldWidget({
  context,
  String instruction,
  String initialText = '',
  bool autoFocus = false,
  TextInputAction textInputAction = TextInputAction.next,
  int maxLength = 25,
  int maxLine = 1,
  Function onSaved,
  Function validator,
  bool enabled = true,
}) {
  return FittedBox(
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width * 0.85,
      alignment: Alignment.center,
      child: TextFormField(
        enabled: enabled,
        validator: validator,
        onSaved: onSaved,
        initialValue: initialText,
        autofocus: autoFocus,
        textInputAction: textInputAction,
        maxLength: maxLength,
        textAlignVertical: TextAlignVertical.center,
        maxLines: maxLine,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        cursorColor: Color.fromRGBO(207, 0, 21, 1),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          // hintText: instruction,
          labelText: instruction,
          labelStyle: TextStyle(color: Colors.black54),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(207, 0, 21, 1)),
          ),
        ),
      ),
    ),
  );
}
