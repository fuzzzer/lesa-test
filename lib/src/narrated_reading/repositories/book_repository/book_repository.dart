import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lesa/src/src.dart';

export 'book_repository_responses/book_repository_responses.dart';

class BookRepository {
  BookRepository();

  Future<GetBookDataResponse> getData({
    required String languageCode,
  }) async {
    final bookResorcesBasePath = 'assets/books/$languageCode';

    try {
      final rawBookJson = await rootBundle.loadString('$bookResorcesBasePath/book.json');
      final rawBookMap = jsonDecode(rawBookJson) as Map<String, dynamic>;

      final book = _parseRawBookData(
        map: rawBookMap,
        bookResorcesBasePath: bookResorcesBasePath,
      );

      return GetBookDataSuccess(bookData: book);
    } catch (_) {
      return GetBookDataFailure(failureType: GetBookDataFailureType.unknown);
    }
  }

  BookData _parseRawBookData({
    required Map<String, dynamic> map,
    required String bookResorcesBasePath,
  }) {
    final rawPages = map['pages'] as List<dynamic>? ?? [];

    final List<BookPageData> pages = _parsePages(
      rawPages: rawPages,
      bookResorcesBasePath: bookResorcesBasePath,
    );

    return BookData(
      title: (map['title'] as String?) ?? '',
      pages: pages,
    );
  }

  static List<BookPageData> _parsePages({
    required List<dynamic> rawPages,
    required String bookResorcesBasePath,
  }) {
    if (rawPages.isNotEmpty && rawPages.first is String) {
      //NOTE Parser For Legacy Structure:
      // {
      //   "title": "Adventure in the Forest",
      //   "pages": [
      //     "The fox.",
      //     "The fox found a stone",
      //     "The fox began a journey"
      //   ]
      // }

      return List<BookPageData>.generate(rawPages.length, (i) {
        return BookPageData(
          text: rawPages[i] as String,
          audioFilePath: '$bookResorcesBasePath/audio/page_${i + 1}.mp3',
        );
      });
    } else {
      //NOTE Parser For Updated Structure (Since this is more maintanable if we'll have audio by pages):
      // {
      //   "title": "Adventure in the Forest",
      //   "pages": [
      //     { "text": "The fox.",                 "audio": "assets/audio/page_1.mp3" },
      //     { "text": "The fox found a stone",    "audio": "assets/audio/page_2.mp3" },
      //     { "text": "The fox began a journey",  "audio": "assets/audio/page_3.mp3" }
      //   ]
      // }

      return rawPages
          .map(
            (rawBookPageMap) => BookPageData(
              text: (rawBookPageMap['text'] as String?) ?? '',
              audioFilePath: (rawBookPageMap['audio'] as String?) ?? '',
            ),
          )
          .toList();
    }
  }
}
