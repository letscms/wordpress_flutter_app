import 'package:dio/dio.dart';
import 'package:wprestapi/models/product.dart';
import 'api_client.dart';
import 'package:wprestapi/models/blog.dart';
import 'package:wprestapi/models/category.dart';
class ApiService {
  final Dio _dio = ApiClient().dio;

  /// ✅ Fetch Posts
  Future<List<Blog>> getPosts() async {
    try {
      final response = await _dio.get("/wp/v2/posts");

      if (response.statusCode == 200) {
        // print("Jitendra: ${response.data}");
        return (response.data as List)
            .map((json) => Blog.fromJson(json))
            .toList();
        // return response.data;
      } else {
        throw Exception("Failed to load posts: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    }
  }

  /// ✅ Fetch Categories
  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio.get("/wc/store/v1/products/categories");
      // print("Jitendra categories hhhhhhhhh: ${response.data}");
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => Category.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load categories: ${response.statusCode}");
      }
      return response.data;
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    }
  }

  /// ✅ Fetch a Single Post by ID
  Future<Map<String, Blog>> getPostById(int id) async {
    try {
      final response = await _dio.get("posts/$id");
      return response.data;
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    }
  }

  /// ✅ Authenticated Request (JWT or Basic Auth)
  Future<List<Blog>> getPrivatePosts(String token) async {
    try {
      final response = await _dio.get(
        "posts",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception("Dio Auth Error: ${e.message}");
    }
  }


  Future<List<Blog>> fetchBlogs() async {
    final response = await _dio.get(
      'wp/v2/posts',
      queryParameters: {
        '_embed': 1,
        'per_page': 20,
      }
    );
    // print('RequestTest',response);
    return (response.data as List).map((json) => Blog.fromJson(json)).toList();
  }



  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get("/wc/store/v1/products");
      if (response.statusCode == 200) {
        // print("Jitendra products  list: ${response.data}");
        return (response.data as List)
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    }
  }
}

