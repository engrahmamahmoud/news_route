import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : Colors.white;
    final logoTextColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            children: [
              const Spacer(),

              /// Mic in center
              Expanded(
                flex: 5,
                child: Center(
                  child: Image.asset(
                    AppAssets.mic,
                    width: 170,
                    height: 170,
                    fit: BoxFit.contain,
                    color: logoTextColor,
                  ),
                ),
              ),

              const Spacer(),

              /// Route branding at bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Image.asset(
                  AppAssets.routeBranding,
                  fit: BoxFit.contain,
                  color: logoTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
