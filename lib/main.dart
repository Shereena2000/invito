import 'package:flutter/material.dart';
import 'sections/ceremony_section.dart';
import 'sections/footer_section.dart';
import 'sections/gallery_section.dart';
import 'sections/hero_section.dart';
import 'sections/rsvp_section.dart';
import 'sections/story_section.dart';
import 'sections/timeline_section.dart';
import 'theme/app_theme.dart';
import 'widgets/nav_bar.dart';

void main() {
  runApp(const WeddingApp());
}

class WeddingApp extends StatelessWidget {
  const WeddingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sreelakshmi & Harikrishnan | Wedding Invitation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.ivory,
      ),
      home: const WeddingHomePage(),
    );
  }
}

class WeddingHomePage extends StatefulWidget {
  const WeddingHomePage({super.key});

  @override
  State<WeddingHomePage> createState() => _WeddingHomePageState();
}

class _WeddingHomePageState extends State<WeddingHomePage> {
  final _scrollController = ScrollController();
  final _sectionKeys = List.generate(5, (_) => GlobalKey());
  final _scrollOffset = ValueNotifier<double>(0);
  final _scrollProgress = ValueNotifier<double>(0);
  bool _scrolled = false;
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    _scrollOffset.value = offset;

    final maxExtent = _scrollController.position.maxScrollExtent;
    _scrollProgress.value = maxExtent > 0 ? (offset / maxExtent).clamp(0, 1) : 0;

    final isScrolled = offset > 60;
    if (isScrolled != _scrolled) {
      setState(() => _scrolled = isScrolled);
    }

    final showBtt = offset > 800;
    if (showBtt != _showBackToTop) {
      setState(() => _showBackToTop = showBtt);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrollOffset.dispose();
    _scrollProgress.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  key: _sectionKeys[0],
                  onScrollDown: () => _scrollToSection(1),
                  scrollOffset: _scrollOffset,
                ),
                StorySection(key: _sectionKeys[1]),
                TimelineSection(key: _sectionKeys[2]),
                GallerySection(key: _sectionKeys[3]),
                const CeremonySection(),
                RsvpSection(key: _sectionKeys[4]),
                const FooterSection(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(scrolled: _scrolled, onNavTap: _scrollToSection),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<double>(
              valueListenable: _scrollProgress,
              builder: (context, progress, _) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(height: 2.5, color: AppColors.gold),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 28,
            right: 28,
            child: Column(
              children: [
                AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  offset: _showBackToTop ? Offset.zero : const Offset(0, 2),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _showBackToTop ? 1 : 0,
                    child: IgnorePointer(
                      ignoring: !_showBackToTop,
                      child: _BackToTopButton(onTap: _scrollToTop),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackToTopButton extends StatefulWidget {
  const _BackToTopButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<_BackToTopButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _hovering ? AppColors.charcoal : AppColors.ivory,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.gold.withValues(alpha: 0.6)),
            boxShadow: [
              BoxShadow(
                color: AppColors.charcoal.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(
            Icons.keyboard_arrow_up_rounded,
            color: _hovering ? AppColors.gold : AppColors.charcoal,
          ),
        ),
      ),
    );
  }
}
