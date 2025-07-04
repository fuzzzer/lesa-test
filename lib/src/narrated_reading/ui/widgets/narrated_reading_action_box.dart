import 'package:flutter/material.dart';

class NarratedReadingActionBox extends StatelessWidget {
  const NarratedReadingActionBox({
    super.key,
    this.dimension = 60,
    required this.onTap,
  });

  final double dimension;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);

    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: SizedBox.square(
        dimension: dimension,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Image.asset(
              'assets/images/action_box_image.png',
            ),
          ),
        ),
      ),
    );
  }
}
