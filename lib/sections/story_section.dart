import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/wedding_data.dart';
import '../theme/app_theme.dart';
import '../widgets/elegant_button.dart';
import '../widgets/reveal_on_scroll.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);

    final image = RevealOnScroll(
      child: Stack(
        children: [
          Positioned.fill(
            top: 18,
            left: 18,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gold, width: 1.4),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18, bottom: 18),
            child: _HoverTiltImage(aspectRatio: isMobile ? 4 / 3 : 1),
          ),
        ],
      ),
    );

    final text = RevealOnScroll(
      delay: 150.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '“',
            style: AppText.heading(72, color: AppColors.gold.withValues(alpha: 0.35), weight: FontWeight.w700),
          ),
          Transform.translate(
            offset: const Offset(0, -36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('OUR STORY', style: AppText.label(13)),
                const SizedBox(height: 14),
                Text('How it all began', style: AppText.heading(isMobile ? 30 : 40)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'We started out as classmates, never expecting that the person '
            'sitting nearby would one day become our forever. Friends since '
            '2018, we grew closer with every passing year, and on April 19, '
            '2026 we made it official with an exchange of rings. Now, hand in '
            'hand, we\'re ready to begin this new chapter as husband and wife.',
            style: AppText.body(isMobile ? 14 : 16),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Container(width: 40, height: 1.4, color: AppColors.gold),
              const SizedBox(width: 12),
              Text(
                '${WeddingData.brideName} & ${WeddingData.groomName}',
                style: AppText.script(28),
              ),
            ],
          ),
          const SizedBox(height: 26),
          ElegantPillButton(
            icon: Icons.play_circle_fill_rounded,
            label: 'Watch Engagement Glimpse',
            filled: true,
            onTap: () => launchUrl(
              Uri.parse(WeddingData.instagramReelUrl),
              webOnlyWindowName: '_blank',
            ),
          ),
        ],
      ),
    );

    return Container(
      color: AppColors.ivory,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 64 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: isMobile
              ? Column(
                  children: [
                    image,
                    const SizedBox(height: 36),
                    text,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: image),
                    const SizedBox(width: 64),
                    Expanded(child: text),
                  ],
                ),
        ),
      ),
    );
  }
}

extension on int {
  Duration get ms => Duration(milliseconds: this);
}

class _HoverTiltImage extends StatefulWidget {
  const _HoverTiltImage({required this.aspectRatio});

  final double aspectRatio;

  @override
  State<_HoverTiltImage> createState() => _HoverTiltImageState();
}

class _HoverTiltImageState extends State<_HoverTiltImage> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_hovering ? -0.03 : 0)
          ..rotateX(_hovering ? 0.02 : 0)
          ..scaleByDouble(
            _hovering ? 1.02 : 1.0,
            _hovering ? 1.02 : 1.0,
            1.0,
            1.0,
          ),
        transformAlignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: Image.asset(WeddingData.storyImage, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
