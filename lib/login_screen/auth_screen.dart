import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ajak_makan/login_screen/widgets/auth_form.dart';
import 'package:ajak_makan/login_screen/widgets/otp_form.dart';
// import 'package:ajak_makan/login_screen/widgets/transition_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ajak_makan/tabs_screen.dart';
import 'package:ajak_makan/login_screen/widgets/fill_username.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
  SHOW_ADDRESS,
}

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  bool showLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId;

  void getMobileForm(String phoneController) async {
    setState(() {
      showLoading = true;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneController,
      verificationCompleted: (phoneAuthCredential) async {
        setState(() {
          showLoading = false;
        });
        //signInWithPhoneAuthCredential(phoneAuthCredential);
      },
      verificationFailed: (verificationFailed) async {
        setState(() {
          showLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(verificationFailed.message.toString()),
        ));
      },
      codeSent: (verificationId, resendingToken) async {
        setState(() {
          showLoading = false;
          currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          this.verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  Future<void> goToNextScreen() async {
    setState(() {
      showLoading = true;
    });
    final DocumentReference document = FirebaseFirestore.instance
        .collection('customer')
        .doc(_auth.currentUser?.uid);
    dynamic data;

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        data = snapshot.data();
      });
    });
    try {
      if (data['phoneNumber'] == _auth.currentUser.phoneNumber) {
        setState(() {
          showLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TabsScreen()));
      } else {
        setState(() {
          showLoading = false;
        });
        print('ERRRRRRRROR in CANNOT FIND USER AUTHSCREEN');
        Navigator.of(context).pushReplacementNamed(FillUsername.routeName);
      }
    } catch (error) {
      setState(() {
        showLoading = false;
      });
      print('ERRRRRRRROR in AUTHSCREEN');
      Navigator.of(context).pushReplacementNamed(FillUsername.routeName);
    }
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => TransitionPage()));
        goToNextScreen();
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
      ));
    }
  }

  void getOtpForm(String otpController) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpController);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? AuthForm(getMobileForm)
                  : currentState == MobileVerificationState.SHOW_OTP_FORM_STATE
                      ? OTPForm(getOtpForm)
                      : OTPForm(getOtpForm)),
    );
  }
}
