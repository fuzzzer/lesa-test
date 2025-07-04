import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class PageProgressIndicator extends StatelessWidget {
  const PageProgressIndicator({
    super.key,
    required this.currentPageIndex,
    required this.totalPagesLength,
  });

  final int currentPageIndex;
  final int totalPagesLength;

  @override
  Widget build(BuildContext context) {
    final uiColors = Theme.of(context).extension<UiColors>()!;

    return LinearProgressIndicator(
      value: (currentPageIndex + 1) / totalPagesLength,
      minHeight: 2,
      backgroundColor: uiColors.backgroundSecondaryColor,
    );
  }
}
