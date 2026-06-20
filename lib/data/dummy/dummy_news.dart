import '../../core/constants/app_assets.dart';
import '../models/article_model.dart';
import '../models/category_model.dart';

class DummyNews {
  static const List<CategoryModel> categories = [
    CategoryModel(
      id: 'general',
      titleEn: 'General',
      titleAr: 'عام',
      image: AppAssets.general,
    ),
    CategoryModel(
      id: 'business',
      titleEn: 'Business',
      titleAr: 'أعمال',
      image: AppAssets.business,
    ),
    CategoryModel(
      id: 'sports',
      titleEn: 'Sports',
      titleAr: 'رياضة',
      image: AppAssets.sports,
    ),
  ];

  static const List<String> sources = [
    'ABC News',
    'Aftenposten',
    'ANSA.it',
    'Ary News',
    'Axios',
  ];

  static const List<ArticleModel> articles = [
    ArticleModel(
      source: 'ABC News',
      titleEn:
          '40-year-old man falls 200 feet to his death while canyoneering at national park',
      titleAr:
          'رجل يبلغ من العمر 40 عامًا يسقط من ارتفاع 200 قدم أثناء مغامرة في إحدى الحدائق الوطنية',
      author: 'Jon Haworth',
      time: '15 minutes ago',
      image: AppAssets.general,
      descriptionEn:
          'A 40-year-old man has died after a canyoneering accident at a national park, according to officials.',
      descriptionAr:
          'توفي رجل يبلغ من العمر 40 عامًا بعد حادث أثناء ممارسة نشاط المغامرات في إحدى الحدائق الوطنية وفقًا للمسؤولين.',
      categoryId: 'general',
    ),
    ArticleModel(
      source: 'Aftenposten',
      titleEn:
          'Nobel Prize in physics awarded to two scientists for machine learning discoveries',
      titleAr:
          'منح جائزة نوبل في الفيزياء لعالمين بسبب اكتشافات في مجال تعلم الآلة',
      author: 'Daniel Niemann',
      time: '18 minutes ago',
      image: AppAssets.business,
      descriptionEn:
          'Two scientists received the Nobel Prize in physics for breakthroughs related to machine learning.',
      descriptionAr:
          'حصل عالمان على جائزة نوبل في الفيزياء بفضل إنجازات مرتبطة بتعلم الآلة.',
      categoryId: 'general',
    ),
    ArticleModel(
      source: 'ANSA.it',
      titleEn: 'Global markets rise as investors await central bank decision',
      titleAr: 'الأسواق العالمية ترتفع مع ترقب المستثمرين لقرار البنك المركزي',
      author: 'Editorial Team',
      time: '25 minutes ago',
      image: AppAssets.business,
      descriptionEn:
          'Stocks climbed globally as investors monitored inflation data and awaited interest rate decisions.',
      descriptionAr:
          'ارتفعت الأسهم عالميًا مع متابعة المستثمرين لبيانات التضخم وترقب قرارات أسعار الفائدة.',
      categoryId: 'business',
    ),
    ArticleModel(
      source: 'Ary News',
      titleEn:
          'Local team secures dramatic victory in final minutes of championship match',
      titleAr:
          'فريق محلي يحقق فوزًا مثيرًا في الدقائق الأخيرة من مباراة البطولة',
      author: 'Sports Desk',
      time: '30 minutes ago',
      image: AppAssets.sports,
      descriptionEn:
          'An exciting finish gave the local side a memorable championship win.',
      descriptionAr:
          'نهاية مثيرة منحت الفريق المحلي فوزًا لا يُنسى في البطولة.',
      categoryId: 'sports',
    ),
    ArticleModel(
      source: 'Axios',
      titleEn: 'Tech companies invest heavily in AI-powered business tools',
      titleAr:
          'شركات التكنولوجيا تستثمر بقوة في أدوات الأعمال المدعومة بالذكاء الاصطناعي',
      author: 'Tech Reporter',
      time: '40 minutes ago',
      image: AppAssets.general,
      descriptionEn:
          'Companies are racing to launch AI-powered productivity and business products.',
      descriptionAr:
          'تتسابق الشركات لإطلاق منتجات أعمال وإنتاجية مدعومة بالذكاء الاصطناعي.',
      categoryId: 'business',
    ),
  ];
}
