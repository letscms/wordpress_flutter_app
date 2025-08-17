import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wprestapi/models/product.dart';
import 'package:wprestapi/screens/home/Slider_widget.dart';
import 'package:wprestapi/screens/productdetail/productdetail_screen.dart';
import 'package:wprestapi/services/api_service.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({super.key});

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  bool isGrid = true;
  late Future<List<Product>> _products;
  var api = ApiService();

  double _sheetPosition = 0.5;
  final double _dragSensitivity = 600;

  @override
  void initState() {
    super.initState();
    _products = api.getProducts(); // Initialize once
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(isGrid ? Icons.grid_view : Icons.list),
                color: Colors.cyanAccent,
                onPressed: () {
                  setState(() {
                    isGrid = !isGrid;
                  });
                },
              ),
            ],
          ),
          SliderWidget(),
          Padding(padding: EdgeInsets.only(top: 10)),
          Expanded(
            flex: 1,
            child: FutureBuilder<List<Product>>(
              future: _products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No products found'));
                }
                final products = snapshot.data!;

                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      // TODO: Fetch more products here for infinite scroll
                    }
                    return false;
                  },
                  child: isGrid
                      ? GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return ProductCard(product: products[index]);
                          },
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return ProductListTile(product: products[index]);
                          },
                      ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }

}


class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;

  const ProductCard({required this.product, this.onAddToCart});
  @override
  Widget build(BuildContext context) {
    // print("Jitendra: Product Card ${product.name}");
    return
      InkWell(
        onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child:Container(
      margin: EdgeInsets.only(left: 4, right: 4, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.15),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
              child: Image.network(
                product.images.isNotEmpty
                    ? product.images.first.src
                    : 'assets/placeholder.png',
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/placeholder.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
              ),
              Text(
                product.name,
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 0),
              Text(
                '\$${product.price}',
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 0),
              IconButton(

                icon: Icon(Icons.shopping_cart),
                color: Colors.cyanAccent,
                onPressed:
                onAddToCart ??
                        () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added to cart: ${product.name}')),
                      );
                    },
              ),
              SizedBox(width: 0),
            ],
          )
        ],
      ),
    )
    );
  }
}

class ProductListTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;
  const ProductListTile({required this.product, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      contentPadding: EdgeInsets.only(bottom: 10, top: 1, left: 10, right: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.cyanAccent.withOpacity(0.3), width: 2),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          product.images.isNotEmpty
              ? product.images.first.src
              : 'assets/placeholder.png',
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/placeholder.png',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
      title: Text(
        product.name,
        style: TextStyle(
          fontFamily: 'Orbitron',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '\$${product.price}',
        style: TextStyle(
          color: Colors.cyanAccent,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.shopping_cart),
        color: Colors.cyanAccent,
        onPressed:
        onAddToCart ??
                () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Added to cart: ${product.name}')),
              );
            },
      ),
    );
  }
}

class Grabber extends StatelessWidget {
  const Grabber({super.key, required this.onVerticalDragUpdate, required this.isOnDesktopAndWeb});

  final ValueChanged<DragUpdateDetails> onVerticalDragUpdate;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    if (!isOnDesktopAndWeb) {
      return const SizedBox.shrink();
    }
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: Container(
        width: double.infinity,
        color: colorScheme.onSurface,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: 32.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
