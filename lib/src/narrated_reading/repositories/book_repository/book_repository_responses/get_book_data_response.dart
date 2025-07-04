import 'package:lesa/src/src.dart';

sealed class GetBookDataResponse {}

class GetBookDataSuccess extends GetBookDataResponse {
  final BookData bookData;

  GetBookDataSuccess({
    required this.bookData,
  });
}

class GetBookDataFailure extends GetBookDataResponse {
  final GetBookDataFailureType? failureType;

  GetBookDataFailure({
    this.failureType,
  });
}

enum GetBookDataFailureType {
  corruptedBookFiles,
  unknown;

  bool get isCorruptedBookFiles => this == corruptedBookFiles;
  bool get isUnknown => this == unknown;

  String toDisplayString(LesaLocalizations localizations) {
    return switch (this) {
      corruptedBookFiles => localizations.corruptedBookFiles,
      unknown => localizations.unexpectedError,
    };
  }
}
