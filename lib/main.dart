import 'Profile/screens/edit_profile_address.dart';
import 'package:ajak_makan/Profile/screens/feedback_screen.dart';
import 'package:ajak_makan/login_screen/widgets/fill_address.dart';
import 'package:ajak_makan/login_screen/widgets/fill_username.dart';
import 'package:ajak_makan/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ajak_makan/login_screen/auth_screen.dart';
import 'tabs_screen.dart';

import 'Explore/screens/explore_restaurant/restaurant_homepage.dart';
import 'Explore/screens/basket_screen/basket_screen.dart';
import 'Explore/screens/meal_detail_screen/meal_detail_screen.dart';

import 'Orders/screens/order_screen.dart';

import 'providers/basket.dart';
// import 'providers/restaurants_provider.dart';

import 'package:firebase_app_check/firebase_app_check.dart';

// import 'package:ajak_makan/providers/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (ctx) => RestaurantsProvider()),
        ChangeNotifierProvider(create: (ctx) => Basket()),
        StreamProvider(
            create: (BuildContext context) => DatabaseService().customerData,
            initialData: null),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ajakmakan',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
                bodyText1: TextStyle(fontFamily: 'CreatoDisplay'),
                bodyText2: TextStyle(fontFamily: 'CreatoDisplay'),
                headline1: TextStyle(fontFamily: 'CreatoDisplay'),
                headline2: TextStyle(fontFamily: 'CreatoDisplay'),
                subtitle1: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                subtitle2: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black))),
        home: InitializerWidget(),
        routes: {
          TabsScreen.routeName: (ctx) => TabsScreen(),
          RestaurantHomepage.routeName: (ctx) => RestaurantHomepage(),
          BasketScreen.routeName: (ctx) => BasketScreen(),
          OrderScreen.routename: (ctx) => OrderScreen(),
          MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
          FillUsername.routeName: (ctx) => FillUsername(),
          FillAddress.routeName: (ctx) => FillAddress(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          EditProfileAddress.routeName: (ctx) => EditProfileAddress(),
          FeedbackScreen.routeName: (ctx) => FeedbackScreen(),
        },
        // onGenerateRoute: (settings) {},
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) => TabsScreen());
        },
      ),
    );
  }
}

class InitializerWidget extends StatefulWidget {
  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  FirebaseAuth _auth;

  User _user;

  bool isLoading = true;

  Widget nextScreen;

  Future<dynamic> goToNextScreen() async {
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
      if (data['username'] != '') {
        setState(() {
          nextScreen = TabsScreen();
          isLoading = false;
        });
      } else {
        setState(() {
          print('ERRRRRRRROR CANNOT FIND USER IN MAIN GOTONEXTSCREEN');
          nextScreen = AuthScreen();
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        print('ERRRRRRRROR IN MAIN GOTONEXTSCREEN');
        nextScreen = AuthScreen();
        isLoading = false;
      });
      throw error;
    }
  }

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    goToNextScreen().then((value) {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _user == null
            ? AuthScreen()
            : nextScreen;
  }
}
