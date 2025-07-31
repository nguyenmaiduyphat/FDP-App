import 'dart:async';
import 'dart:ui';

import 'package:fdp_app/utils/music_player_controller.dart';
import 'package:fdp_app/views/main/category_music_page.dart';
import 'package:fdp_app/views/main/music_main_page.dart';
import 'package:fdp_app/views/main/profile_page.dart';
import 'package:fdp_app/views/mid/play_music_page.dart';
import 'package:fdp_app/views/mid/song_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late AnimationController _controller;
  late Animation<Color?> _gradient1;
  late Animation<Color?> _gradient2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _gradient1 = ColorTween(
      begin: const Color(0xFF1A2980),
      end: const Color(0xFF26D0CE),
    ).animate(_controller);

    _gradient2 = ColorTween(
      begin: const Color(0xFF6A82FB),
      end: const Color(0xFFFC5C7D),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MusicPlayerController>(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // Background gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _gradient1.value ?? Colors.black,
                      _gradient2.value ?? Colors.black,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Main content
              SafeArea(
                child: Column(
                  children: [
                    // ----------- HEADER -----------
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          // Logo + Name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Lottie.asset(
                                  'assets/animation/macos - Apple Music icon.json',
                                  repeat: true,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "FDP Music",
                                style: GoogleFonts.dancingScript(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Search bar
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              onSubmitted: (value) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SongListPage(),
                                  ),
                                );
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                icon: Icon(Icons.search, color: Colors.white70),
                                hintText: "Nhập bài hát của bạn...",
                                hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ----------- BODY -----------
                    Expanded(child: Center(child: _buildPage(selectedIndex))),
                    // ✅ MiniPlayer được đặt ở đây
                    if (controller.currentSong.isNotEmpty)
                      Miniplayer(
                        controller: controller.miniplayerController,
                        minHeight: 50,
                        maxHeight: 350,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 300),
                        builder: (height, percentage) {
                          return Dismissible(
                            key: const Key("miniplayer"),
                            direction: DismissDirection
                                .endToStart, // swipe từ phải qua trái
                            onDismissed: (direction) {
                              controller.stop();
                              controller.setSong('', '', '');
                            },
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PlayMusicPage(),
                                  ),
                                );
                              },
                              child: Container(
                                color: const Color.fromARGB(221, 59, 99, 93),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        controller.currentImage,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        controller.currentSong,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () async {
                                        await controller.togglePlayPause();
                                      },
                                      child: Icon(
                                        controller.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ----------- FOOTER -----------
          bottomNavigationBar: WaterDropNavBar(
            bottomPadding: 20,
            backgroundColor: const Color(0xFF22252A),
            waterDropColor: const Color(0xFF5D9CEC),
            inactiveIconColor: Colors.white70,
            iconSize: 28,
            selectedIndex: selectedIndex,
            onItemSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            barItems: [
              BarItem(
                filledIcon: Icons.music_note,
                outlinedIcon: Icons.music_note_outlined,
              ),
              BarItem(
                filledIcon: Icons.category,
                outlinedIcon: Icons.category_outlined,
              ),
              BarItem(
                filledIcon: Icons.person,
                outlinedIcon: Icons.person_outline,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPage(int index) {
    final style = GoogleFonts.dancingScript(
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );

    switch (index) {
      case 0:
        return MusicMainPage();
      case 1:
        return MusicCategoryPage();
      case 2:
        return ProfilePage();
      default:
        return Text("Unknown Page", style: style);
    }
  }
}
