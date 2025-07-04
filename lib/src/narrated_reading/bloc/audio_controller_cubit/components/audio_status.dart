enum AudioStatus {
  initial,
  loading,
  playing,
  paused,
  completed,
  failure;

  bool get isInitial => this == AudioStatus.initial;
  bool get isLoading => this == AudioStatus.loading;
  bool get isPlaying => this == AudioStatus.playing;
  bool get isPaused => this == AudioStatus.paused;
  bool get isCompleted => this == AudioStatus.completed;
  bool get isFailure => this == AudioStatus.failure;
}
