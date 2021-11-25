import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        color: Colors.grey.withOpacity(0.5),
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                //CHECK FOR PROMO
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Promo Code',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(230, 230, 230, 1),
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(fontSize: 15),
                    cursorColor: Colors.red,
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Masukkan ID temanmu untuk cashback tambahan',
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

                //Payment Method List
                Container(),
                SizedBox(height: 150)
              ],
            )));
  }
}
