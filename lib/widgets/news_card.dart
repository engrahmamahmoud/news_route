import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/article_model.dart';
import '../providers/app_provider.dart';

class NewsCard extends StatelessWidget {
  final ArticleModel article;
  final bool compact;
  final bool showDescription;
  final bool showViewFullArticleButton;

  const NewsCard({
    super.key,
    required this.article,
    this.compact = false,
    this.showDescription = false,
    this.showViewFullArticleButton = false,
  });

  bool get _isNetworkImage {
    return article.image.startsWith('http://') ||
        article.image.startsWith('https://');
  }

  Widget _buildImage({
    required double width,
    required double height,
    required double radius,
  }) {
    if (_isNetworkImage && article.image.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.network(
          article.image,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              width: width,
              height: height,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported_outlined, size: 32),
            );
          },
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Container(
              width: width,
              height: height,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(strokeWidth: 2),
            );
          },
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        article.image,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey.shade300,
            alignment: Alignment.center,
            child: const Icon(Icons.image_not_supported_outlined, size: 32),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final isArabic = appProvider.isArabic;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF1B1B1B) : Colors.white;
    final borderColor = isDark ? Colors.white : Colors.black26;
    final titleColor = isDark ? Colors.white : Colors.black;
    final subColor = isDark ? Colors.white70 : Colors.black54;

    if (compact) {
      return Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: 1),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            _buildImage(width: 110, height: 95, radius: 14),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: isArabic
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    article.getTitle(appProvider.locale.languageCode),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.time,
                    style: TextStyle(
                      color: subColor,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: isArabic
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          _buildImage(width: double.infinity, height: 250, radius: 22),

          const SizedBox(height: 16),

          Text(
            article.getTitle(appProvider.locale.languageCode),
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: Text(
                  isArabic
                      ? 'بواسطة: ${article.author}'
                      : 'By : ${article.author}',
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    color: subColor,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                article.time,
                style: TextStyle(
                  color: subColor,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          if (showDescription &&
              article
                  .getDescription(appProvider.locale.languageCode)
                  .isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              article.getDescription(appProvider.locale.languageCode),
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: TextStyle(color: subColor, fontSize: 14.5, height: 1.5),
            ),
          ],

          if (showViewFullArticleButton) ...[
            const SizedBox(height: 16),
            Align(
              alignment: isArabic
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    isArabic ? 'عرض المقال كامل' : 'View Full Article',
                    style: TextStyle(
                      color: isDark ? Colors.black : Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
