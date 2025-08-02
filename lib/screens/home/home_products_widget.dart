import 'package:flutter/material.dart';
import 'package:wprestapi/models/product.dart';
import 'package:wprestapi/services/api_service.dart';

class HomeProductsWidget extends StatefulWidget {
  const HomeProductsWidget({super.key});

  @override
  State<HomeProductsWidget> createState() => _HomeProductsWidgetState();
}

class _HomeProductsWidgetState extends State<HomeProductsWidget> {
  bool isGrid = true;
  late Future<List<Product>> _products;
  var api = ApiService();
  @override
  void initState() {
    super.initState();
    _products = api.getProducts();
    print("Jitendra: Products fetched ggggg ${_products}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        FutureBuilder<List<Product>>(
          future: _products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // print("Jitendra: Products Error ${snapshot.data}");
              return Center(child: Text('Error: \${snapshot.error}'));
            } else {
              final products = snapshot.data!;
              if (isGrid) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(product: product);
                  },
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductListTile(product: product);
                  },
                );
              }
            }
          },
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;

  const ProductCard({required this.product, this.onAddToCart});
  @override
  Widget build(BuildContext context) {
    print("Jitendra: Product Card ${product.name}");
    return Container(
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
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
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
          SizedBox(height: 8),

          Text(
            product.name,
            style: TextStyle(
              fontFamily: 'Orbitron',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 8),
              Text(
                '\$${product.price}',
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 8),
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
              SizedBox(width: 8),
            ],
          )



        ],
      ),
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
