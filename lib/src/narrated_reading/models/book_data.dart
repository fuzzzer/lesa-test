import 'package:flutter/foundation.dart';

import 'book_page_data.dart';

@immutable
class BookData {
  final String title;
  final List<BookPageData> pages;

  const BookData({
    required this.title,
    required this.pages,
  });

  @override
  bool operator ==(covariant BookData other) {
    if (identical(this, other)) return true;

    return other.title == title && listEquals(other.pages, pages);
  }

  @override
  int get hashCode => title.hashCode ^ pages.hashCode;
}
