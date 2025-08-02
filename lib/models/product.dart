class Product {
  final int id;
  final String name;
  final String slug;
  final String permalink;
  final String description;
  final String shortDescription;
  final String price;
  final String regularPrice;
  final String salePrice;
  final String sku;
  final String stockStatus;
  final List<ProductImage> images;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.description,
    required this.shortDescription,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.sku,
    required this.stockStatus,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      permalink: json['permalink'] ?? '',
      description: json['description'] ?? '',
      shortDescription: json['short_description'] ?? '',
      price: json['prices']['price'] ?? '0.0',
      regularPrice: json['prices']['regular_price'] ?? '0.0',
      salePrice: json['sale_price'] ?? '',
      sku: json['sku'] ?? '',
      stockStatus: json['stock_status'] ?? '',
      images: (json['images'] as List<dynamic>?)
          ?.map((img) => ProductImage.fromJson(img))
          .toList() ??
          [],
    );
  }
}

class ProductCategory {
  final int id;
  final String name;
  final String slug;

  ProductCategory({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}

class ProductImage {
  final int id;
  final String src;
  final String name;

  ProductImage({
    required this.id,
    required this.src,
    required this.name,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] ?? 0,
      src: json['src'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
