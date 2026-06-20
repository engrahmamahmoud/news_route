// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../data/models/category_model.dart';
// import '../providers/app_provider.dart';
//
// class CategoryCard extends StatelessWidget {
//   final CategoryModel category;
//   final VoidCallback onTap;
//
//   const CategoryCard({super.key, required this.category, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     final appProvider = context.watch<AppProvider>();
//     final isArabic = appProvider.isArabic;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
//     final borderColor = isDark ? Colors.white24 : const Color(0xFFE7E7E7);
//     final titleColor = isDark ? Colors.white : Colors.black;
//     final buttonBg = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF4F4F4);
//     final buttonTextColor = isDark ? Colors.white : Colors.black87;
//     final arrowBg = isDark ? Colors.white : Colors.black;
//     final arrowColor = isDark ? Colors.black : Colors.white;
//
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(24),
//       child: Container(
//         width: double.infinity,
//         height: 198,
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(color: borderColor, width: 1),
//           boxShadow: isDark
//               ? []
//               : [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.05),
//                     blurRadius: 14,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//         ),
//         child: Stack(
//           children: [
//             /// LEFT SIDE CONTENT
//             Align(
//               alignment: isArabic ? Alignment.topRight : Alignment.topLeft,
//               child: SizedBox(
//                 width: 155,
//                 child: Column(
//                   crossAxisAlignment: isArabic
//                       ? CrossAxisAlignment.end
//                       : CrossAxisAlignment.start,
//                   children: [
//                     /// CATEGORY TITLE
//                     Text(
//                       category.getTitle(appProvider.locale.languageCode),
//                       textAlign: isArabic ? TextAlign.right : TextAlign.left,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         color: titleColor,
//                         fontSize: 28,
//                         fontWeight: FontWeight.w700,
//                         height: 1.15,
//                       ),
//                     ),
//
//                     const Spacer(),
//
//                     /// VIEW ALL BUTTON
//                     Container(
//                       height: 44,
//                       padding: const EdgeInsets.symmetric(horizontal: 14),
//                       decoration: BoxDecoration(
//                         color: buttonBg,
//                         borderRadius: BorderRadius.circular(999),
//                         border: Border.all(
//                           color: isDark
//                               ? Colors.white12
//                               : const Color(0xFFE3E3E3),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             isArabic ? 'عرض الكل' : 'View All',
//                             style: TextStyle(
//                               color: buttonTextColor,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Container(
//                             width: 28,
//                             height: 28,
//                             decoration: BoxDecoration(
//                               color: arrowBg,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               isArabic
//                                   ? Icons.arrow_back_ios_new_rounded
//                                   : Icons.arrow_forward_ios_rounded,
//                               size: 14,
//                               color: arrowColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             /// RIGHT / LOWER IMAGE
//             Align(
//               alignment: isArabic
//                   ? Alignment.bottomLeft
//                   : Alignment.bottomRight,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: SizedBox(
//                   width: 150,
//                   height: 155,
//                   child: Image.asset(category.image, fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/category_model.dart';
import '../providers/app_provider.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final isArabic = appProvider.isArabic;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.white24 : const Color(0xFFE7E7E7);
    final titleColor = isDark ? Colors.white : Colors.black;
    final buttonBg = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF4F4F4);
    final buttonTextColor = isDark ? Colors.white : Colors.black87;
    final arrowBg = isDark ? Colors.white : Colors.black;
    final arrowColor = isDark ? Colors.black : Colors.white;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        height: 198,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Stack(
          children: [
            /// LEFT SIDE CONTENT
            Align(
              alignment: isArabic ? Alignment.topRight : Alignment.topLeft,
              child: SizedBox(
                width: 155,
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    /// CATEGORY TITLE
                    Text(
                      category.getTitle(appProvider.locale.languageCode),
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                      ),
                    ),

                    const Spacer(),

                    /// VIEW ALL BUTTON
                    Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: buttonBg,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isDark
                              ? Colors.white12
                              : const Color(0xFFE3E3E3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isArabic ? 'عرض الكل' : 'View All',
                            style: TextStyle(
                              color: buttonTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: arrowBg,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isArabic
                                  ? Icons.arrow_back_ios_new_rounded
                                  : Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: arrowColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// RIGHT / LOWER IMAGE
            Align(
              alignment: isArabic
                  ? Alignment.bottomLeft
                  : Alignment.bottomRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: 150,
                  height: 155,
                  child: Image.asset(category.image, fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
