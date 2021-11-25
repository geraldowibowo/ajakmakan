import 'dart:ui';

import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final MediaQueryData mediaQuery;

  SearchBar(this.mediaQuery);

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();

    return Row(children: [
      Container(
        alignment: Alignment.topLeft,
        width: mediaQuery.size.width - 60,
        height: 45,
        child: Padding(
          padding: const EdgeInsets.only(left: 13, top: 2, bottom: 6, right: 5),
          child: Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromRGBO(230, 230, 230, 1),
            ),
            child: TextField(
              autofocus: false,
              style: TextStyle(fontSize: 15),
              cursorColor: Colors.red,
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Makanan, Restoran, Kategori',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                    alignment: Alignment.centerRight,
                    iconSize: 20,
                    onPressed: _controller.clear,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey,
                    )),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 15, left: 7, top: 3, bottom: 2),
        child: Image.asset(
          'assets/images/filter button.png',
          fit: BoxFit.cover,
          alignment: Alignment.center,
          height: 20,
        ),
      )
    ]);
  }
}
