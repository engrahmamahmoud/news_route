// import 'package:flutter/material.dart';
//
// import '../data/dummy/dummy_news.dart';
// import '../data/models/article_model.dart';
// import '../data/servar/news_api_service.dart';
//
// class NewsProvider extends ChangeNotifier {
//   final NewsApiService _newsApiService = NewsApiService();
//
//   List<ArticleModel> _categoryArticles = [];
//   List<ArticleModel> _searchResults = [];
//   List<String> _sources = [];
//
//   bool _isLoading = false;
//   String? _errorMessage;
//
//   List<ArticleModel> get categoryArticles => _categoryArticles;
//   List<ArticleModel> get searchResults => _searchResults;
//   List<String> get sources => _sources;
//
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//
//   Future<void> fetchCategoryNews({
//     required String category,
//     required String language,
//   }) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       _categoryArticles = await _newsApiService.getTopHeadlines(
//         category: category,
//         language: language,
//       );
//
//       if (_categoryArticles.isEmpty) {
//         _categoryArticles = DummyNews.articles
//             .where((article) => article.categoryId == category)
//             .toList();
//       }
//
//       _sources = await _newsApiService.getSources(
//         category: category,
//         language: language,
//       );
//
//       if (_sources.isEmpty) {
//         _sources = DummyNews.sources;
//       }
//     } catch (e) {
//       _categoryArticles = DummyNews.articles
//           .where((article) => article.categoryId == category)
//           .toList();
//       _sources = DummyNews.sources;
//       _errorMessage = e.toString();
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   Future<void> searchNews({
//     required String query,
//     required String language,
//   }) async {
//     if (query.trim().isEmpty) {
//       _searchResults = [];
//       notifyListeners();
//       return;
//     }
//
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       _searchResults = await _newsApiService.searchNews(
//         query: query,
//         language: language,
//       );
//
//       if (_searchResults.isEmpty) {
//         _searchResults = DummyNews.articles.where((article) {
//           return article.titleEn.toLowerCase().contains(query.toLowerCase()) ||
//               article.titleAr.toLowerCase().contains(query.toLowerCase());
//         }).toList();
//       }
//     } catch (e) {
//       _searchResults = DummyNews.articles.where((article) {
//         return article.titleEn.toLowerCase().contains(query.toLowerCase()) ||
//             article.titleAr.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//       _errorMessage = e.toString();
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   List<ArticleModel> getArticlesBySource(String sourceName) {
//     if (sourceName == 'All') return _categoryArticles;
//     return _categoryArticles.where((a) => a.source == sourceName).toList();
//   }
//
//   void clearSearch() {
//     _searchResults = [];
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';

import '../data/dummy/dummy_news.dart';
import '../data/models/article_model.dart';
import '../data/servar/news_api_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsApiService _newsApiService = NewsApiService();

  List<ArticleModel> _categoryArticles = [];
  List<ArticleModel> _searchResults = [];
  List<String> _sources = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<ArticleModel> get categoryArticles => _categoryArticles;
  List<ArticleModel> get searchResults => _searchResults;
  List<String> get sources => _sources;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCategoryNews({
    required String category,
    required String language,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      /// 1) هات مقالات الـ API
      final apiArticles = await _newsApiService.getTopHeadlines(
        category: category,
        language: language,
      );

      /// 2) هات مقالات الـ dummy لنفس الكاتيجوري
      final dummyArticles = DummyNews.articles
          .where((article) => article.categoryId == category)
          .toList();

      /// 3) ادمجهم مع بعض
      _categoryArticles = [...apiArticles, ...dummyArticles];

      /// 4) شيل الدوبلكيت حسب العنوان
      final seenTitles = <String>{};
      _categoryArticles = _categoryArticles.where((article) {
        final key = article.titleEn.trim().toLowerCase();
        if (seenTitles.contains(key)) return false;
        seenTitles.add(key);
        return true;
      }).toList();

      /// 5) طلّع الـ sources من المقالات نفسها
      _sources = _categoryArticles
          .map((article) => article.source.trim())
          .where((source) => source.isNotEmpty)
          .toSet()
          .toList();

      /// اختياري: خلي All أول تاب
      _sources.sort();
    } catch (e) {
      /// لو الـ API فشل خالص استخدم الـ dummy فقط
      _categoryArticles = DummyNews.articles
          .where((article) => article.categoryId == category)
          .toList();

      _sources = _categoryArticles
          .map((article) => article.source.trim())
          .where((source) => source.isNotEmpty)
          .toSet()
          .toList();

      _sources.sort();
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchNews({
    required String query,
    required String language,
  }) async {
    if (query.trim().isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final apiResults = await _newsApiService.searchNews(
        query: query,
        language: language,
      );

      final dummyResults = DummyNews.articles.where((article) {
        return article.titleEn.toLowerCase().contains(query.toLowerCase()) ||
            article.titleAr.toLowerCase().contains(query.toLowerCase());
      }).toList();

      _searchResults = [...apiResults, ...dummyResults];

      final seenTitles = <String>{};
      _searchResults = _searchResults.where((article) {
        final key = article.titleEn.trim().toLowerCase();
        if (seenTitles.contains(key)) return false;
        seenTitles.add(key);
        return true;
      }).toList();
    } catch (e) {
      _searchResults = DummyNews.articles.where((article) {
        return article.titleEn.toLowerCase().contains(query.toLowerCase()) ||
            article.titleAr.toLowerCase().contains(query.toLowerCase());
      }).toList();

      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  List<ArticleModel> getArticlesBySource(String sourceName) {
    if (sourceName == 'All') return _categoryArticles;

    return _categoryArticles.where((article) {
      return article.source.trim().toLowerCase() ==
          sourceName.trim().toLowerCase();
    }).toList();
  }

  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }
}
