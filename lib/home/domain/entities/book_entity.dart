// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

part 'book_entity.g.dart';

@HiveType(typeId: 0)
class BookEntity {
  @HiveField(0)
  final String kindBook;

  @HiveField(1)
  final String idBook;

  @HiveField(2)
  final String etagBook;

  @HiveField(3)
  final String selfLinkBook;

  @HiveField(4)
  final String title;

  @HiveField(5)
  final List<String> authors;

  @HiveField(6)
  final String publisher;

  @HiveField(7)
  final String publishedDate;

  @HiveField(8)
  final String description;

  @HiveField(9)
  final String searchInfoTextSnippet;

  @HiveField(10)
  final bool readingModesText;

  @HiveField(11)
  final bool readingModesImage;

  @HiveField(12)
  final int pageCount;

  @HiveField(13)
  final String printType;

  @HiveField(14)
  final List<String> categories;

  @HiveField(15)
  final String maturityRating;

  @HiveField(16)
  final bool allowAnonLogging;

  @HiveField(17)
  final String contentVersion;

  @HiveField(18)
  final bool panelizationContainsEpubBubbles;

  @HiveField(19)
  final bool panelizationContainsImageBubbles;

  @HiveField(20)
  final String imageLinksSmallThumbnail;

  @HiveField(21)
  final String imageLinksThumbnail;

  @HiveField(22)
  final String language;

  @HiveField(23)
  final String previewLink;

  @HiveField(24)
  final String infoLink;

  @HiveField(25)
  final String canonicalVolumeLink;

  @HiveField(26)
  final String saleInfoCountry;

  @HiveField(27)
  final String saleInfoSaleability;

  @HiveField(28)
  final bool saleInfoIsEbook;

  @HiveField(29)
  final String accessInfoCountry;

  @HiveField(30)
  final String accessInfoViewability;

  @HiveField(31)
  final bool accessInfoEmbeddable;

  @HiveField(32)
  final bool accessInfoPublicDomain;

  @HiveField(33)
  final String accessInfoTextToSpeechPermission;

  @HiveField(34)
  final bool accessInfoEpubIsAvailable;

  @HiveField(35)
  final bool accessInfoPdfIsAvailable;

  @HiveField(36)
  final String accessInfoPdfAcsTokenLink;

  @HiveField(37)
  final String accessInfoWebReaderLink;

  @HiveField(38)
  final String accessInfoAccessViewStatus;

  @HiveField(39)
  final bool accessInfoQuoteSharingAllowed;
  @HiveField(40)
  final num averageRating;

