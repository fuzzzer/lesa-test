import 'package:flutter/material.dart';
import 'package:lesa/src/src.dart';
import 'package:ui_kit/ui_kit.dart';

// Use this wisely, when reusing same inherited preferences in the widget.
// for example: calling context.uiColors 10 times in a single widget, would trigger multiple Theme.of(context) lookups.
// for heavy widgets try to save the references like:
// final uiColors = context.uiColors;
// final uiTextStyles = context.uiTextStyles;
// final uiFormStyles = context.uiTextStyles;
// etc ...
extension BuildContextExtension on BuildContext {
  /// When using multiple times in same widget optimize lookup with:
  /// final lesaLocalizations = context.lesaLocalizations;
  LesaLocalizations get lesaLocalizations => LesaLocalizations.of(this)!;

  /// When using multiple times in same widget optimize lookup with:
  /// final uiColors = context.uiColors;
  UiColors get uiColors => Theme.of(this).extension<UiColors>()!;

  /// When using multiple times in same widget optimize lookup with:
  /// final uiTextStyles = context.uiTextStyles;
  UiTextStyles get uiTextStyles => Theme.of(this).extension<UiTextStyles>()!;

  /// When using multiple times in same widget optimize lookup with:
  /// final uiFormStyles = context.uiFormStyles;
  UiFormStyles get uiFormStyles => Theme.of(this).extension<UiFormStyles>()!;
}
