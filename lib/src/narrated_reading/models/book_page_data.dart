import 'package:flutter/foundation.dart';

@immutable
class BookPageData {
  final String text;
  final String audioFilePath;

  const BookPageData({
    required this.text,
    required this.audioFilePath,
  });

  @override
  bool operator ==(covariant BookPageData other) {
    if (identical(this, other)) return true;

    return other.text == text && other.audioFilePath == audioFilePath;
  }

  @override
  int get hashCode => text.hashCode ^ audioFilePath.hashCode;
}
