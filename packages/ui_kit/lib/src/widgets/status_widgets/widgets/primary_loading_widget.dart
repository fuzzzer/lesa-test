import 'package:flutter/material.dart';

class PrimaryLoadingWidget extends StatelessWidget {
  const PrimaryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox.square(
        dimension: 32,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
