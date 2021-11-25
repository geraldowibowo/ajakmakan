import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AdsSlider extends StatelessWidget {
  final MediaQueryData mediaQuery;

  AdsSlider(this.mediaQuery);

  @override
  Widget build(BuildContext context) {
    List<String> ads = [
      'assets/images/slider/Rectangle 5.png',
      'assets/images/slider/Rectangle 6.png'
    ];

    return CarouselSlider(
        items: ads.map((ad) {
          return Builder(builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: AssetImage(ad), fit: BoxFit.cover)),
            );
          });
        }).toList(),
        options: CarouselOptions(
          height: mediaQuery.size.width * 0.50625,
          autoPlay: true,
          viewportFraction: 1,
        ));
  }
}
