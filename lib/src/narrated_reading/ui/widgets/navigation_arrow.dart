import 'package:flutter/material.dart';
import 'package:lesa/src/src.dart';

class NavigationArrow extends StatelessWidget {
  const NavigationArrow({
    super.key,
    required this.direction,
    required this.onTap,
    this.dimension = 80,
  });

  final AxisDirection direction;
  final VoidCallback onTap;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    final localizations = context.lesaLocalizations;

    final isRight = direction == AxisDirection.right;

    return Opacity(
      opacity: 0.9,
      child: SizedBox.square(
        dimension: 90,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  isRight ? Icons.arrow_forward : Icons.arrow_back,
                ),
                iconSize: 48,
                onPressed: onTap,
                color: context.uiColors.primaryColor,
              ),
              Text(
                isRight ? localizations.nextPage : localizations.previousPage,
                style: context.uiTextStyles.bodySmall12,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