  BookEntity({
    required this.kindBook,
    required this.idBook,
    required this.etagBook,
    required this.selfLinkBook,
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.readingModesText,
    required this.readingModesImage,
    required this.pageCount,
    required this.printType,
    required this.categories,
    required this.maturityRating,
    required this.allowAnonLogging,
    required this.contentVersion,
    required this.panelizationContainsEpubBubbles,
    required this.panelizationContainsImageBubbles,
    required this.imageLinksSmallThumbnail,
    required this.imageLinksThumbnail,
    required this.language,
    required this.previewLink,
    required this.infoLink,
    required this.canonicalVolumeLink,
    required this.saleInfoCountry,
    required this.saleInfoSaleability,
    required this.saleInfoIsEbook,
    required this.accessInfoCountry,
    required this.accessInfoViewability,
    required this.accessInfoEmbeddable,
    required this.accessInfoPublicDomain,
    required this.accessInfoTextToSpeechPermission,
    required this.accessInfoEpubIsAvailable,
    required this.accessInfoPdfIsAvailable,
    required this.accessInfoPdfAcsTokenLink,
    required this.accessInfoWebReaderLink,
    required this.accessInfoAccessViewStatus,
    required this.accessInfoQuoteSharingAllowed,
    required this.searchInfoTextSnippet,
    required this.averageRating,
  });
  factory BookEntity.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] is Map<String, dynamic>
        ? json['volumeInfo'] as Map<String, dynamic>
        : <String, dynamic>{};
    final readingModes = volumeInfo['readingModes'] is Map<String, dynamic>
        ? volumeInfo['readingModes'] as Map<String, dynamic>
        : <String, dynamic>{};
    final panelizationSummary =
        volumeInfo['panelizationSummary'] is Map<String, dynamic>
        ? volumeInfo['panelizationSummary'] as Map<String, dynamic>
        : <String, dynamic>{};
    final imageLinks = volumeInfo['imageLinks'] is Map<String, dynamic>
        ? volumeInfo['imageLinks'] as Map<String, dynamic>
        : <String, dynamic>{};
    final saleInfo = json['saleInfo'] is Map<String, dynamic>
        ? json['saleInfo'] as Map<String, dynamic>
        : <String, dynamic>{};
    final accessInfo = json['accessInfo'] is Map<String, dynamic>
        ? json['accessInfo'] as Map<String, dynamic>
        : <String, dynamic>{};
    final epub = accessInfo['epub'] is Map<String, dynamic>
        ? accessInfo['epub'] as Map<String, dynamic>
        : <String, dynamic>{};
    final pdf = accessInfo['pdf'] is Map<String, dynamic>
        ? accessInfo['pdf'] as Map<String, dynamic>
        : <String, dynamic>{};

    return BookEntity(
      kindBook: json['kind'] ?? '',
      idBook: json['id'] ?? '',
      etagBook: json['etag'] ?? '',
      selfLinkBook: json['selfLink'] ?? '',
      title: volumeInfo['title'] ?? '',
      authors: volumeInfo['authors'] != null
          ? List<String>.from(volumeInfo['authors'])
          : [],
      publisher: volumeInfo['publisher'] ?? '',
      publishedDate: volumeInfo['publishedDate'] ?? '',
      description: volumeInfo['description'] ?? '',
      readingModesText: readingModes['text'] ?? false,
      readingModesImage: readingModes['image'] ?? false,
      pageCount: volumeInfo['pageCount'] ?? 0,
      printType: volumeInfo['printType'] ?? '',
      categories: volumeInfo['categories'] != null
          ? List<String>.from(volumeInfo['categories'])
          : [],
      maturityRating: volumeInfo['maturityRating'] ?? '',
      allowAnonLogging: volumeInfo['allowAnonLogging'] ?? false,
      contentVersion: volumeInfo['contentVersion'] ?? '',
      panelizationContainsEpubBubbles:
          panelizationSummary['containsEpubBubbles'] ?? false,
      panelizationContainsImageBubbles:
          panelizationSummary['containsImageBubbles'] ?? false,
      imageLinksSmallThumbnail: imageLinks['smallThumbnail'] ?? '',
      imageLinksThumbnail: imageLinks['thumbnail'] ?? '',
      language: volumeInfo['language'] ?? '',
      previewLink: volumeInfo['previewLink'] ?? '',
      infoLink: volumeInfo['infoLink'] ?? '',
      canonicalVolumeLink: volumeInfo['canonicalVolumeLink'] ?? '',
      saleInfoCountry: saleInfo['country'] ?? '',
      saleInfoSaleability: saleInfo['saleability'] ?? '',
      saleInfoIsEbook: saleInfo['isEbook'] ?? false,
      accessInfoCountry: accessInfo['country'] ?? '',
      accessInfoViewability: accessInfo['viewability'] ?? '',
      accessInfoEmbeddable: accessInfo['embeddable'] ?? false,
      accessInfoPublicDomain: accessInfo['publicDomain'] ?? false,
      accessInfoTextToSpeechPermission:
          accessInfo['textToSpeechPermission'] ?? '',
      accessInfoEpubIsAvailable: epub['isAvailable'] ?? false,
      accessInfoPdfIsAvailable: pdf['isAvailable'] ?? false,
      accessInfoPdfAcsTokenLink: pdf['acsTokenLink'] ?? '',
      accessInfoWebReaderLink: accessInfo['webReaderLink'] ?? '',
      accessInfoAccessViewStatus: accessInfo['accessViewStatus'] ?? '',
      accessInfoQuoteSharingAllowed: accessInfo['quoteSharingAllowed'] ?? false,
      searchInfoTextSnippet: json['searchInfo']?['textSnippet'] ?? '',
      averageRating: volumeInfo['averageRating'] ?? 0,
    );
  }
}
