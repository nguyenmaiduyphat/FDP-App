import 'dart:ui';

import 'package:fdp_app/views/main/music_main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
      begin: const Color(0xFF1A2980), // Deep blue
      end: const Color(0xFF26D0CE), // Teal
    ).animate(_controller);

    _gradient2 = ColorTween(
      begin: const Color(0xFF6A82FB), // Purple
      end: const Color(0xFFFC5C7D), // Pink-red
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.black,
          body: Container(
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
            child: SafeArea(
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
                              width: 48,
                              height: 48,
                              child: Lottie.asset(
                                'assets/animation/macos - Apple Music icon.json',
                                repeat: true,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "FDP",
                              style: GoogleFonts.dancingScript(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Search bar
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
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
                ],
              ),
            ),
          ),

          // ----------- FOOTER -----------
          bottomNavigationBar: WaterDropNavBar(
            bottomPadding: 20,
            backgroundColor: const Color(0xFF22252A), // Elegant charcoal
            waterDropColor: const Color(0xFF5D9CEC), // Soft sky blue accent
            inactiveIconColor: Colors.white70, // Subtle faded icons
            iconSize: 28, // Default icon size
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
        return Text("Music / Recycle Screen", style: style);
      case 2:
        return Text("Profile", style: style);
      default:
        return Text("Unknown Page", style: style);
    }
  }
}
