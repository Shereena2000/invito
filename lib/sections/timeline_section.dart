import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/wedding_data.dart';
import '../theme/app_theme.dart';
import '../widgets/elegant_button.dart';
import '../widgets/reveal_on_scroll.dart';

IconData _iconFor(String id) {
  switch (id) {
    case 'sangeet':
      return Icons.music_note_outlined;
    case 'gulabi':
      return Icons.home_outlined;
    case 'thalikettu':
      return Icons.temple_hindu_outlined;
    case 'ceremony':
      return Icons.favorite_outline;
    case 'reception':
      return Icons.celebration_outlined;
    default:
      return Icons.event_outlined;
  }
}

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);
    final isTablet = AppBreakpoints.isTablet(width);
    final zigzag = !isMobile && !isTablet;
    final group = Uri.base.queryParameters['group'];
    final events = WeddingData.eventsForGroup(group);

    return Container(
      color: AppColors.stone,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 64 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              RevealOnScroll(
                child: Column(
                  children: [
                    Text('SAVE THE DATES', style: AppText.label(13)),
                    const SizedBox(height: 14),
                    Text('Our Wedding Events', style: AppText.heading(isMobile ? 28 : 38)),
                  ],
                ),
              ),
              SizedBox(height: isMobile ? 40 : 64),
              for (int i = 0; i < events.length; i++)
                RevealOnScroll(
                  delay: Duration(milliseconds: 100 * i),
                  child: zigzag
                      ? _ZigzagTile(
                          event: events[i],
                          isLast: i == events.length - 1,
                          alignLeft: i.isEven,
                        )
                      : _LinearTile(
                          event: events[i],
                          isLast: i == events.length - 1,
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventNode extends StatefulWidget {
  const _EventNode({required this.icon});

  final IconData icon;

  @override
  State<_EventNode> createState() => _EventNodeState();
}

class _EventNodeState extends State<_EventNode> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final glow = 0.15 + _controller.value * 0.25;
        return Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.ivory,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.gold, width: 1.4),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: glow),
                blurRadius: 14,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(widget.icon, size: 18, color: AppColors.gold),
        );
      },
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event, this.crossAxisAlignment = CrossAxisAlignment.start});

  final WeddingEvent event;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final rightAligned = crossAxisAlignment == CrossAxisAlignment.end;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.graphite.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            '${event.date} · ${event.time}',
            style: AppText.label(11),
            textAlign: rightAligned ? TextAlign.right : TextAlign.left,
          ),
          const SizedBox(height: 6),
          Text(event.title, style: AppText.heading(20)),
          const SizedBox(height: 8),
          Text(
            event.description,
            style: AppText.body(14),
            textAlign: rightAligned ? TextAlign.right : TextAlign.left,
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: rightAligned ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: AppColors.graphite.withValues(alpha: 0.6)),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  event.location,
                  style: AppText.body(13, color: AppColors.charcoal.withValues(alpha: 0.65)),
                  textAlign: rightAligned ? TextAlign.right : TextAlign.left,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: rightAligned ? Alignment.centerRight : Alignment.centerLeft,
            child: ElegantPillButton(
              icon: Icons.location_on_outlined,
              label: 'Directions',
              onTap: () => launchUrl(Uri.parse(event.mapsUrl), webOnlyWindowName: '_blank'),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinearTile extends StatelessWidget {
  const _LinearTile({required this.event, required this.isLast});

  final WeddingEvent event;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _EventNode(icon: _iconFor(event.id)),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.4,
                    color: AppColors.gold.withValues(alpha: 0.35),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: _EventCard(event: event),
            ),
          ),
        ],
      ),
    );
  }
}

class _ZigzagTile extends StatelessWidget {
  const _ZigzagTile({required this.event, required this.isLast, required this.alignLeft});

  final WeddingEvent event;
  final bool isLast;
  final bool alignLeft;

  @override
  Widget build(BuildContext context) {
    final card = alignLeft
        ? _EventCard(event: event, crossAxisAlignment: CrossAxisAlignment.end)
        : _EventCard(event: event);

    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 48),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: alignLeft ? card : const SizedBox()),
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  _EventNode(icon: _iconFor(event.id)),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 1.4,
                        color: AppColors.gold.withValues(alpha: 0.35),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(child: alignLeft ? const SizedBox() : card),
          ],
        ),
      ),
    );
  }
}
