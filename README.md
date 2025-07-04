# Lesa

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

\_\*Lesa works on iOS, Android

## Working with Translations 🌐

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/core/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "continue": "Continue",
    "@continue": {
        "description": "default continue text prompting user to continue some process"
    }
}
```

after adding new in the default template arb file, you can add translations in other localization files as well.

### Generating Translations

To use the latest translations arb file changes, you will need to generate them.
Generate localizations for the current project with:

```sh
flutter gen-l10n
```

### Using Localizations

```dart
import 'package:lesa/src/src.dart';

@override
Widget build(BuildContext context) {
  final localizations = context.lesaLocalizations;
  return Text(localizations.helloWorld);
}
```

[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
