import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeSlideshow extends StatelessWidget {
  final List<String> images = [
    'assets/slide1.jpg',
    'assets/slide2.jpg',
    'assets/slide3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        aspectRatio: 16 / 9,
        autoPlayInterval: Duration(seconds: 3),
      ),
      items: images.map((img) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.3),
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.asset(
              img,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      }).toList(),
    );
  }
}