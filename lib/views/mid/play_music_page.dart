import 'dart:async';
import 'dart:ui';
import 'package:fdp_app/utils/music_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class PlayMusicPage extends StatefulWidget {
  const PlayMusicPage({super.key});

  @override
  State<PlayMusicPage> createState() => _PlayMusicPageState();
}

class _PlayMusicPageState extends State<PlayMusicPage> {
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  // Mock data
  final String currentSongTitle = 'SoundHelix Track 1';
  final String currentArtist = 'SoundHelix';
  final String currentSongImage =
      'https://images.unsplash.com/photo-1511376777868-611b54f68947?fit=crop&w=600&q=80';
  final String audioUrl =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<MusicPlayerController>(
      context,
      listen: false,
    );

    // Cập nhật thời gian
    controller.audioPlayer.durationStream.listen((d) {
      if (d != null) {
        setState(() {
          _duration = d;
        });
      }
    });

    controller.audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MusicPlayerController>(
      context,
      listen: false,
    );
    return Scaffold(
      body: Stack(
        children: [
          // Blurred background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(currentSongImage),
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
                              setState(() {
                                controller.setSong(
                                  currentSongTitle,
                                  currentSongImage,
                                  audioUrl,
                                );
                              });
                              Navigator.pop(context);
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
                            image: DecorationImage(
                              image: NetworkImage(currentSongImage),
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

                      Text(
                        currentSongTitle,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentArtist,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
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
                          await controller.audioPlayer.seek(
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
                            onPressed: () {},
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (controller.isPlaying) {
                                controller.stop();
                              } else {
                                await controller.play(audioUrl);
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
                                controller.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
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
                            onPressed: () {},
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
