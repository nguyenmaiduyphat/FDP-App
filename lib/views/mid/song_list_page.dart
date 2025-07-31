// The complete rewritten version of your SongListPage with a filter menu
// and integrated filtering logic. Split into UI and filtering logic clearly.

import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:fdp_app/views/main/layout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class SongListPage extends StatefulWidget {
  const SongListPage({super.key});

  @override
  State<SongListPage> createState() => _SongListPageState();
}

enum SortType { alphabet, date, length }

enum SortOrder { ascending, descending }

class Song {
  final String name;
  final DateTime date;
  final Duration length;
  final String singer;
  final String genre;
  final String type;

  Song({
    required this.name,
    required this.date,
    required this.length,
    required this.singer,
    required this.genre,
    required this.type,
  });
}

class _SongListPageState extends State<SongListPage>
    with SingleTickerProviderStateMixin {
  final List<Song> allSongs = [
    Song(
      name: "Lost in Space",
      date: DateTime(2022, 5, 14),
      length: Duration(seconds: 75),
      singer: "Nova",
      genre: "Pop",
      type: "Studio",
    ),
    Song(
      name: "Skyline",
      date: DateTime(2023, 3, 10),
      length: Duration(seconds: 230),
      singer: "Echo",
      genre: "Rock",
      type: "Live",
    ),
    Song(
      name: "Waves",
      date: DateTime(2021, 11, 1),
      length: Duration(seconds: 550),
      singer: "Aqua",
      genre: "Chill",
      type: "Remix",
    ),
    Song(
      name: "Neon Lights",
      date: DateTime(2024, 6, 21),
      length: Duration(seconds: 95),
      singer: "Lumen",
      genre: "Electronic",
      type: "Studio",
    ),
    Song(
      name: "Crimson Sky",
      date: DateTime(2020, 8, 3),
      length: Duration(seconds: 180),
      singer: "Blaze",
      genre: "Rock",
      type: "Live",
    ),
    Song(
      name: "Frozen Echoes",
      date: DateTime(2023, 12, 12),
      length: Duration(seconds: 45),
      singer: "Crystal",
      genre: "Ambient",
      type: "Studio",
    ),
    Song(
      name: "Golden Dust",
      date: DateTime(2019, 4, 9),
      length: Duration(seconds: 650),
      singer: "Sahara",
      genre: "Chill",
      type: "Remix",
    ),
    Song(
      name: "Mirror Maze",
      date: DateTime(2022, 9, 30),
      length: Duration(seconds: 110),
      singer: "Nova",
      genre: "Pop",
      type: "Studio",
    ),
    Song(
      name: "Underworld",
      date: DateTime(2020, 1, 1),
      length: Duration(seconds: 390),
      singer: "Echo",
      genre: "Rock",
      type: "Live",
    ),
    Song(
      name: "Twilight Glow",
      date: DateTime(2023, 7, 17),
      length: Duration(seconds: 200),
      singer: "Lumen",
      genre: "Pop",
      type: "Studio",
    ),
    Song(
      name: "Zen Garden",
      date: DateTime(2021, 2, 14),
      length: Duration(seconds: 360),
      singer: "Aqua",
      genre: "Ambient",
      type: "Studio",
    ),
    Song(
      name: "Cyber Dreams",
      date: DateTime(2024, 3, 4),
      length: Duration(seconds: 510),
      singer: "Crystal",
      genre: "Electronic",
      type: "Remix",
    ),
    Song(
      name: "Storm",
      date: DateTime(2022, 11, 5),
      length: Duration(seconds: 85),
      singer: "Blaze",
      genre: "Rock",
      type: "Studio",
    ),
    Song(
      name: "Rainfall",
      date: DateTime(2023, 5, 23),
      length: Duration(seconds: 250),
      singer: "Nova",
      genre: "Pop",
      type: "Studio",
    ),
    Song(
      name: "Serenity",
      date: DateTime(2021, 10, 11),
      length: Duration(seconds: 100),
      singer: "Sahara",
      genre: "Chill",
      type: "Studio",
    ),
    Song(
      name: "Fire Within",
      date: DateTime(2022, 6, 6),
      length: Duration(seconds: 175),
      singer: "Blaze",
      genre: "Rock",
      type: "Live",
    ),
    Song(
      name: "Moonchild",
      date: DateTime(2020, 12, 24),
      length: Duration(seconds: 460),
      singer: "Crystal",
      genre: "Pop",
      type: "Remix",
    ),
    Song(
      name: "Solar Flare",
      date: DateTime(2024, 1, 2),
      length: Duration(seconds: 125),
      singer: "Echo",
      genre: "Electronic",
      type: "Studio",
    ),
    Song(
      name: "Depths",
      date: DateTime(2019, 9, 19),
      length: Duration(seconds: 720),
      singer: "Aqua",
      genre: "Ambient",
      type: "Remix",
    ),
    Song(
      name: "Radiance",
      date: DateTime(2023, 8, 29),
      length: Duration(seconds: 310),
      singer: "Lumen",
      genre: "Pop",
      type: "Studio",
    ),
  ];

  late List<Song> displayedSongs = List.from(allSongs);

  SortType _selectedSortType = SortType.alphabet;
  SortOrder _sortOrder = SortOrder.ascending;

  // Filter states
  int? selectedDurationRange;
  String? selectedSinger;
  String? selectedGenre;
  String? selectedType;

  bool _showFilterPanel = false;
  late final AnimationController _filterController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  void _toggleFilterPanel() {
    setState(() => _showFilterPanel = !_showFilterPanel);
    _showFilterPanel
        ? _filterController.forward()
        : _filterController.reverse();
  }

  void _applyFilters() {
    List<Song> filtered = List.from(allSongs);

    if (selectedDurationRange != null) {
      filtered = filtered.where((s) {
        final sec = s.length.inSeconds;
        switch (selectedDurationRange) {
          case 0:
            return sec <= 10;
          case 1:
            return sec > 10 && sec <= 30;
          case 2:
            return sec > 30 && sec <= 90;
          case 3:
            return sec > 90 && sec <= 300;
          case 4:
            return sec > 300 && sec <= 600;
          case 5:
            return sec > 600;
        }
        return true;
      }).toList();
    }

    if (selectedSinger != null) {
      filtered = filtered.where((s) => s.singer == selectedSinger).toList();
    }
    if (selectedGenre != null) {
      filtered = filtered
          .where(
            (s) => s.genre.toLowerCase().contains(selectedGenre!.toLowerCase()),
          )
          .toList();
    }
    if (selectedType != null) {
      filtered = filtered.where((s) => s.type == selectedType).toList();
    }

    setState(() => displayedSongs = filtered);
    _toggleFilterPanel();
  }

  void _sortSongs() {
    displayedSongs.sort((a, b) {
      int compare;
      switch (_selectedSortType) {
        case SortType.alphabet:
          compare = a.name.compareTo(b.name);
          break;
        case SortType.date:
          compare = a.date.compareTo(b.date);
          break;
        case SortType.length:
          compare = a.length.compareTo(b.length);
          break;
      }
      return _sortOrder == SortOrder.ascending ? compare : -compare;
    });
  }

  Widget _buildFilterPanel() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      right: _showFilterPanel ? 0 : -300,
      top: 0,
      bottom: 0,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        color: Colors.black87,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Filters",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 16),
            DropdownButton<int>(
              hint: const Text(
                "Duration",
                style: TextStyle(color: Colors.white70),
              ),
              dropdownColor: Colors.grey[850],
              value: selectedDurationRange,
              isExpanded: true,
              items:
                  const [
                        "0s - 10s",
                        "10s - 30s",
                        "30s - 1m30s",
                        "1m30s - 5m",
                        "5m - 10m",
                        "10m+",
                      ]
                      .asMap()
                      .entries
                      .map(
                        (entry) => DropdownMenuItem(
                          value: entry.key,
                          child: Text(
                            entry.value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (val) => setState(() => selectedDurationRange = val),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Singer',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (val) => selectedSinger = val,
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Genre',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (val) => selectedGenre = val,
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Type',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (val) => selectedType = val,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _applyFilters,
              child: const Text("Apply Filters"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _sortSongs();
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header with search and filter icon
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.deepPurple.shade900,
                                Colors.deepPurple.shade400,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              icon: Icon(Icons.search, color: Colors.white70),
                              hintText: 'Search song...',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.tune, color: Colors.white),
                        onPressed: _toggleFilterPanel,
                      ),
                    ],
                  ),
                ),
                // Sort buttons
                Row(
                  children: [
                    Expanded(child: _buildSortButton(SortType.alphabet, 'A-Z')),
                    Expanded(child: _buildSortButton(SortType.date, 'Date')),
                    Expanded(
                      child: _buildSortButton(SortType.length, 'Length'),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AnimationLimiter(
                      child: LiveGrid.options(
                        itemCount: displayedSongs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 14,
                              childAspectRatio: 1.1,
                            ),
                        options: const LiveOptions(
                          delay: Duration(milliseconds: 100),
                          showItemInterval: Duration(milliseconds: 100),
                          showItemDuration: Duration(milliseconds: 300),
                          reAnimateOnVisibility: true,
                        ),
                        itemBuilder: (context, index, animation) {
                          final song = displayedSongs[index];
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.1),
                                end: Offset.zero,
                              ).animate(animation),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.deepPurple.shade800.withOpacity(
                                        0.7,
                                      ),
                                      Colors.purpleAccent.shade100.withOpacity(
                                        0.3,
                                      ),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 6,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      song.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Duration: ${song.length.inMinutes}:${(song.length.inSeconds % 60).toString().padLeft(2, '0')}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      'Date: ${DateFormat('dd/MM/yyyy').format(song.date)}',
                                      style: const TextStyle(
                                        color: Colors.white60,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _buildFilterPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildSortButton(SortType type, String label) {
    final isSelected = _selectedSortType == type;
    final icon = isSelected
        ? (_sortOrder == SortOrder.ascending
              ? Icons.arrow_upward
              : Icons.arrow_downward)
        : Icons.unfold_more;
    return TextButton.icon(
      onPressed: () {
        setState(() {
          if (_selectedSortType == type) {
            _sortOrder = _sortOrder == SortOrder.ascending
                ? SortOrder.descending
                : SortOrder.ascending;
          } else {
            _selectedSortType = type;
            _sortOrder = SortOrder.ascending;
          }
        });
      },
      icon: Icon(icon, size: 16, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
