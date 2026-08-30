# Core — Claude Memory

## What it does
طبقة البنية التحتية المشتركة: API client، DI، routing، logging، error types، utilities.

## File Map
```
lib/core/
├── errors/
│   ├── failure.dart              # Failure (abstract), ServerFailure, CacheFailure
│   └── retry.dart                # retry<T>(fn, retries, delay) utility
├── use_cases/
│   └── use_case.dart             # UseCase<T, P> abstract base class
├── utils/
│   ├── api_services.dart         # Dio wrapper — GET with retry, base URL from env
│   ├── app_logger.dart           # AppLogger.info/error/debug static methods
│   ├── app_router.dart           # GoRouter setup, route constants
│   ├── simple_bloc_observer.dart # BlocObserver for logging state transitions
│   ├── styles.dart               # TextStyles shared constants
│   └── functions/
│       ├── setup_service_locator.dart  # get_it wiring (ApiServices, HomeRepoImpl)
│       ├── build_error_snack_bar.dart  # Helper to show error SnackBar
│       ├── get_books_list.dart         # Parse API response → List<BookEntity>
│       └── save_book.dart              # Save BookEntity to Hive box
└── widgets/
    └── custom_fading_widget.dart  # Animated fade-in wrapper widget
```

## Key Classes/Methods
| Class/Function | File | Responsibility |
|----------------|------|---------------|
| `ApiServices.get()` | api_services.dart | GET request with 3 retries, throws ServerFailure |
| `AppLogger.info/error` | app_logger.dart | Centralized logging with name tag |
| `AppRouter.router` | app_router.dart | GoRouter singleton, 4 routes |
| `setupServiceLocator()` | functions/setup_service_locator.dart | Registers ApiServices + HomeRepoImpl in get_it |
| `retry<T>()` | errors/retry.dart | Generic retry with delay |
| `ServerFailure.fromDioException()` | errors/failure.dart | Maps DioException → ServerFailure |

## Known Issues
- [ ] لا يوجد interceptor للـ auth headers (لأن الـ API public حالياً)
- [ ] `styles.dart` — تحقق إن كانت تُستخدم فعلاً أو مكررة مع ثوابت `contants.dart`

## Dependencies
- **يُستخدم من**: كل feature (home, pdf)
- **يعتمد على**: dio, get_it, go_router, flutter_bloc, hive

## Last Updated
2026-06-27 — Initial memory generation
