import 'dart:ui';
import 'package:fdp_app/views/main/infrom_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A2980), Color(0xFF26D0CE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: ScrollConfiguration(
              behavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final isSmallScreen = screenWidth < 360;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Avatar or login button
                        isLoggedIn
                            ? CircleAvatar(
                                radius:
                                    screenWidth *
                                    0.12, // Adjust size based on screen width
                                backgroundImage: const NetworkImage(
                                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?fit=crop&w=200&q=80',
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(
                                    0.2,
                                  ),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            InfromPage(),
                                      ),
                                    );
                                  });
                                },
                                child: const Text('Login'),
                              ),

                        const SizedBox(height: 12),

                        Text(
                          isLoggedIn ? 'Alex Johnson' : 'Unknown',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          isLoggedIn ? 'alex.music@example.com' : '',
                          style: const TextStyle(color: Colors.white70),
                        ),

                        const SizedBox(height: 20),

                        // Stats (same regardless of login state)
                        GlassContainer(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06,
                            vertical: screenWidth * 0.03,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Expanded(
                                child: _StatItem(title: 'Playlists', count: 0),
                              ),
                              Expanded(
                                child: _StatItem(title: 'Followers', count: 0),
                              ),
                              Expanded(
                                child: _StatItem(title: 'Following', count: 0),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Favorite Genres (only when logged in)
                        const SectionTitle('Favorite Genres'),
                        const SizedBox(height: 8),
                        if (isLoggedIn)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: const [
                              GenreChip(label: 'Pop'),
                              GenreChip(label: 'Jazz'),
                              GenreChip(label: 'Hip Hop'),
                              GenreChip(label: 'Classical'),
                              GenreChip(label: 'Electronic'),
                            ],
                          )
                        else
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'No genres selected',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 30),

                        const SectionTitle('Recently Played'),
                        const SizedBox(height: 12),

                        SizedBox(
                          height: 160,
                          child: isLoggedIn
                              ? ListView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  children: [
                                    PlaylistCard(
                                      title: 'Morning Vibes',
                                      imageUrl:
                                          'https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?fit=crop&w=200&q=80',
                                      screenWidth: screenWidth,
                                    ),
                                    PlaylistCard(
                                      title: 'Chill Beats',
                                      imageUrl:
                                          'https://images.unsplash.com/photo-1497032628192-86f99bcd76bc?fit=crop&w=200&q=80',
                                      screenWidth: screenWidth,
                                    ),
                                    PlaylistCard(
                                      title: 'Jazz Nights',
                                      imageUrl:
                                          'https://images.unsplash.com/photo-1606312619344-3d8b38aa2e98?fit=crop&w=200&q=80',
                                      screenWidth: screenWidth,
                                    ),
                                  ],
                                )
                              : const Center(
                                  child: Text(
                                    'No recently played songs',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Glass effect container
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const GlassContainer({
    required this.child,
    this.margin,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final int count;

  const _StatItem({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(title, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

class GenreChip extends StatelessWidget {
  final String label;

  const GenreChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white.withOpacity(0.1),
      labelStyle: const TextStyle(color: Color.fromARGB(255, 87, 87, 87)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

class PlaylistCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double screenWidth;

  const PlaylistCard({
    required this.title,
    required this.imageUrl,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = screenWidth * 0.35;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(blurRadius: 4, color: Colors.black)],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
