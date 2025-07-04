import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesa/src/src.dart';

class AudioControlBar extends StatelessWidget {
  const AudioControlBar({
    super.key,
    required this.bookTitle,
    required this.currentPageIndex,
    required this.totalPagesLength,
    required this.onReplayCurrent,
  });

  final String bookTitle;
  final int currentPageIndex;
  final int totalPagesLength;
  final VoidCallback onReplayCurrent;

  String _formatDuration(Duration duration) => '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
      '${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final audioCubit = context.read<AudioControllerCubit>();

    final uiColors = context.uiColors;
    final uiTextStyles = context.uiTextStyles;

    return BlocBuilder<AudioControllerCubit, AudioControllerState>(
      builder: (context, audio) {
        final isPlaying = audio.status.isPlaying;
        final isCompleted = audio.status.isCompleted;

        return Container(
          color: uiColors.backgroundPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              SizedBox.square(
                dimension: 70,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  iconSize: 42,
                  color: context.uiColors.secondaryColor,
                  onPressed: () {
                    if (isPlaying) {
                      audioCubit.pause();
                    } else if (isCompleted) {
                      onReplayCurrent();
                    } else {
                      audioCubit.resume();
                    }
                  },
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        bookTitle,
                        style: uiTextStyles.bodyBold16,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isPlaying ? _formatDuration(audio.currentPosition) : '00:00',
                              style: uiTextStyles.bodySmallBold12.copyWith(
                                color: uiColors.secondaryTextColor,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              context.lesaLocalizations.pageOf(currentPageIndex + 1, totalPagesLength),
                              style: uiTextStyles.bodySmallBold12.copyWith(
                                color: uiColors.secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox.square(
                dimension: 70,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                  ),
                  iconSize: 36,
                  color: context.uiColors.secondaryColor,
                  onPressed: audioCubit.stop,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
