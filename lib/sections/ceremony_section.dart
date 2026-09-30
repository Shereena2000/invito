import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/wedding_data.dart';
import '../theme/app_theme.dart';
import '../widgets/elegant_button.dart';
import '../widgets/reveal_on_scroll.dart';

class CeremonySection extends StatelessWidget {
  const CeremonySection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);
    final dateStr = DateFormat('EEEE, MMMM d, yyyy').format(WeddingData.weddingDate);
    final timeStr = DateFormat('h:mm a').format(WeddingData.weddingDate);

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            WeddingData.ceremonyImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.charcoal.withValues(alpha: 0.55),
                  AppColors.charcoal.withValues(alpha: 0.35),
                  AppColors.charcoal.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 80,
            vertical: isMobile ? 64 : 110,
          ),
          child: Center(
            child: RevealOnScroll(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: _InvitationFrame(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _FlourishDivider(),
                      const SizedBox(height: 22),
                      Text('THE BIG DAY', style: AppText.label(13, color: AppColors.gold)),
                      const SizedBox(height: 18),
                      Text(
                        dateStr,
                        textAlign: TextAlign.center,
                        style: AppText.heading(isMobile ? 24 : 32, color: AppColors.charcoal),
                      ),
                      const SizedBox(height: 14),
                      Container(width: 36, height: 1, color: AppColors.gold.withValues(alpha: 0.5)),
                      const SizedBox(height: 14),
                      Text(
                        timeStr,
                        textAlign: TextAlign.center,
                        style: AppText.script(28, color: AppColors.graphite),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        WeddingData.venueName,
                        textAlign: TextAlign.center,
                        style: AppText.body(isMobile ? 13 : 15, color: AppColors.charcoal.withValues(alpha: 0.65)),
                      ),
                      SizedBox(height: isMobile ? 32 : 40),
                      ElegantPillButton(
                        icon: Icons.location_on_outlined,
                        label: 'Get Directions',
                        onTap: () => launchUrl(
                          Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(WeddingData.venueAddress)}',
                          ),
                          webOnlyWindowName: '_blank',
                        ),
                      ),
                      const SizedBox(height: 22),
                      const _FlourishDivider(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// A classic invitation-card double border frame with corner accents.
class _InvitationFrame extends StatelessWidget {
  const _InvitationFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.ivory,
        boxShadow: [
          BoxShadow(
            color: AppColors.charcoal.withValues(alpha: 0.25),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gold.withValues(alpha: 0.6), width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: child,
      ),
    );
  }
}

class _FlourishDivider extends StatelessWidget {
  const _FlourishDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 50, height: 1, color: AppColors.gold.withValues(alpha: 0.5)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Transform.rotate(
            angle: 0.785398,
            child: Container(
              width: 7,
              height: 7,
              color: AppColors.gold,
            ),
          ),
        ),
        Container(width: 50, height: 1, color: AppColors.gold.withValues(alpha: 0.5)),
      ],
    );
  }
}
