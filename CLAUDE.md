# code_books — Claude Memory

## Quick Summary
تطبيق Flutter لعرض كتب البرمجة عبر Google Books API، مع دعم التصفح، البحث، التفاصيل، وقراءة الكتب عبر WebView.

## Stack
- Flutter: 3.x / Dart SDK ^3.8.1
- State: flutter_bloc ^9.0.0 (Cubit pattern)
- Router: go_router ^14.2.7
- Backend: Google Books API v1 (REST via Dio)
- Cache: Hive ^2.2.3 (offline cache per category)
- DI: get_it ^7.7.0 (manual, no injectable)
- Key packages: dio, dartz, cached_network_image, webview_flutter, flutter_svg

## Architecture
Clean Architecture + Feature-first (partial)
```
Data flow: UI → Cubit → UseCase → RepoImpl → [LocalDataSource | RemoteDataSource] → API/Hive
```

## Folder Map
```
lib/
├── contants.dart          # Colors, fonts, Hive box names, boxNameFor()
├── main.dart              # App entry, Hive init, MultiBlocProvider, GoRouter
├── core/
│   ├── errors/            # Failure, ServerFailure, retry util
│   ├── use_cases/         # UseCase base class
│   ├── utils/
│   │   ├── api_services.dart      # Dio wrapper, retry(3), base URL from env
│   │   ├── app_logger.dart        # Centralized logger
│   │   ├── app_router.dart        # GoRouter: /, /homeView, /bookDetailsView, /searchView
│   │   ├── simple_bloc_observer.dart
│   │   ├── styles.dart
│   │   └── functions/
│   │       ├── setup_service_locator.dart  # get_it wiring
│   │       ├── build_error_snack_bar.dart
│   │       ├── get_books_list.dart
│   │       └── save_book.dart
│   └── widgets/
│       └── custom_fading_widget.dart
├── home/                  # Main feature (see lib/home/CLAUDE.md)
│   ├── data/
│   ├── domain/
│   └── presentation/
└── features/
    └── pdf/               # PDF/WebView reader (see lib/features/pdf/CLAUDE.md)
        └── presentation/view/pdf_page.dart
```

## Feature Index
| Feature | Description | Status |
|---------|-------------|--------|
| home | عرض كتب شائعة وأحدث كتب، تصفح بالفئات، pagination | ✅ Done |
| search | بحث نصي عبر Google Books API | ✅ Done |
| book_details | تفاصيل الكتاب + أزرار القراءة | ✅ Done |
| pdf/reader | WebView reader لـ Google Books embed | ✅ Done |

## State Management Pattern
```dart
// Cubit يُستدعى من BlocProvider في main.dart أو عند بناء الـ widget
class PopularBooksCubit extends Cubit<PopularBooksCubitState> {
  Future<void> fetchPopualrBooks({int pageNumber = 0, String searchName = 'programming', String sord = 'popular'}) async {
    emit(pageNumber == 0 ? PopularBooksLoading() : PopularBooksPaginationLoading());
    final result = await useCase.call(pageNumber, searchName, sord);
    result.fold((l) => emit(PopularBooksFailure(l.toString())), (r) => emit(PopularBooksSuccess(r)));
  }
}
```

## API / Backend Notes
- Base URL: `https://www.googleapis.com/books/v1/` (override via `GOOGLE_BOOKS_BASE_URL` env var)
- Auth: لا يوجد — public API (بدون مفتاح API حالياً)
- Error handling: `dartz Either<Failure, T>` في كل طبقة، `ServerFailure.fromDioException` للـ Dio errors
- Retry: تلقائي 3 مرات في `ApiServices.get()` عبر `retry()` util

## Hive Boxes
| Box name | Type | المحتوى |
|----------|------|---------|
| `PopularBox` | BookEntity | كتب popular الافتراضية |
| `kNewestBox` | BookEntity | كتب newest الافتراضية |
| `books_{sort}_{category}` | BookEntity | cache ديناميكي لكل فئة via `boxNameFor()` |

## Routes
| Path | Screen | Extra |
|------|--------|-------|
| `/` | HomeView | — |
| `/homeView` | HomeView | — |
| `/bookDetailsView` | BoookDetailsView | BookEntity (required) |
| `/searchView` | SearchView | — |

## Known Issues & TODOs
- [ ] لا يوجد مفتاح Google Books API — سيصطدم بـ rate limit سريعاً
- [ ] `lib/home/presentation/views/widgets/test.dart` — ملف اختبار يدوي، dead code
- [ ] `lib/home/presentation/views/widgets/sugination_book.dart` — اسم مكرر/خطأ إملائي (suggetion vs sugination)
- [ ] `HomeRepo` يحتوي دوال مُعلّقة (fetchTrendBooks, fetchFavoritesBooks, fetchResumeReadingBooks)
- [ ] `FetchBooksInCubit` لا يستخدم `AppLogger` (غير متسق مع باقي cubits)

## Coding Rules
- الألوان والثوابت دائماً من `contants.dart` (kPrimaryColor, kBlackColor, إلخ)
- كل طلب API يمر عبر Repository → UseCase → Cubit، لا direct API calls من UI
- Cache-first: LocalDataSource أولاً، إن كان فارغاً → RemoteDataSource
- لا تعدّل ملفات `*.g.dart` يدوياً — شغّل `flutter pub run build_runner build`

## Files to NEVER touch
- `lib/home/domain/entities/book_entity.g.dart` — auto-generated (Hive adapter)

## Last Updated
2026-06-27 — Initial memory generation
