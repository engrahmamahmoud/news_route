import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../../providers/news_provider.dart';
import '../../widgets/news_card.dart';
import '../../widgets/search_bar_widget.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final appProvider = context.read<AppProvider>();
      final newsProvider = context.read<NewsProvider>();

      newsProvider.searchNews(
        query: _searchController.text,
        language: appProvider.isArabic ? 'ar' : 'en',
      );
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final newsProvider = context.watch<NewsProvider>();

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              SearchBarWidget(
                controller: _searchController,
                hintText: appProvider.isArabic ? 'ابحث...' : 'Search',
              ),
              const SizedBox(height: 18),
              Expanded(
                child: newsProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _searchController.text.trim().isEmpty
                    ? Center(
                        child: Text(
                          appProvider.isArabic
                              ? 'ابدئي في البحث عن الأخبار'
                              : 'Start searching for news',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      )
                    : newsProvider.searchResults.isEmpty
                    ? Center(
                        child: Text(
                          appProvider.isArabic
                              ? 'لا توجد نتائج'
                              : 'No Results Found',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: newsProvider.searchResults.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return NewsCard(
                            article: newsProvider.searchResults[index],
                            compact: true,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
