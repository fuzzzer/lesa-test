// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lesa_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LesaLocalizationsEn extends LesaLocalizations {
  LesaLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get corruptedBookFiles => 'Corrupted book files';

  @override
  String get unexpectedError => 'Unexpected error';

  @override
  String pageOf(Object currentPageIndex, Object totalPagesCount) {
    return 'Page $currentPageIndex of $totalPagesCount';
  }

  @override
  String get previousPage => 'Previous page';

  @override
  String get nextPage => 'Next page';
}
