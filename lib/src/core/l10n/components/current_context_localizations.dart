import 'package:lesa/src/src.dart';

LesaLocalizations get currentContextLocalization {
  if (materialAppNavigatorKey.currentContext == null) {
    return LesaLocalizationsEn();
  }

  return LesaLocalizations.of(materialAppNavigatorKey.currentContext!)!;
}
