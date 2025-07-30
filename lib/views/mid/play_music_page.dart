import 'dart:async';
import 'dart:ui';
import 'package:fdp_app/views/main/layout_page.dart';
import 'package:fdp_app/views/main/music_main_page.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayMusicPage extends StatefulWidget {
  late int index = 0;
  PlayMusicPage({super.key, required this.index});

  @override
  State<PlayMusicPage> createState() => _PlayMusicPageState();
}

class _PlayMusicPageState extends State<PlayMusicPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late StreamSubscription<Duration> _positionSub;
  late StreamSubscription<PlayerState> _playerStateSub;

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool isPlaying = false;
  List<String> imageUrls = [
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
  ];

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      await _audioPlayer.setUrl(imageUrls[widget.index]);
      _duration = _audioPlayer.duration ?? Duration.zero;

      _positionSub = _audioPlayer.positionStream.listen((pos) {
        setState(() => _position = pos);
      });

      _playerStateSub = _audioPlayer.playerStateStream.listen((state) {
        setState(() => isPlaying = state.playing);
      });
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _positionSub.cancel();
    _playerStateSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Blurred background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1487215078519-e21cc028cb29?fit=crop&w=800&q=80',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double imageSize = constraints.maxWidth * 0.7;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Top bar
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MusicMainPage(
                                    showMiniPlayer: true,
                                    indexSong: widget.index,
                                  ),
                                ),
                              );
                            },
                          ),
                          const Spacer(),
                          const Text(
                            'Now Playing',
                            style: TextStyle(color: Colors.white70),
                          ),
                          const Spacer(),
                          const Icon(Icons.more_vert, color: Colors.white),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Album Art (responsive)
                      Center(
                        child: Container(
                          height: imageSize,
                          width: imageSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://images.unsplash.com/photo-1511376777868-611b54f68947?fit=crop&w=600&q=80',
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 30,
                                offset: Offset(0, 20),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        'SoundHelix Track 1',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'SoundHelix',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 24),

                      // Progress Slider
                      Slider(
                        value: _position.inSeconds
                            .clamp(0, _duration.inSeconds)
                            .toDouble(),
                        max: _duration.inSeconds.toDouble(),
                        activeColor: Colors.white,
                        inactiveColor: Colors.white30,
                        onChanged: (value) async {
                          await _audioPlayer.seek(
                            Duration(seconds: value.toInt()),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatTime(_position),
                            style: const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            _formatTime(_duration),
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                            ),
                            iconSize: 40,
                            onPressed: () {
                              widget.index--;
                              if (widget.index < 0) {
                                widget.index = imageUrls.length - 1;
                              }
                            },
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_audioPlayer.playing) {
                                await _audioPlayer.pause();
                              } else {
                                await _audioPlayer.play();
                              }
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 40,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                            ),
                            iconSize: 40,
                            onPressed: () {
                              setState(() {
                                widget.index++;
                                if (widget.index > imageUrls.length - 1) {
                                  widget.index = 0;
                                }
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Bottom Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.shuffle, color: Colors.white70),
                          Icon(Icons.favorite_border, color: Colors.white70),
                          Icon(Icons.repeat, color: Colors.white70),
                        ],
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
