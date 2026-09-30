import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../data/wedding_data.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onScrollDown,
    required this.scrollOffset,
  });

  final VoidCallback onScrollDown;
  final ValueListenable<double> scrollOffset;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isMobile = AppBreakpoints.isMobile(width);
    final isTablet = AppBreakpoints.isTablet(width);
    final nameSize = isMobile ? 48.0 : (isTablet ? 64.0 : 96.0);
    final dateStr = DateFormat('MMMM d, yyyy').format(WeddingData.weddingDate);

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            ValueListenableBuilder<double>(
              valueListenable: scrollOffset,
              builder: (context, offset, child) {
                final parallax = (offset * 0.35).clamp(0.0, height * 0.18);
                return Transform.translate(
                  offset: Offset(0, -parallax),
                  child: child,
                );
              },
              child: SizedBox(
                height: height * 1.2,
                child: Image.asset(WeddingData.heroImage, fit: BoxFit.cover)
                    .animate()
                    .fadeIn(duration: 1200.ms)
                    .scale(
                      begin: const Offset(1.08, 1.08),
                      end: const Offset(1, 1),
                      duration: 6000.ms,
                      curve: Curves.easeOut,
                    ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.35),
                    Colors.black.withValues(alpha: 0.25),
                    Colors.black.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
            Center(
              child: Transform.translate(
                offset: const Offset(0, 120),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                            'WE ARE GETTING MARRIED',
                            style: AppText.label(
                              isMobile ? 11 : 14,
                              color: AppColors.softGold,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 300.ms, duration: 700.ms)
                          .slideY(begin: 0.3, end: 0),
                      const SizedBox(height: 18),
                      Text(
                            '${WeddingData.brideName} & ${WeddingData.groomName}',
                            textAlign: TextAlign.center,
                            style: AppText.script(
                              nameSize,
                              color: Colors.white,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 500.ms, duration: 900.ms)
                          .slideY(begin: 0.3, end: 0),
                      const SizedBox(height: 22),
                      Container(
                            width: 60,
                            height: 1.4,
                            color: AppColors.softGold,
                          )
                          .animate()
                          .fadeIn(delay: 800.ms)
                          .scaleX(begin: 0, end: 1, duration: 700.ms),
                      const SizedBox(height: 22),
                      Text(
                        dateStr,
                        style: AppText.heading(
                          isMobile ? 16 : 20,
                          color: Colors.white,
                          weight: FontWeight.w400,
                        ),
                      ).animate().fadeIn(delay: 900.ms, duration: 700.ms),
                      const SizedBox(height: 6),
                      Text(
                        WeddingData.venueName,
                        style: AppText.body(
                          isMobile ? 13 : 15,
                          color: Colors.white70,
                        ),
                      ).animate().fadeIn(delay: 1000.ms, duration: 700.ms),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 28,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: onScrollDown,
                  child: Column(
                    children: [
                      Text(
                        'SCROLL',
                        style: AppText.label(10, color: Colors.white70),
                      ),
                      const SizedBox(height: 6),
                      const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white70,
                            size: 28,
                          )
                          .animate(onPlay: (c) => c.repeat())
                          .moveY(
                            begin: 0,
                            end: 10,
                            duration: 900.ms,
                            curve: Curves.easeInOut,
                          )
                          .then()
                          .moveY(
                            begin: 10,
                            end: 0,
                            duration: 900.ms,
                            curve: Curves.easeInOut,
                          ),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 1400.ms, duration: 800.ms),
          ],
        ),
      ),
    );
  }
}
