// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lesa_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class LesaLocalizationsIs extends LesaLocalizations {
  LesaLocalizationsIs([String locale = 'is']) : super(locale);

  @override
  String get corruptedBookFiles => 'Spilltar bókaskrár';

  @override
  String get unexpectedError => 'Óvænt villa';

  @override
  String pageOf(Object currentPageIndex, Object totalPagesCount) {
    return 'Bls. $currentPageIndex af $totalPagesCount';
  }

  @override
  String get previousPage => 'Fyrri síða';

  @override
  String get nextPage => 'Næsta síða';
}
