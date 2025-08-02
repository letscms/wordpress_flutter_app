import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wprestapi/models/category.dart';
import 'package:wprestapi/services/api_service.dart';

class CategorySlider extends StatefulWidget {
  @override
  _CategorySliderState createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  late Future<List<Category>> _categories;
  var api = ApiService();
  @override
  void initState() {
    super.initState();
    _categories = api.getCategories();
    print("Jitendra: Categories fetched ${_categories.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _categories,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final categories = snapshot.data!;
        print("Jitendra: Categories length ${categories.length}");
        return CarouselSlider(
          options: CarouselOptions(
            height: 120,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
            viewportFraction: 0.4,
          ),
          items: categories.map((cat) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  cat.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}