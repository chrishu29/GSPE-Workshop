import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SwiperContent {
  static Swiper contentSwipe() {
    final List<String> contentList = [
      'Customer Return Item',
      'RMA Created',
      'In Repair',
      'Return Process',
    ];
    return Swiper(
      itemCount: contentList.length,
      autoplay: true,
      autoplayDelay: 3000,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pin_rounded),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      '123',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  contentList[index],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      pagination: SwiperPagination(), // Show pagination dots
      control: SwiperControl(), // Show navigation arrows
    );
  }
}
