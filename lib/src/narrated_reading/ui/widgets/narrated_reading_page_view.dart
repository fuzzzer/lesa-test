import 'package:flutter/material.dart';
import 'package:lesa/src/src.dart';

class NarratedReadingPageView extends StatelessWidget {
  const NarratedReadingPageView({
    super.key,
    required this.controller,
    required this.pages,
    required this.onPageChanged,
  });

  final PageController controller;
  final List<BookPageData> pages;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: pages.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            pages[index].text,
            textAlign: TextAlign.center,
            style: context.uiTextStyles.max48,
          ),
        ),
      ),
    );
  }
}
