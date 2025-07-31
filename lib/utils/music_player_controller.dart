import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:miniplayer/miniplayer.dart';

class MusicPlayerController extends ChangeNotifier {
  final MiniplayerController miniplayerController = MiniplayerController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isPlaying = false;
  String _currentSong = '';
  String _currentImage = '';
  String _audioUrl = '';

  bool get isPlaying => _isPlaying;
  String get currentSong => _currentSong;
  String get currentImage => _currentImage;
  String get audioUrl => _audioUrl;
  AudioPlayer get audioPlayer => _audioPlayer;

  Future<void> play(String url) async {
    _audioUrl = url;
    try {
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await pause();
    } else {
      await play(_audioUrl);
    }
  }

  void setSong(String song, String image, String url) {
    _currentSong = song;
    _currentImage = image;
    _audioUrl = url;
    notifyListeners();
  }

  void stop() {
    _audioPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }
}
