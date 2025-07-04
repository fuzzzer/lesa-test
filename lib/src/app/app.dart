import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lesa/src/src.dart';
import 'package:ui_kit/ui_kit.dart';

export 'bloc/bloc.dart';
export 'components/components.dart';
export 'globals/globals.dart';
export 'navigation/navigation.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> materialAppNavigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({super.key});

  static Future<Widget> runner() async {
    await Initializer.preAppInit();

    return const App();
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter router;

  @override
  void initState() {
    super.initState();

    router = LesaRouter.create();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalBlocProviders(
      child: ThemeStateBuilder(
        builder: (brightness) {
          return LocalizationStateBuilder(
            builder: (locale) {
              return MaterialApp.router(
                routerConfig: router,
                scaffoldMessengerKey: scaffoldMessengerKey,
                theme: switch (brightness) {
                  Brightness.dark => UiKitTheme.dark(),
                  Brightness.light => UiKitTheme.light(),
                },
                locale: locale,
                localizationsDelegates: LesaLocalizations.localizationsDelegates,
                supportedLocales: LesaLocalizations.supportedLocales,
              );
            },
          );
        },
      ),
    );
  }
}
