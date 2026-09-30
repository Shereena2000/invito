import 'package:flutter/material.dart';
import '../data/wedding_data.dart';
import '../theme/app_theme.dart';
import '../widgets/reveal_on_scroll.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);
    final isTablet = AppBreakpoints.isTablet(width);
    final crossAxisCount = isMobile ? 2 : (isTablet ? 3 : 4);
    final images = WeddingData.galleryImages;

    return Container(
      color: AppColors.ivory,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 64 : 100,
      ),
      child: Column(
        children: [
          RevealOnScroll(
            child: Column(
              children: [
                Text('MOMENTS', style: AppText.label(13)),
                const SizedBox(height: 14),
                Text('Gallery of Love', style: AppText.heading(isMobile ? 28 : 38)),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 36 : 56),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return RevealOnScroll(
                  delay: Duration(milliseconds: 60 * index),
                  child: _GalleryTile(url: images[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryTile extends StatefulWidget {
  const _GalleryTile({required this.url});

  final String url;

  @override
  State<_GalleryTile> createState() => _GalleryTileState();
}

class _GalleryTileState extends State<_GalleryTile> {
  bool _hovering = false;

  void _openLightbox(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black.withValues(alpha: 0.88),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: InteractiveViewer(
              child: Image.asset(widget.url, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
      transitionBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.92, end: 1).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _openLightbox(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedScale(
                scale: _hovering ? 1.08 : 1.0,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                child: Image.asset(widget.url, fit: BoxFit.cover),
              ),
              AnimatedOpacity(
                opacity: _hovering ? 1 : 0,
                duration: const Duration(milliseconds: 250),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.charcoal.withValues(alpha: 0.55),
                      ],
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.zoom_in_rounded, color: Colors.white, size: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
