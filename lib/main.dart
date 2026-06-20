import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:new_route/screans/category/category_screen.dart';
import 'package:new_route/screans/home/home_screen.dart';
import 'package:new_route/screans/search/search_screen.dart';
import 'package:new_route/screans/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'providers/app_provider.dart';
import 'providers/news_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return Directionality(
            textDirection: appProvider.isArabic
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: MaterialApp(
              supportedLocales: const [Locale('en'), Locale('ar')],

              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              title: 'News App',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: appProvider.themeMode,
              locale: appProvider.locale,

              routes: {
                SplashScreen.routeName: (_) => const SplashScreen(),
                HomeScreen.routeName: (_) => const HomeScreen(),
                SearchScreen.routeName: (_) => const SearchScreen(),
                CategoryScreen.routeName: (_) => const CategoryScreen(),
              },
              initialRoute: SplashScreen.routeName,
            ),
          );
        },
      ),
    );
  }
}
