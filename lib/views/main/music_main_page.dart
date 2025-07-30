import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:fdp_app/components/miniplayer.dart';
import 'package:fdp_app/models/musicitem%20.dart';
import 'package:fdp_app/views/mid/play_music_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MusicMainPage extends StatefulWidget {
  const MusicMainPage({super.key});

  @override
  State<MusicMainPage> createState() => _MusicMainPageState();
}

class _MusicMainPageState extends State<MusicMainPage>
    with SingleTickerProviderStateMixin {
  bool showMiniPlayer = true; // điều khiển hiển thị MiniPlayer
  bool isPlaying = false;

  String currentSong = "SoundHelix Track 1";
  String imageUrl =
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
  Duration currentTime = Duration.zero;

  late AnimationController _controller;
  late Animation<Color?> _gradient1;
  late Animation<Color?> _gradient2;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
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

  final List<MusicItem> popularPlaylists = [
    MusicItem(
      title: 'Chill Vibes',
      subtitle: 'By DJ Smooth',
      imageUrl:
          'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Workout Beats',
      subtitle: 'By FitBeats',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Evening Jazz',
      subtitle: 'Jazzify',
      imageUrl:
          'https://images.unsplash.com/photo-1511376777868-611b54f68947?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Sunday Acoustic',
      subtitle: 'Relax FM',
      imageUrl:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Focus Flow',
      subtitle: 'Productive Sound',
      imageUrl:
          'https://images.unsplash.com/photo-1497032628192-86f99bcd76bc?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Upbeat Energy',
      subtitle: 'Morning Mix',
      imageUrl:
          'https://images.unsplash.com/photo-1606312619344-3d8b38aa2e98?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Lo-Fi Rain',
      subtitle: 'LoFidelity',
      imageUrl:
          'https://images.unsplash.com/photo-1587929651402-ce54a2b3f330?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Electronic Chill',
      subtitle: 'SynthCloud',
      imageUrl:
          'https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Retro Vibes',
      subtitle: 'CassetteFM',
      imageUrl:
          'https://images.unsplash.com/photo-1607751053484-42c9866a8797?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Late Night Drive',
      subtitle: 'Moonlight DJs',
      imageUrl:
          'https://images.unsplash.com/photo-1532202802379-d7c7f4d28d4a?fit=crop&w=400&q=80',
    ),
  ];

  final List<MusicItem> topRankedPlaylists = [
    MusicItem(
      title: 'Top 100 Global',
      subtitle: 'Official Charts',
      imageUrl:
          'https://images.unsplash.com/photo-1497032628192-86f99bcd76bc?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Hot Hits USA',
      subtitle: 'Billboard',
      imageUrl:
          'https://images.unsplash.com/photo-1516251193007-45ef944ab0c6?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'UK Chart',
      subtitle: 'BBC Radio 1',
      imageUrl:
          'https://images.unsplash.com/photo-1559526324-593bc073d938?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Top EDM',
      subtitle: 'Festival Vibes',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Rap Caviar',
      subtitle: 'HipHop Today',
      imageUrl:
          'https://images.unsplash.com/photo-1506801310323-534be5e7c2e7?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Pop Rising',
      subtitle: 'Spotify Charts',
      imageUrl:
          'https://images.unsplash.com/photo-1587929651402-ce54a2b3f330?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Trending India',
      subtitle: 'Desi Beats',
      imageUrl:
          'https://images.unsplash.com/photo-1588865797083-dde6df03f665?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Viral 50',
      subtitle: 'Global Mix',
      imageUrl:
          'https://images.unsplash.com/photo-1497032628192-86f99bcd76bc?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Indie Stars',
      subtitle: 'Alternative Picks',
      imageUrl:
          'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Latin Fire',
      subtitle: 'Reggaeton',
      imageUrl:
          'https://images.unsplash.com/photo-1586880244405-22b8c7b4c2b2?fit=crop&w=400&q=80',
    ),
  ];

  final List<MusicItem> newSongs = [
    MusicItem(
      title: 'Sky High',
      subtitle: 'Nova & The Stars',
      imageUrl:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Wild Heart',
      subtitle: 'Rebel Beats',
      imageUrl:
          'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Breathe In',
      subtitle: 'Luna Sky',
      imageUrl:
          'https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Light Up',
      subtitle: 'Glow Squad',
      imageUrl:
          'https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Echoes',
      subtitle: 'The Reverbs',
      imageUrl:
          'https://images.unsplash.com/photo-1614852200360-366b4725e4cc?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Broken Glass',
      subtitle: 'Mystique',
      imageUrl:
          'https://images.unsplash.com/photo-1619983081563-430f0c9f9a75?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'High Tide',
      subtitle: 'Waveform',
      imageUrl:
          'https://images.unsplash.com/photo-1620044195250-385abb9438e7?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Awakening',
      subtitle: 'Dream Seeker',
      imageUrl:
          'https://images.unsplash.com/photo-1535026406642-530e01750ad7?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Mirrors',
      subtitle: 'Reflekt',
      imageUrl:
          'https://images.unsplash.com/photo-1567093325121-b7ba93b70a4b?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Ascend',
      subtitle: 'Eclipse',
      imageUrl:
          'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?fit=crop&w=400&q=80',
    ),
  ];

  final List<MusicItem> recommendedSongs = [
    MusicItem(
      title: 'Rainy Mood',
      subtitle: 'LoFi Dreams',
      imageUrl:
          'https://images.unsplash.com/photo-1511376777868-611b54f68947?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Sunset Drive',
      subtitle: 'City Lights',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Quiet Nights',
      subtitle: 'Sleepwell',
      imageUrl:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Ocean Breeze',
      subtitle: 'Wave Riders',
      imageUrl:
          'https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Midnight Jazz',
      subtitle: 'Blue Notes',
      imageUrl:
          'https://images.unsplash.com/photo-1606312619344-3d8b38aa2e98?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Morning Coffee',
      subtitle: 'Acoustic Mornings',
      imageUrl:
          'https://images.unsplash.com/photo-1497032628192-86f99bcd76bc?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Neon Lights',
      subtitle: 'Synthwave',
      imageUrl:
          'https://images.unsplash.com/photo-1587929651402-ce54a2b3f330?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'City Vibes',
      subtitle: 'Urban Sound',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Dreamcatcher',
      subtitle: 'Sleepy Tunes',
      imageUrl:
          'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Firefly',
      subtitle: 'Night Glow',
      imageUrl:
          'https://images.unsplash.com/photo-1588865797083-dde6df03f665?fit=crop&w=400&q=80',
    ),
  ];

  final List<MusicItem> top50Songs = [
    MusicItem(
      title: 'Firestarter',
      subtitle: 'SoundRush',
      imageUrl:
          'https://images.unsplash.com/photo-1606312619344-3d8b38aa2e98?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Electric Pulse',
      subtitle: 'DJ Volt',
      imageUrl:
          'https://images.unsplash.com/photo-1511376777868-611b54f68947?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Heartbeat',
      subtitle: 'Rhythm Masters',
      imageUrl:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Shooting Star',
      subtitle: 'Galactic',
      imageUrl:
          'https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Golden Hour',
      subtitle: 'Sunset Squad',
      imageUrl:
          'https://images.unsplash.com/photo-1497032628192-86f99bcd76bc?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Rebel Heart',
      subtitle: 'The Outlaws',
      imageUrl:
          'https://images.unsplash.com/photo-1587929651402-ce54a2b3f330?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Lost in Time',
      subtitle: 'Chrono',
      imageUrl:
          'https://images.unsplash.com/photo-1607751053484-42c9866a8797?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Wildfire',
      subtitle: 'Blaze',
      imageUrl:
          'https://images.unsplash.com/photo-1588865797083-dde6df03f665?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Moonlight',
      subtitle: 'Lunar Tunes',
      imageUrl:
          'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'On The Edge',
      subtitle: 'Thrill Seekers',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?fit=crop&w=400&q=80',
    ),
  ];

  final List<MusicItem> albums = [
    MusicItem(
      title: 'Harmony',
      subtitle: 'The Harmonics',
      imageUrl:
          'https://images.unsplash.com/photo-1587929651402-ce54a2b3f330?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Echoes',
      subtitle: 'Soundwave',
      imageUrl:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Midnight Muse',
      subtitle: 'Night Owls',
      imageUrl:
          'https://images.unsplash.com/photo-1497032628192-86f99bcd76bc?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Golden Days',
      subtitle: 'Retro Band',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Neon Nights',
      subtitle: 'City Sounds',
      imageUrl:
          'https://images.unsplash.com/photo-1606312619344-3d8b38aa2e98?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Soul Sessions',
      subtitle: 'The Groove',
      imageUrl:
          'https://images.unsplash.com/photo-1588865797083-dde6df03f665?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Electric Dreams',
      subtitle: 'Synth Masters',
      imageUrl:
          'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Waves',
      subtitle: 'Ocean Sounds',
      imageUrl:
          'https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Sunrise',
      subtitle: 'Morning Tunes',
      imageUrl:
          'https://images.unsplash.com/photo-1497032628192-86f99bcd76bc?fit=crop&w=400&q=80',
    ),
    MusicItem(
      title: 'Firelight',
      subtitle: 'Campfire Band',
      imageUrl:
          'https://images.unsplash.com/photo-1607751053484-42c9866a8797?fit=crop&w=400&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _gradient1.value ?? Colors.blue,
                      _gradient2.value ?? Colors.purple,
                    ],
                  ),
                ),
              ),
              ScrollConfiguration(
                behavior: const MaterialScrollBehavior().copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: SingleChildScrollView(child: child!),
              ),
            ],
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: '🎧 Playlist Popular'),
            GridPlaylistSection(items: popularPlaylists),
            SectionTitle(title: '🔥 Top Ranked Playlists'),
            HorizontalListSection(items: topRankedPlaylists, isSong: false),
            SectionTitle(title: '🆕 New Songs'),
            HorizontalListSection(items: newSongs, isSong: true),
            SectionTitle(
              title:
                  '🌟 Recommended songs — ${DateFormat.yMMMMd().format(DateTime.now())}',
            ),
            HorizontalListSection(items: recommendedSongs, isSong: true),
            SectionTitle(title: '🏆 Playlist Top 50 songs'),
            HorizontalListSection(items: top50Songs, isSong: false),
            SectionTitle(title: '🎬 Albums'),
            HorizontalListSection(items: albums, isSong: false),

            // MiniPlayer phía trên bottom nav
            if (showMiniPlayer)
              Align(
                alignment: Alignment.bottomCenter,
                child: MiniPlayer(
                  songName: currentSong,
                  imageUrl: imageUrl,
                  currentTime: currentTime,
                  isPlaying: isPlaying,
                  onPlayPause: () {
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  },
                  onNext: () {},
                  onPrevious: () {},
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayMusicPage(
                          onCollapse: () {
                            setState(() => showMiniPlayer = true);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                    setState(() => showMiniPlayer = false);
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class GridPlaylistSection extends StatefulWidget {
  final List<MusicItem> items;

  const GridPlaylistSection({required this.items, super.key});

  @override
  State<GridPlaylistSection> createState() => _GridPlaylistSectionState();
}

class _GridPlaylistSectionState extends State<GridPlaylistSection> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine columns based on width
    int crossAxisCount = 2;
    if (screenWidth >= 600) {
      crossAxisCount = 3;
    } else if (screenWidth >= 900) {
      crossAxisCount = 4;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: LiveGrid.options(
        options: const LiveOptions(
          delay: Duration(milliseconds: 50),
          showItemInterval: Duration(milliseconds: 50),
          showItemDuration: Duration(milliseconds: 250),
          visibleFraction: 0.05,
          reAnimateOnVisibility: false,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.items.take(7).length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (context, index, animation) {
          final item = widget.items[index];
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.2),
                end: Offset.zero,
              ).animate(animation),
              child: buildGridItem(item),
            ),
          );
        },
      ),
    );
  }

  Widget buildGridItem(MusicItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.assetNetwork(
                placeholder:
                    'https://archive.org/download/placeholder-image/placeholder-image.jpg',
                image: item.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            item.subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class HorizontalListSection extends StatefulWidget {
  final List<MusicItem> items;
  final bool isSong;

  const HorizontalListSection({
    required this.items,
    super.key,
    required this.isSong,
  });

  @override
  State<HorizontalListSection> createState() => _HorizontalListSectionState();
}

class _HorizontalListSectionState extends State<HorizontalListSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: LiveList.options(
        options: const LiveOptions(
          delay: Duration(milliseconds: 50),
          showItemInterval: Duration(milliseconds: 50),
          showItemDuration: Duration(milliseconds: 250),
          visibleFraction: 0.05,
          reAnimateOnVisibility: false,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.take(7).length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index, animation) {
          final item = widget.items[index];
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.2, 0),
                end: Offset.zero,
              ).animate(animation),
              child: GestureDetector(
                child: buildHorizontalItem(item),
                onTap: () {
                  if (!widget.isSong) {
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PlayMusicPage(onCollapse: () {}),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildHorizontalItem(MusicItem item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / 3.2; // auto-scale
    return Container(
      width: itemWidth,

      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.assetNetwork(
                placeholder:
                    'https://archive.org/download/placeholder-image/placeholder-image.jpg',
                image: item.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            item.subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
