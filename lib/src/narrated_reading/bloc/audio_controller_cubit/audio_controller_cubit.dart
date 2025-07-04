import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:lesa/src/core/core.dart';
import 'package:meta/meta.dart';
import 'components/components.dart';

export 'components/components.dart';

part 'audio_controller_state.dart';

class AudioControllerCubit extends Cubit<AudioControllerState> {
  AudioControllerCubit() : super(const AudioControllerState(status: AudioStatus.initial));

  final AudioPlayer player = AudioPlayer();

  StreamSubscription<dynamic>? positionSubscription;
  StreamSubscription<void>? completionSubscription;

  bool get isPlaying => player.state == PlayerState.playing;

  Future<void> setAudioSource({
    required String audioPath,
    required bool startPlaying,
  }) async {
    emit(const AudioControllerState(status: AudioStatus.loading));

    await release();

    try {
      await player.setSource(
        AssetSource(
          audioPath.replaceFirst('assets/', ''),
        ),
      );

      final totalDuration = await player.getDuration();

      emit(AudioControllerState(status: AudioStatus.paused, totalDuration: totalDuration));

      positionSubscription = player.onPositionChanged.listen((Duration position) {
        emit(state.copyWith(currentPosition: position));
      });

      completionSubscription = player.onPlayerComplete.listen((_) {
        emit(state.copyWith(status: AudioStatus.completed));
      });
    } catch (ex) {
      _emitFailureState(ex);
    }

    if (startPlaying) {
      await resume();
    }
  }

  Future<void> resume() async {
    emit(state.copyWith(status: AudioStatus.loading));

    try {
      await player.resume();

      emit(
        state.copyWith(
          status: AudioStatus.playing,
        ),
      );

      positionSubscription?.resume();
    } catch (ex) {
      _emitFailureState(ex);
    }
  }

  Future<void> pause() async {
    emit(state.copyWith(status: AudioStatus.loading));

    try {
      await player.pause();

      emit(
        state.copyWith(
          status: AudioStatus.paused,
        ),
      );

      positionSubscription?.pause();
    } catch (ex) {
      _emitFailureState(ex);
    }
  }

  Future<void> stop() async {
    emit(state.copyWith(status: AudioStatus.loading));

    try {
      await player.stop();

      emit(
        state.copyWith(
          status: AudioStatus.completed,
        ),
      );

      await positionSubscription?.cancel();
    } catch (ex) {
      _emitFailureState(ex);
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await player.seek(position);
      emit(
        state.copyWith(
          currentPosition: position,
        ),
      );
    } catch (ex) {
      _emitFailureState(ex);
    }
  }

  Future<void> setVolume(double volume) async {
    await player.setVolume(volume);
  }

  Future<void> setPlaybackSpeed(double rate) async {
    if (player.state == PlayerState.playing) {
      await player.setPlaybackRate(rate);
    }
  }

  Future<Duration?> position() async {
    return await player.getCurrentPosition();
  }

  Future<Duration?> duration() async {
    return await player.getDuration();
  }

  Future<void> release() async {
    await player.release();
    await positionSubscription?.cancel();
    await completionSubscription?.cancel();
  }

  @override
  Future<void> close() {
    release();
    return super.close();
  }

  void _emitFailureState(Object ex) {
    emit(state.copyWith(status: AudioStatus.failure, failure: DefaultFailure(message: ex.toString())));
  }
}
