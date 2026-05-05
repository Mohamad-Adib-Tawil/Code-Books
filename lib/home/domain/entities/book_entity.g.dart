// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookEntityAdapter extends TypeAdapter<BookEntity> {
  @override
  final int typeId = 0;

  @override
  BookEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookEntity(
      kindBook: fields[0] as String,
      idBook: fields[1] as String,
      etagBook: fields[2] as String,
      selfLinkBook: fields[3] as String,
      title: fields[4] as String,
      authors: (fields[5] as List).cast<String>(),
      publisher: fields[6] as String,
      publishedDate: fields[7] as String,
      description: fields[8] as String,
      readingModesText: fields[10] as bool,
      readingModesImage: fields[11] as bool,
      pageCount: fields[12] as int,
      printType: fields[13] as String,
      categories: (fields[14] as List).cast<String>(),
      maturityRating: fields[15] as String,
      allowAnonLogging: fields[16] as bool,
      contentVersion: fields[17] as String,
      panelizationContainsEpubBubbles: fields[18] as bool,
      panelizationContainsImageBubbles: fields[19] as bool,
      imageLinksSmallThumbnail: fields[20] as String,
      imageLinksThumbnail: fields[21] as String,
      language: fields[22] as String,
      previewLink: fields[23] as String,
      infoLink: fields[24] as String,
      canonicalVolumeLink: fields[25] as String,
      saleInfoCountry: fields[26] as String,
      saleInfoSaleability: fields[27] as String,
      saleInfoIsEbook: fields[28] as bool,
      accessInfoCountry: fields[29] as String,
      accessInfoViewability: fields[30] as String,
      accessInfoEmbeddable: fields[31] as bool,
      accessInfoPublicDomain: fields[32] as bool,
      accessInfoTextToSpeechPermission: fields[33] as String,
      accessInfoEpubIsAvailable: fields[34] as bool,
      accessInfoPdfIsAvailable: fields[35] as bool,
      accessInfoPdfAcsTokenLink: fields[36] as String,
      accessInfoWebReaderLink: fields[37] as String,
      accessInfoAccessViewStatus: fields[38] as String,
      accessInfoQuoteSharingAllowed: fields[39] as bool,
      searchInfoTextSnippet: fields[9] as String,
      averageRating: fields[40] as num,
    );
  }

  @override
  void write(BinaryWriter writer, BookEntity obj) {
    writer
      ..writeByte(41)
      ..writeByte(0)
      ..write(obj.kindBook)
      ..writeByte(1)
      ..write(obj.idBook)
      ..writeByte(2)
      ..write(obj.etagBook)
      ..writeByte(3)
      ..write(obj.selfLinkBook)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.authors)
      ..writeByte(6)
      ..write(obj.publisher)
      ..writeByte(7)
      ..write(obj.publishedDate)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.searchInfoTextSnippet)
      ..writeByte(10)
      ..write(obj.readingModesText)
      ..writeByte(11)
      ..write(obj.readingModesImage)
      ..writeByte(12)
      ..write(obj.pageCount)
      ..writeByte(13)
      ..write(obj.printType)
      ..writeByte(14)
      ..write(obj.categories)
      ..writeByte(15)
      ..write(obj.maturityRating)
      ..writeByte(16)
      ..write(obj.allowAnonLogging)
      ..writeByte(17)
      ..write(obj.contentVersion)
      ..writeByte(18)
      ..write(obj.panelizationContainsEpubBubbles)
      ..writeByte(19)
      ..write(obj.panelizationContainsImageBubbles)
      ..writeByte(20)
      ..write(obj.imageLinksSmallThumbnail)
      ..writeByte(21)
      ..write(obj.imageLinksThumbnail)
      ..writeByte(22)
      ..write(obj.language)
      ..writeByte(23)
      ..write(obj.previewLink)
      ..writeByte(24)
      ..write(obj.infoLink)
      ..writeByte(25)
      ..write(obj.canonicalVolumeLink)
      ..writeByte(26)
      ..write(obj.saleInfoCountry)
      ..writeByte(27)
      ..write(obj.saleInfoSaleability)
      ..writeByte(28)
      ..write(obj.saleInfoIsEbook)
      ..writeByte(29)
      ..write(obj.accessInfoCountry)
      ..writeByte(30)
      ..write(obj.accessInfoViewability)
      ..writeByte(31)
      ..write(obj.accessInfoEmbeddable)
      ..writeByte(32)
      ..write(obj.accessInfoPublicDomain)
      ..writeByte(33)
      ..write(obj.accessInfoTextToSpeechPermission)
      ..writeByte(34)
      ..write(obj.accessInfoEpubIsAvailable)
      ..writeByte(35)
      ..write(obj.accessInfoPdfIsAvailable)
      ..writeByte(36)
      ..write(obj.accessInfoPdfAcsTokenLink)
      ..writeByte(37)
      ..write(obj.accessInfoWebReaderLink)
      ..writeByte(38)
      ..write(obj.accessInfoAccessViewStatus)
      ..writeByte(39)
      ..write(obj.accessInfoQuoteSharingAllowed)
      ..writeByte(40)
      ..write(obj.averageRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
