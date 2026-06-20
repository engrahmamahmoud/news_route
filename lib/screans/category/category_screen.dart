import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/article_model.dart';
import '../../data/models/category_model.dart';
import '../../providers/app_provider.dart';
import '../../providers/news_provider.dart';
import '../../widgets/news_card.dart';
import '../../widgets/source_tab.dart';
import '../search/search_screen.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/category';

  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectedSourceIndex = 0;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_loaded) return;
    _loaded = true;

    final category =
        ModalRoute.of(context)!.settings.arguments as CategoryModel;

    final appProvider = context.read<AppProvider>();
    final newsProvider = context.read<NewsProvider>();

    newsProvider.fetchCategoryNews(
      category: category.id,
      language: appProvider.isArabic ? 'ar' : 'en',
    );
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final newsProvider = context.watch<NewsProvider>();

    final category =
        ModalRoute.of(context)!.settings.arguments as CategoryModel;

    final sources = ['All', ...newsProvider.sources];
    final selectedSource = sources[selectedSourceIndex];

    List<ArticleModel> displayedArticles = newsProvider.getArticlesBySource(
      selectedSource,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(category.getTitle(appProvider.locale.languageCode)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, size: 30),
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
          ),
        ],
      ),
      body: newsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 42,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: sources.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 18),
                      itemBuilder: (context, index) {
                        final source = sources[index];
                        return SourceTab(
                          title: source,
                          isSelected: selectedSourceIndex == index,
                          onTap: () {
                            setState(() {
                              selectedSourceIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 18),

                  Expanded(
                    child: displayedArticles.isEmpty
                        ? Center(
                            child: Text(
                              appProvider.isArabic
                                  ? 'لا توجد أخبار متاحة'
                                  : 'No articles available',
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            physics: const BouncingScrollPhysics(),
                            itemCount: displayedArticles.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 18),
                            itemBuilder: (context, index) {
                              final article = displayedArticles[index];
                              return NewsCard(
                                article: article,
                                showDescription: index == 0,
                                showViewFullArticleButton: index == 0,
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
