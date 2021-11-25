import 'package:flutter/material.dart';
import 'package:ajak_makan/dummy_data/dummy_data.dart';

class Categories extends StatelessWidget {
  final MediaQueryData mediaQuery;

  Categories(this.mediaQuery);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 5, left: 15),
        child: Text(
          'Categories',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        width: mediaQuery.size.width,
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(children: [
              Container(
                margin: EdgeInsets.only(left: 15, top: 7, bottom: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: AssetImage(DUMMY_CATEGORIES[index].imageUrl),
                        fit: BoxFit.cover)),
                height: 105,
                width: 105,
              ),
              Text(
                DUMMY_CATEGORIES[index].title,
                style: TextStyle(fontWeight: FontWeight.w700),
              )
            ]);
          },
          itemCount: DUMMY_CATEGORIES.length,
        ),
      ),
    ]);
  }
}
