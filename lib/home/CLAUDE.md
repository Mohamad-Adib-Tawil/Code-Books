# Feature: home — Claude Memory

## What it does
الميزة الرئيسية: جلب وعرض كتب البرمجة من Google Books API مع دعم pagination، التصفية بالفئات، البحث، وعرض التفاصيل. يحتوي على 3 قوائم: Popular، Newest، وBooksIn (كتب حسب فئة محددة).

## File Map
```
lib/home/
├── data/
│   ├── data_sources/
│   │   ├── home_local_data_source.dart   # Hive cache read/write
│   │   └── home_remote_data_source.dart  # Google Books API calls via ApiServices
│   ├── models/book_model/
│   │   ├── book_model.dart               # JSON → BookEntity mapper (unused layer, entity used directly)
│   │   ├── access_info.dart              # AccessInfo sub-model
│   │   ├── image_links.dart              # ImageLinks sub-model
│   │   ├── industry_identifier.dart      # IndustryIdentifier sub-model
│   │   ├── panelization_summary.dart     # PanelizationSummary sub-model
│   │   ├── reading_modes.dart            # ReadingModes sub-model
│   │   ├── sale_info.dart                # SaleInfo sub-model
│   │   ├── search_info.dart              # SearchInfo sub-model
│   │   └── volume_info.dart              # VolumeInfo sub-model
│   └── repos_data/
│       └── home_repo_impl.dart           # Cache-first repo: local → remote fallback
├── domain/
│   ├── entities/
│   │   ├── book_entity.dart              # BookEntity (Hive @HiveType, 41 fields, fromJson)
│   │   ├── book_entity.g.dart            # AUTO-GENERATED — لا تعدّل
│   │   └── user_entity.dart              # UserEntity (غير مستخدم حالياً)
│   ├── repos_domain/
│   │   └── home_repo.dart                # HomeRepo abstract (3 methods)
│   └── use_cases/
│       ├── fetch_popular_books_use_case.dart  # FetchPopualrBooksUseCase
│       ├── fetch_newst_books_use_case.dart    # FetchNewestBooksUseCase
│       └── fetch_books_in.dart               # FetchBooksInBooksUseCase
└── presentation/
    ├── manger/
    │   ├── popular_books_cubit/cubit/
    │   │   ├── popular_books_cubit_cubit.dart  # PopularBooksCubit (4 methods)
    │   │   └── popular_books_cubit_state.dart  # 7 states
    │   ├── FetchNewestBooksCubit/
    │   │   ├── fetch_newest_books_cubit.dart   # FetchNewestBooksCubit (toggle بالفئة)
    │   │   └── fetch_newest_books_state.dart   # states متعددة بالفئة
    │   └── FetchBooksInCubit/
    │       ├── fetch_books_in_cubit.dart        # FetchBooksInCubit
    │       └── fetch_books_in_state.dart
    └── views/
        ├── home_view.dart                       # الشاشة الرئيسية
        ├── book_details_view.dart               # تفاصيل كتاب واحد
        ├── search_view.dart                     # بحث نصي
        └── widgets/                             # ~25 widget (انظر أدناه)
```

## Key Classes
| Class | File | Responsibility |
|-------|------|---------------|
| `HomeRepoImpl` | data/repos_data/home_repo_impl.dart | Cache-first: Hive أولاً ثم API |
| `HomeLocalDataSourceImpl` | data/data_sources/home_local_data_source.dart | قراءة/كتابة Hive بـ `boxNameFor()` |
| `HomeRemoteDataSourceImpl` | data/data_sources/home_remote_data_source.dart | طلبات Google Books API |
| `BookEntity` | domain/entities/book_entity.dart | الكيان الرئيسي (41 حقل + fromJson) |
| `PopularBooksCubit` | manger/popular_books_cubit/...dart | popular + trend + newest toggles |
| `FetchNewestBooksCubit` | manger/FetchNewestBooksCubit/...dart | newest + flutter/algorithms/js/python/php |
| `FetchBooksInCubit` | manger/FetchBooksInCubit/...dart | كتب حسب فئة معينة |

## Cubit States Summary
**PopularBooksCubitState**: Initial, Loading, PaginationLoading, Success, SuccessOtherBook, Trend, Newest, Failure, PaginationFailure

**FetchNewestBooksState**: Initial, Loading, PaginationLoading, Success, FlutterBooks, AlgorithmsBooks, JavaScriptBooks, PythonBooks, PhpBooks, Failure, PaginationFailure + loading states per category

**FetchBooksInState**: Initial, Loading, PaginationLoading, Success, Failure, PaginationFailure

## Important Widgets
| Widget | File | الوظيفة |
|--------|------|---------|
| `HomeViewBody` | widgets/home_view_body.dart | هيكل الصفحة الرئيسية |
| `BookStackBlocConsumer` | widgets/book_stack_bloc_consumer.dart | يستمع PopularBooksCubit |
| `ResumeBookListItemBlocConsumer` | widgets/resume_book_list_item_bloc_consumer.dart | يستمع FetchNewestBooksCubit |
| `CategoriesLine` | widgets/categories_line.dart | تبديل الفئات (popular/trend/newest) |
| `BookDetailsBody` | widgets/book_details_body.dart | تفاصيل الكتاب الكاملة |
| `BookItem` | widgets/book_item.dart | كارد كتاب في القوائم |
| `PagedWidget` | widgets/paged_widget.dart | pagination wrapper |

## Known Issues
- [ ] `widgets/test.dart` — dead code، ملف اختبار يدوي
- [ ] `widgets/sugination_book.dart` — خطأ إملائي (suggetion vs sugination)، تحقق هل مستخدم
- [ ] `user_entity.dart` — غير مستخدم حالياً
- [ ] `HomeRepo` يحتوي 3 دوال مُعلّقة بـ comment (fetchTrendBooks, fetchFavoritesBooks, fetchResumeReadingBooks)
- [ ] `FetchBooksInCubit` لا يستخدم `AppLogger` (غير متسق)

## Dependencies
- **يستخدم من**: `main.dart` (BlocProvider)، `app_router.dart` (navigation)
- **يعتمد على**: `lib/core/` (ApiServices, Failure, UseCase)، `lib/contants.dart` (box names)

## Last Updated
2026-06-27 — Initial memory generation
