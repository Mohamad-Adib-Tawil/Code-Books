import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PDFViewerScreen extends StatefulWidget {
  const PDFViewerScreen({super.key, required this.book});

  final BookEntity book;

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  late final WebViewController _controller;
  String? _pageError;

  @override
  void initState() {
    super.initState();

    final initialUrl = _resolveReaderUrl(widget.book);
    final controller = WebViewController();

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) {
              setState(() => _pageError = null);
            }
          },
          onNavigationRequest: (request) {
            final secureUrl = _toHttps(request.url);
            if (secureUrl != request.url) {
              controller.loadRequest(Uri.parse(secureUrl));
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) {
            if (error.isForMainFrame == true && mounted) {
              setState(() => _pageError = error.description);
            }
          },
          onHttpError: (error) {
            if (mounted) {
              setState(() {
                _pageError =
                    'HTTP error ${error.response?.statusCode ?? 'unknown'}';
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(initialUrl));

    _controller = controller;
  }

  static String _resolveReaderUrl(BookEntity book) {
    final candidates = <String>[book.accessInfoWebReaderLink, book.previewLink];

    final url = candidates.firstWhere(
      (candidate) => candidate.trim().isNotEmpty,
      orElse: () => 'https://books.google.com',
    );

    return _toGoogleBooksEmbedUrl(_toHttps(url), book.idBook);
  }

  static String _toHttps(String url) {
    final uri = Uri.tryParse(url.trim());
    if (uri == null || uri.scheme != 'http') {
      return url;
    }

    return uri.replace(scheme: 'https').toString();
  }

  static String _toGoogleBooksEmbedUrl(String url, String fallbackBookId) {
    final uri = Uri.tryParse(url.trim());
    if (uri == null) {
      return url;
    }

    final bookId = uri.queryParameters['id']?.trim().isNotEmpty == true
        ? uri.queryParameters['id']!.trim()
        : fallbackBookId.trim();

    if (bookId.isEmpty || !uri.host.contains('google')) {
      return url;
    }

    return Uri.https('books.google.com', '/books', {
      'id': bookId,
      'output': 'embed',
    }).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(widget.book.title)),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_pageError != null)
            _ReaderErrorView(
              message: _pageError!,
              onRetry: () {
                _controller.loadRequest(
                  Uri.parse(_resolveReaderUrl(widget.book)),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _ReaderErrorView extends StatelessWidget {
  const _ReaderErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 42),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              FilledButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}
