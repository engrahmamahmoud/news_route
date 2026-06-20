import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../screans/home/home_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final isArabic = appProvider.isArabic;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
    final cardColor = isDark ? const Color(0xFF1B1B1B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final borderColor = isDark ? Colors.white30 : Colors.black12;

    return Drawer(
      backgroundColor: bgColor,
      width: MediaQuery.of(context).size.width * 0.68,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            crossAxisAlignment: isArabic
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              Text(
                'News App',
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 22),

              _DrawerTile(
                title: isArabic ? 'الذهاب للرئيسية' : 'Go To Home',
                icon: Icons.home_outlined,
                textColor: textColor,
                bgColor: cardColor,
                borderColor: borderColor,
                onTap: () {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(HomeScreen.routeName),
                  );
                },
              ),

              const SizedBox(height: 18),

              Text(
                isArabic ? 'Theme' : 'Theme',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              _DropdownContainer(
                bgColor: cardColor,
                borderColor: borderColor,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: cardColor,
                    value: appProvider.isDark ? 'dark' : 'light',
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: textColor,
                    ),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'dark',
                        child: Text(isArabic ? 'Dark' : 'Dark'),
                      ),
                      DropdownMenuItem(
                        value: 'light',
                        child: Text(isArabic ? 'Light' : 'Light'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      appProvider.toggleTheme(value == 'dark');
                    },
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Text(
                isArabic ? 'Language' : 'Language',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              _DropdownContainer(
                bgColor: cardColor,
                borderColor: borderColor,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: cardColor,
                    value: appProvider.isArabic ? 'ar' : 'en',
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: textColor,
                    ),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'en', child: Text('English')),
                      DropdownMenuItem(value: 'ar', child: Text('العربية')),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      appProvider.changeLanguage(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color textColor;
  final Color bgColor;
  final Color borderColor;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.title,
    required this.icon,
    required this.textColor,
    required this.bgColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownContainer extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final Color borderColor;

  const _DropdownContainer({
    required this.child,
    required this.bgColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Center(child: child),
    );
  }
}
