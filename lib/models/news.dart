class News {
  final String title;
  final String description;
  final String imageUrl;
  final String source;
  final String publishedAt; // Added to meet date requirement

  News({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    String rawTitle = (json['title'] ?? 'No Title').toString();
    if (rawTitle == '[Removed]') rawTitle = 'Article no longer available';

    return News(
      title: rawTitle,
      description: (json['description'] ?? 'No description available.').toString(),
      imageUrl: (json['urlToImage'] ?? '').toString(),
      source: (json['source']?['name'] ?? 'Unknown Source').toString(),
      publishedAt: (json['publishedAt'] ?? '').toString(),
    );
  }
}