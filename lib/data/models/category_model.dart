class CategoryModel {
  final String id;
  final String titleEn;
  final String titleAr;
  final String image;

  const CategoryModel({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.image,
  });

  String getTitle(String langCode) {
    return langCode == 'ar' ? titleAr : titleEn;
  }
}
