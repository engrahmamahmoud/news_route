class ArticleModel {
  final String source;
  final String titleEn;
  final String titleAr;
  final String author;
  final String time;
  final String image;
  final String descriptionEn;
  final String descriptionAr;
  final String categoryId;
  final String? articleUrl;
  final DateTime? publishedAt;

  const ArticleModel({
    required this.source,
    required this.titleEn,
    required this.titleAr,
    required this.author,
    required this.time,
    required this.image,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.categoryId,
    this.articleUrl,
    this.publishedAt,
  });

  String getTitle(String langCode) {
    return langCode == 'ar' && titleAr.trim().isNotEmpty ? titleAr : titleEn;
  }

  String getDescription(String langCode) {
    return langCode == 'ar' && descriptionAr.trim().isNotEmpty
        ? descriptionAr
        : descriptionEn;
  }

  factory ArticleModel.fromJson(
    Map<String, dynamic> json, {
    required String categoryId,
  }) {
    final sourceMap = json['source'] as Map<String, dynamic>?;

    return ArticleModel(
      source: sourceMap?['name']?.toString() ?? 'Unknown Source',
      titleEn: json['title']?.toString() ?? 'No Title',
      // NewsAPI غالبًا مش بيرجع عربي، فهنكرر نفس العنوان مؤقتًا
      titleAr: json['title']?.toString() ?? 'No Title',
      author: json['author']?.toString() ?? 'Unknown Author',
      time: _formatPublishedTime(json['publishedAt']?.toString()),
      image: json['urlToImage']?.toString() ?? '',
      descriptionEn: json['description']?.toString() ?? '',
      descriptionAr: json['description']?.toString() ?? '',
      categoryId: categoryId,
      articleUrl: json['url']?.toString(),
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'].toString())
          : null,
    );
  }

  static String _formatPublishedTime(String? publishedAt) {
    if (publishedAt == null || publishedAt.isEmpty) return 'Recently';

    final date = DateTime.tryParse(publishedAt);
    if (date == null) return 'Recently';

    final diff = DateTime.now().difference(date.toLocal());

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    return '${diff.inDays} days ago';
  }
}
