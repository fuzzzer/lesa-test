import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesa/src/src.dart';
import 'package:ui_kit/ui_kit.dart';

class NarratedReadingFlowContent extends StatefulWidget {
  const NarratedReadingFlowContent({
    super.key,
    required this.bookData,
  });

  final BookData bookData;

  @override
  State<NarratedReadingFlowContent> createState() => NarratedReadingFlowContentState();
}

class NarratedReadingFlowContentState extends State<NarratedReadingFlowContent> {
  static const startingPageIndex = 0;
  static const animationDuration = Duration(milliseconds: 250);
  static const animationCurve = Curves.easeOut;

  final PageController _pageController = PageController();
  int _currentPageIndex = startingPageIndex;

  BookCubit get _book => context.read<BookCubit>();
  AudioControllerCubit get _audio => context.read<AudioControllerCubit>();

  @override
  void initState() {
    super.initState();

    _setAudioForCurrentPage(_currentPageIndex);
  }

  @override
  void didUpdateWidget(covariant NarratedReadingFlowContent oldWidget) {
    if (oldWidget.bookData != widget.bookData) {
      _pageController.animateToPage(
        startingPageIndex,
        duration: animationDuration,
        curve: animationCurve,
      );

      _onPageChanged(startingPageIndex);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPageIndex = index);
    _setAudioForCurrentPage(index);
  }

  void _setAudioForCurrentPage(
    int index, {
    bool startPlaying = false,
  }) {
    final audioPath = _book.getAudioPathForPage(index);
    if (audioPath != null) {
      _audio.setAudioSource(
        audioPath: audioPath,
        startPlaying: startPlaying,
      );
    }
  }

  void _onPageActionTapped() {
    final localizationCubit = context.read<LocalizationCubit>();
    if (localizationCubit.state.locale.languageCode == englishLanguageCode) {
      context.read<LocalizationCubit>().changeLocale(
            const Locale(islandicLanguageCode),
          );
    } else {
      context.read<LocalizationCubit>().changeLocale(
            const Locale(englishLanguageCode),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookData = widget.bookData;
    final totalPagesLength = bookData.pages.length;

    return PrimaryScaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: NarratedReadingPageView(
              controller: _pageController,
              pages: bookData.pages,
              onPageChanged: _onPageChanged,
            ),
          ),
          if (_currentPageIndex > 0)
            Positioned(
              bottom: 300,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: NavigationArrow(
                  key: const Key('left'),
                  direction: AxisDirection.left,
                  onTap: () => _pageController.previousPage(
                    duration: animationDuration,
                    curve: animationCurve,
                  ),
                ),
              ),
            ),
          if (_currentPageIndex < totalPagesLength - 1)
            Positioned(
              right: 0,
              bottom: 300,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: NavigationArrow(
                  key: const Key('right'),
                  direction: AxisDirection.right,
                  onTap: () => _pageController.nextPage(
                    duration: animationDuration,
                    curve: animationCurve,
                  ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: NarratedReadingActionBox(
                      onTap: _onPageActionTapped,
                    ),
                  ),
                ),
                PageProgressIndicator(
                  currentPageIndex: _currentPageIndex,
                  totalPagesLength: totalPagesLength,
                ),
                AudioControlBar(
                  bookTitle: bookData.title,
                  currentPageIndex: _currentPageIndex,
                  totalPagesLength: totalPagesLength,
                  onReplayCurrent: () => _setAudioForCurrentPage(
                    _currentPageIndex,
                    startPlaying: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
