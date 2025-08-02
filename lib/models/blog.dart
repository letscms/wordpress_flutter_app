class Blog {
  final int id;
  final String title;
  final String imageUrl;
  final String excerpt;

  Blog({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.excerpt,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title']['rendered'],
      imageUrl: (json['_embedded']?['wp:featuredmedia']?[0]?['source_url']) ?? '',
      excerpt: json['excerpt']['rendered'],
    );
  }
}