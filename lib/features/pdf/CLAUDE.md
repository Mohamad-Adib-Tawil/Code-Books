# Feature: pdf/reader — Claude Memory

## What it does
عرض كتاب عبر WebView باستخدام Google Books embed URL. يحوّل أي رابط من `BookEntity` (webReaderLink أو previewLink) إلى رابط embed آمن (HTTPS).

## File Map
```
lib/features/pdf/
└── presentation/view/
    └── pdf_page.dart   # PDFViewerScreen + _ReaderErrorView + URL helpers
```

## Key Classes/Methods
| Class/Method | Responsibility |
|-------------|---------------|
| `PDFViewerScreen` | StatefulWidget — يُهيئ WebViewController في initState |
| `_resolveReaderUrl()` | يختار أفضل URL من BookEntity (webReaderLink أولاً) |
| `_toHttps()` | يحوّل http → https |
| `_toGoogleBooksEmbedUrl()` | يبني `books.google.com/books?id=X&output=embed` |
| `_ReaderErrorView` | عرض رسالة خطأ + زر Retry |

## Navigation
يُفتح من `book_details_view.dart` — يُمرَّر `BookEntity` كـ constructor argument (ليس عبر GoRouter extra).

## Known Issues
- [ ] لا يوجد loading indicator أثناء تحميل الصفحة
- [ ] بعض الكتب تعرض "preview limited" من Google — لا حل بدون مفتاح API مدفوع
- [ ] لا يُسجَّل route في `app_router.dart` — يُفتح مباشرة بـ `Navigator.push`

## Dependencies
- **يعتمد على**: `BookEntity` (home feature)، `webview_flutter`
- **لا يستخدم**: أي cubit أو repository — stateful فقط

## Last Updated
2026-06-27 — Initial memory generation
