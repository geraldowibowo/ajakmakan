import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPForm extends StatefulWidget {
  final Function getOtpForm;

  OTPForm(this.getOtpForm);

  @override
  _OTPFormState createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  final _formKey = GlobalKey<FormState>();
  String _inputtedOTP = '';
  void _trySubmit() {
    final _isValid = _formKey.currentState.validate();

    if (_isValid) {
      FocusScope.of(context).unfocus();
      _formKey.currentState.save();
      widget.getOtpForm(_inputtedOTP);
    }
  }

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
                  Text(
                    'Verifikasi nomor Handphonemu',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Masukkan 6 digit kode yang dikirim melalui SMS ke No. HP kamu',
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
                        child: PinCodeTextField(
                          autoFocus: true,
                          animationType: AnimationType.scale,
                          pinTheme: PinTheme(
                            activeColor: Color.fromRGBO(207, 0, 21, 1),
                            selectedColor: Color.fromRGBO(207, 0, 21, 1),
                          ),
                          cursorColor: Color.fromRGBO(207, 0, 21, 1),
                          keyboardType: TextInputType.number,
                          length: 6,
                          onChanged: (value) {},
                          onCompleted: (value) {
                            _inputtedOTP = '$value';
                            _trySubmit();
                          },
                          onSaved: (value) {
                            _inputtedOTP = '$value';
                          },
                          appContext: context,
                        )),
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
                          'LANJUTKAN',
                          style: TextStyle(
                              letterSpacing: 3,
                              color: Colors.white,
                              fontFamily: 'CreatoDisplay'),
                        ),
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
