import 'dart:ui';
import 'package:flutter/material.dart';

class UiFormStyles extends ThemeExtension<UiFormStyles> {
  final double screenContentPrimaryHorizontalGap;
  final double screenContentPrimaryVerticalGap;

  const UiFormStyles({
    required this.screenContentPrimaryHorizontalGap,
    required this.screenContentPrimaryVerticalGap,
  });

  const UiFormStyles.original()
      : screenContentPrimaryHorizontalGap = 16,
        screenContentPrimaryVerticalGap = 16;

  const UiFormStyles.offGiga()
      : screenContentPrimaryHorizontalGap = 0.0,
        screenContentPrimaryVerticalGap = 20.0;

  @override
  UiFormStyles copyWith({
    double? screenContentPrimaryHorizontalGap,
    double? screenContentPrimaryVerticalGap,
  }) {
    return UiFormStyles(
      screenContentPrimaryHorizontalGap: screenContentPrimaryHorizontalGap ?? this.screenContentPrimaryHorizontalGap,
      screenContentPrimaryVerticalGap: screenContentPrimaryVerticalGap ?? this.screenContentPrimaryVerticalGap,
    );
  }

  @override
  UiFormStyles lerp(ThemeExtension<UiFormStyles>? other, double t) {
    if (other is! UiFormStyles) return this;
    return UiFormStyles(
      screenContentPrimaryHorizontalGap:
          lerpDouble(screenContentPrimaryHorizontalGap, other.screenContentPrimaryHorizontalGap, t) ??
              screenContentPrimaryHorizontalGap,
      screenContentPrimaryVerticalGap:
          lerpDouble(screenContentPrimaryVerticalGap, other.screenContentPrimaryVerticalGap, t)!,
    );
  }
}
