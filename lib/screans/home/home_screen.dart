import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/dummy/dummy_news.dart';
import '../../data/models/category_model.dart';
import '../../providers/app_provider.dart';
import '../../widgets/category_card.dart';
import '../../widgets/custom_drawer.dart';
import '../category/category_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final isArabic = appProvider.isArabic;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: Text(isArabic ? 'الرئيسية' : 'Home'),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu_rounded, size: 28),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
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
        body: Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: isArabic
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),

                  /// Good Morning
                  Text(
                    isArabic ? 'صباح الخير' : 'Good Morning',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  ),
                  const SizedBox(height: 4),

                  Text(
                    isArabic
                        ? 'إليك بعض الأخبار من أجلك'
                        : 'Here is Some News For You',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  ),

                  const SizedBox(height: 20),

                  /// Categories list
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: DummyNews.categories.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final CategoryModel category =
                            DummyNews.categories[index];
                        return CategoryCard(
                          category: category,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              CategoryScreen.routeName,
                              arguments: category,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
