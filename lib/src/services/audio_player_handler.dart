import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  static const _item = MediaItem(
    id: 'http://s3.streammonster.com:8225/stream',
    title: '',
  );
  final _player = AudioPlayer();
  final estacion = '96.7';
  String currentChannel = '';
  AudioPlayerHandler() {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);

    mediaItem.add(_item);

    // Load the player.
    _player.setAudioSource(AudioSource.uri(Uri.parse(_item.id)));

    _player.icyMetadataStream.listen((event) {
      if (event?.info?.title != currentChannel &&
          event?.info?.title != null &&
          event != null) {
        currentChannel = event.info?.title ?? '';
        setChannel(currentChannel);
      }
    });
  }

  AudioPlayer get player => _player;

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  Future<void> setChannel(String programTitle) async {
    final title = MediaItem(
      id: 'http://s3.streammonster.com:8225/stream',
      title: programTitle,
    );
    mediaItem.add(title);

    // Load the player.
    await _player.setAudioSource(AudioSource.uri(Uri.parse(title.id)));
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
