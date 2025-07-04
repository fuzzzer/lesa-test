import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesa/src/src.dart';
import 'package:ui_kit/ui_kit.dart';

export 'widgets/widgets.dart';

class NarratedReadingFlowPage extends StatelessWidget {
  const NarratedReadingFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LocalizationStateBuilder(
      builder: (locale) {
        return MultiBlocProvider(
          key: Key(locale.languageCode),
          providers: [
            BlocProvider(
              create: (_) => BookCubit(
                bookRepository: BookRepository(),
              )..getData(
                  languageCode: context.lesaLocalizations.localeName,
                ),
            ),
            BlocProvider(
              create: (_) => AudioControllerCubit(),
            ),
          ],
          child: const _ProvidedNarratedReadingFlowPage(),
        );
      },
    );
  }
}

class _ProvidedNarratedReadingFlowPage extends StatelessWidget {
  const _ProvidedNarratedReadingFlowPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, state) {
        if (state.bookData != null) {
          return NarratedReadingFlowContent(
            bookData: state.bookData!,
          );
        }

        return StatusBuilder.buildByStatus(
          status: state.status,
          onInitial: PrimaryLoadingPageView.new,
          onLoading: PrimaryLoadingPageView.new,
          onSuccess: SizedBox.shrink,
          onFailure: () => PrimaryErrorPageView(
            message: state.failureType.toString(),
          ),
        );
      },
    );
  }
}
