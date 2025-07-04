part of 'audio_controller_cubit.dart';

@immutable
class AudioControllerState {
  final AudioStatus status;
  final Duration? totalDuration;
  final Duration currentPosition;
  final DefaultFailure? failure;

  bool get hasBeenLoaded => totalDuration != null;

  const AudioControllerState({
    required this.status,
    this.totalDuration,
    this.currentPosition = Duration.zero,
    this.failure,
  });

  AudioControllerState copyWith({
    AudioStatus? status,
    Duration? totalDuration,
    Duration? currentPosition,
    DefaultFailure? failure,
  }) {
    return AudioControllerState(
      status: status ?? this.status,
      totalDuration: totalDuration ?? this.totalDuration,
      currentPosition: currentPosition ?? this.currentPosition,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() {
    return 'AudioControllerState(status: $status, totalDuration: $totalDuration, currentPosition: $currentPosition, failure: $failure)';
  }
}
