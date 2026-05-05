import 'package:code_books/home/domain/entities/book_entity.dart';

import 'access_info.dart';
import 'sale_info.dart';
import 'search_info.dart';
import 'volume_info.dart';

class BookModel extends BookEntity {
  String? kind;
  String? id;
  String? etag;
  String? selfLink;
  VolumeInfo? volumeInfo;
  SaleInfo? saleInfo;
  AccessInfo? accessInfo;
  SearchInfo? searchInfo;

  BookModel({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  }) : super(
         kindBook: kind ?? '',
         idBook: id ?? '',
         etagBook: etag ?? '',
         selfLinkBook: selfLink ?? '',
         title: volumeInfo?.title ?? '',
         authors: volumeInfo?.authors ?? ['No Name'],
         publisher: volumeInfo?.publisher ?? '',
         publishedDate: volumeInfo?.publishedDate ?? '',
         description: volumeInfo?.description ?? '',
         readingModesText: volumeInfo?.readingModes?.text ?? false,
         readingModesImage: volumeInfo?.readingModes?.image ?? false,
         pageCount: volumeInfo?.pageCount ?? 0,
         printType: volumeInfo?.printType ?? '',
         categories: volumeInfo?.categories ?? [],
         maturityRating: volumeInfo?.maturityRating ?? '',
         allowAnonLogging: volumeInfo?.allowAnonLogging ?? false,
         contentVersion: volumeInfo?.contentVersion ?? '',
         panelizationContainsEpubBubbles:
             volumeInfo?.panelizationSummary?.containsEpubBubbles ?? false,
         panelizationContainsImageBubbles:
             volumeInfo?.panelizationSummary?.containsImageBubbles ?? false,
         imageLinksSmallThumbnail: volumeInfo?.imageLinks?.smallThumbnail ?? '',
         imageLinksThumbnail: volumeInfo?.imageLinks?.thumbnail ?? '',
         language: volumeInfo?.language ?? '',
         previewLink: volumeInfo?.previewLink ?? '',
         infoLink: volumeInfo?.infoLink ?? '',
         canonicalVolumeLink: volumeInfo?.canonicalVolumeLink ?? '',
         saleInfoCountry: saleInfo?.country ?? '',
         saleInfoSaleability: saleInfo?.saleability ?? '',
         saleInfoIsEbook: saleInfo?.isEbook ?? false,
         accessInfoCountry: accessInfo?.country ?? '',
         accessInfoViewability: accessInfo?.viewability ?? '',
         accessInfoEmbeddable: accessInfo?.embeddable ?? false,
         accessInfoPublicDomain: accessInfo?.publicDomain ?? false,
         accessInfoTextToSpeechPermission:
             accessInfo?.textToSpeechPermission ?? '',
         accessInfoEpubIsAvailable: accessInfo?.epub?.isAvailable ?? false,
         accessInfoPdfIsAvailable: accessInfo?.pdf?.isAvailable ?? false,
         accessInfoPdfAcsTokenLink: accessInfo?.pdf?.acsTokenLink ?? '',
         accessInfoWebReaderLink: accessInfo?.webReaderLink ?? '',
         accessInfoAccessViewStatus: accessInfo?.accessViewStatus ?? '',
         accessInfoQuoteSharingAllowed:
             accessInfo?.quoteSharingAllowed ?? false,
         searchInfoTextSnippet: searchInfo?.textSnippet ?? '',
         averageRating: volumeInfo?.averageRating ?? 3,
       );

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    kind: json['kind'] as String?,
    id: json['id'] as String?,
    etag: json['etag'] as String?,
    selfLink: json['selfLink'] as String?,
    volumeInfo: json['volumeInfo'] == null
        ? null
        : VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
    saleInfo: json['saleInfo'] == null
        ? null
        : SaleInfo.fromJson(json['saleInfo'] as Map<String, dynamic>),
    accessInfo: json['accessInfo'] == null
        ? null
        : AccessInfo.fromJson(json['accessInfo'] as Map<String, dynamic>),
    searchInfo: json['searchInfo'] == null
        ? null
        : SearchInfo.fromJson(json['searchInfo'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'id': id,
    'etag': etag,
    'selfLink': selfLink,
    'volumeInfo': volumeInfo?.toJson(),
    'saleInfo': saleInfo?.toJson(),
    'accessInfo': accessInfo?.toJson(),
    'searchInfo': searchInfo?.toJson(),
  };
}
