import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MusicMainPage extends StatefulWidget {
  const MusicMainPage({super.key});

  @override
  State<MusicMainPage> createState() => _MusicMainPageState();
}

class _MusicMainPageState extends State<MusicMainPage>
    with SingleTickerProviderStateMixin {
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
            GridPlaylistSection(),
            SectionTitle(title: '🔥 Top Ranked Playlists'),
            HorizontalListSection(itemCount: 10),
            SectionTitle(title: '🆕 New Songs'),
            HorizontalListSection(itemCount: 8),
            SectionTitle(
              title:
                  '🌟 Recommended songs — ${DateFormat.yMMMMd().format(DateTime.now())}',
            ),
            HorizontalListSection(itemCount: 6),
            SectionTitle(title: '🏆 Playlist Top 50 songs'),
            HorizontalListSection(itemCount: 5),
            SectionTitle(title: '🎬 Albums'),
            HorizontalListSection(itemCount: 7),
          ],
        ),
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
  const GridPlaylistSection({super.key});

  @override
  State<GridPlaylistSection> createState() => _GridPlaylistSectionState();
}

class _GridPlaylistSectionState extends State<GridPlaylistSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: LiveGrid.options(
        options: const LiveOptions(
          delay: Duration(milliseconds: 50),
          showItemInterval: Duration(milliseconds: 50),
          showItemDuration: Duration(milliseconds: 250),
          visibleFraction: 0.05,
          reAnimateOnVisibility: true,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (context, index, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(animation),
            child: buildGridItem(), // Your custom item widget
          ),
        ),
      ),
    );
  }

  Widget buildGridItem() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
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
                image:
                    'https://templates.visual-paradigm.com/repository/images/ab91ae92-ca5f-4455-b661-4338d95954a9/youtube-thumbnails-design/music-mix-youtube-thumbnail.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Topic Title',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Text(
            'Subtitle or Author',
            style: TextStyle(color: Colors.white70, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class HorizontalListSection extends StatefulWidget {
  final int itemCount;

  const HorizontalListSection({required this.itemCount, super.key});

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
          reAnimateOnVisibility: true,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: widget.itemCount,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.2, 0),
              end: Offset.zero,
            ).animate(animation),
            child: buildHorizontalItem(),
          ),
        ),
      ),
    );
  }

  Widget buildHorizontalItem() {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
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
                image:
                    'https://templates.visual-paradigm.com/repository/images/ab91ae92-ca5f-4455-b661-4338d95954a9/youtube-thumbnails-design/music-mix-youtube-thumbnail.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Song Title',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Text(
            'Author Name',
            style: TextStyle(color: Colors.white70, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
