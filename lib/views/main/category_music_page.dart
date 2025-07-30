import 'dart:ui';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';

class MusicCategoryPage extends StatelessWidget {
  const MusicCategoryPage({super.key});

  final List<Category> categories = const [
    Category(
      title: 'Pop',
      imageUrl:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?fit=crop&w=800&q=80',
    ),
    Category(
      title: 'Rock',
      imageUrl:
          'https://images.unsplash.com/photo-1511376777868-611b54f68947?fit=crop&w=800&q=80',
    ),
    Category(
      title: 'Jazz',
      imageUrl:
          'https://images.unsplash.com/photo-1606312619344-3d8b38aa2e98?fit=crop&w=800&q=80',
    ),
    Category(
      title: 'Electronic',
      imageUrl:
          'https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?fit=crop&w=800&q=80',
    ),
    Category(
      title: 'Hip Hop',
      imageUrl:
          'https://images.unsplash.com/photo-1497032628192-86f99bcd76bc?fit=crop&w=800&q=80',
    ),
    Category(
      title: 'Classical',
      imageUrl:
          'https://images.unsplash.com/photo-1587929651402-ce54a2b3f330?fit=crop&w=800&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Adjust column count based on screen width
            int crossAxisCount = 2;
            if (constraints.maxWidth > 600) {
              crossAxisCount = 3;
            }
            if (constraints.maxWidth > 900) {
              crossAxisCount = 4;
            }

            return ScrollConfiguration(
              behavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              child: LiveGrid.options(
                options: const LiveOptions(
                  delay: Duration(milliseconds: 50),
                  showItemInterval: Duration(milliseconds: 100),
                  showItemDuration: Duration(milliseconds: 300),
                  visibleFraction: 0.05,
                  reAnimateOnVisibility: false,
                ),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index, animation) {
                  final category = categories[index];
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.2),
                        end: Offset.zero,
                      ).animate(animation),
                      child: CategoryCard(category: category),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Category {
  final String title;
  final String imageUrl;

  const Category({required this.title, required this.imageUrl});
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(category.imageUrl, fit: BoxFit.cover),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                category.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
