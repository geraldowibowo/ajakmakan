import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AuthForm extends StatefulWidget {
  final Function getMobileForm;

  AuthForm(this.getMobileForm);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userPhoneNumber = '';
  void _trySubmit() {
    final _isValid = _formKey.currentState.validate();

    if (_isValid) {
      FocusScope.of(context).unfocus();
      _formKey.currentState.save();
      widget.getMobileForm(_userPhoneNumber);
    }
  }

  String initialCountry = 'ID';
  PhoneNumber number = PhoneNumber(isoCode: 'ID');
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   padding: const EdgeInsets.only(bottom: 20),
                  //   width: MediaQuery.of(context).size.width,
                  //   alignment: Alignment.topLeft,
                  //   child: Image.asset(
                  //     'assets/images/Ajak Logo with Text.png',
                  //     width: MediaQuery.of(context).size.width * 0.2,
                  //   ),
                  // ),
                  Text(
                    'Selamat datang di layanan Ajakmakan',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Eat, Share, Receive',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Masukkan No. Hp yang akan kamu gunakan untuk proses pemesanan',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  // SizedBox(height: 30),
                  FittedBox(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: InternationalPhoneNumberInput(
                        maxLength: 15,
                        textAlignVertical: TextAlignVertical.center,
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                        autoFocus: true,
                        spaceBetweenSelectorAndTextField: 0,
                        onInputChanged: (PhoneNumber number) {},
                        onInputValidated: (bool value) {},
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: number,
                        textFieldController: controller,
                        formatInput: true,
                        inputDecoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                          hintText: 'Phone number',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(207, 0, 21, 1)),
                          ),
                        ),
                        cursorColor: Color.fromRGBO(207, 0, 21, 1),
                        keyboardType: TextInputType.phone,
                        inputBorder: OutlineInputBorder(),
                        onSaved: (PhoneNumber number) {
                          _userPhoneNumber = '$number';
                        },
                      ),
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.6,
                    //   child: TextFormField(
                    //     validator: (value) {
                    //       if (value.length <= 7) {
                    //         return 'Please enter a valid phone number';
                    //       }
                    //       return null;
                    //     },
                    //     onSaved: (value) {
                    //       _userPhoneNumber = '$value';
                    //     },
                    //     keyboardType: TextInputType.phone,
                    //     decoration:
                    //         InputDecoration(labelText: 'Phone number'),
                    //   ),
                    // ),
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                      color: Color.fromRGBO(207, 0, 21, 1),
                      onPressed: _trySubmit,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          _isLogin ? 'LOGIN' : 'SIGNUP',
                          style: TextStyle(
                              letterSpacing: 3,
                              color: Colors.white,
                              fontFamily: 'CreatoDisplay'),
                        ),
                      )),
                  // ignore: deprecated_member_use
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: RichText(
                          text: TextSpan(children: [
                        _isLogin
                            ? TextSpan(
                                text: 'Belum punya akun? ',
                                style: TextStyle(color: Colors.black))
                            : TextSpan(
                                text: 'Sudah punya akun? ',
                                style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: 'klik di sini',
                            style:
                                TextStyle(color: Color.fromRGBO(207, 0, 21, 1)))
                      ])))
                ],
              )),
        ),
      ),
    );
  }
}
