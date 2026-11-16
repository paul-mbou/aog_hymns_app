import 'package:aog_hymns_app/app/settings/viewmodel/settings_view_model.dart';
import 'package:aog_hymns_app/core/data/catalog_failure.dart';
import 'package:aog_hymns_app/core/data/providers.dart';
import 'package:aog_hymns_app/core/model/lyric.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hymn_detail_view_model.g.dart';

class HymnDetailState {
  const HymnDetailState({
    required this.lyric,
    this.playing = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.downloadingAudio = false,
    this.downloadingScore = false,
    this.audioPath,
    this.scorePath,
    this.mediaError,
  });

  final Lyric lyric;
  final bool playing;
  final Duration position;
  final Duration duration;
  final bool downloadingAudio;
  final bool downloadingScore;
  final String? audioPath;
  final String? scorePath;
  final MediaFailure? mediaError;

  HymnDetailState copyWith({
    Lyric? lyric,
    bool? playing,
    Duration? position,
    Duration? duration,
    bool? downloadingAudio,
    bool? downloadingScore,
    String? audioPath,
    String? scorePath,
    MediaFailure? mediaError,
    bool clearError = false,
  }) {
    return HymnDetailState(
      lyric: lyric ?? this.lyric,
      playing: playing ?? this.playing,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      downloadingAudio: downloadingAudio ?? this.downloadingAudio,
      downloadingScore: downloadingScore ?? this.downloadingScore,
      audioPath: audioPath ?? this.audioPath,
      scorePath: scorePath ?? this.scorePath,
      mediaError: clearError ? null : mediaError ?? this.mediaError,
    );
  }
}

@riverpod
class HymnDetailViewModel extends _$HymnDetailViewModel {
  final AudioPlayer _player = AudioPlayer();
  final CancelToken _cancelToken = CancelToken();
  var _wired = false;

  @override
  Future<HymnDetailState> build(String id) async {
    if (!_wired) {
      _wired = true;
      ref.onDispose(() async {
        _cancelToken.cancel();
        await _player.stop();
        await _player.dispose();
      });
      _player.onPositionChanged.listen((position) {
        final current = state.asData?.value;
        if (current == null || !ref.mounted) return;
        state = AsyncData(current.copyWith(position: position));
      });
      _player.onDurationChanged.listen((duration) {
        final current = state.asData?.value;
        if (current == null || !ref.mounted) return;
        state = AsyncData(current.copyWith(duration: duration));
      });
      _player.onPlayerStateChanged.listen((playerState) {
        final current = state.asData?.value;
        if (current == null || !ref.mounted) return;
        state = AsyncData(
          current.copyWith(playing: playerState == PlayerState.playing),
        );
      });
    }

    final french = ref.watch(settingsViewModelProvider.select((s) => s.french()));
    final load = await ref.watch(lyricRepositoryProvider).load(french: french);
    final lyric = load.lyrics.cast<Lyric?>().firstWhere(
      (item) => item!.id == id,
      orElse: () => null,
    );
    if (lyric == null) throw StateError('missing');
    final media = ref.watch(mediaRepositoryProvider);
    final audioPath = await media.existingFile(
      number: lyric.songNumber,
      language: lyric.contentLanguage,
      kind: 'audio',
    );
    final scorePath = await media.existingFile(
      number: lyric.songNumber,
      language: lyric.contentLanguage,
      kind: 'score',
    );
    if (!ref.mounted) throw StateError('disposed');
    return HymnDetailState(lyric: lyric, audioPath: audioPath, scorePath: scorePath);
  }

  Future<void> togglePlayback() async {
    final current = state.asData?.value;
    if (current == null) return;
    if (current.playing) {
      await _player.pause();
      return;
    }
    final path = await _ensureAudio();
    if (!ref.mounted || path == null) return;
    await _player.play(DeviceFileSource(path));
  }

  Future<void> seek(Duration position) => _player.seek(position);

  Future<String?> ensureScore() => _ensureScore();

  Future<String?> _ensureAudio() async {
    final current = state.asData?.value;
    if (current == null) return null;
    if (current.audioPath != null) return current.audioPath;
    state = AsyncData(current.copyWith(downloadingAudio: true, clearError: true));
    try {
      final path = await ref.read(mediaRepositoryProvider).download(
        url: current.lyric.audioUrl,
        number: current.lyric.songNumber,
        language: current.lyric.contentLanguage,
        kind: 'audio',
        cancelToken: _cancelToken,
      );
      if (!ref.mounted) return null;
      final latest = state.asData?.value ?? current;
      state = AsyncData(latest.copyWith(audioPath: path, downloadingAudio: false));
      return path;
    } on MediaException catch (error) {
      if (!ref.mounted || error.failure == MediaFailure.cancelled) return null;
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(downloadingAudio: false, mediaError: error.failure),
      );
      return null;
    }
  }

  Future<String?> _ensureScore() async {
    final current = state.asData?.value;
    if (current == null) return null;
    if (current.scorePath != null) return current.scorePath;
    state = AsyncData(current.copyWith(downloadingScore: true, clearError: true));
    try {
      final path = await ref.read(mediaRepositoryProvider).download(
        url: current.lyric.partitionUrl,
        number: current.lyric.songNumber,
        language: current.lyric.contentLanguage,
        kind: 'score',
        cancelToken: _cancelToken,
      );
      if (!ref.mounted) return null;
      final latest = state.asData?.value ?? current;
      state = AsyncData(latest.copyWith(scorePath: path, downloadingScore: false));
      return path;
    } on MediaException catch (error) {
      if (!ref.mounted || error.failure == MediaFailure.cancelled) return null;
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(downloadingScore: false, mediaError: error.failure),
      );
      return null;
    }
  }
}
