import 'package:flutter/material.dart';
import '../data/wedding_data.dart';
import '../theme/app_theme.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.scrolled,
    required this.onNavTap,
  });

  final bool scrolled;
  final void Function(int index) onNavTap;

  static const _items = ['Intro', 'Our Odyssey', 'The Day', 'Moments', 'RSVP'];

  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _MobileMenuSheet(
        onTap: (i) {
          Navigator.of(ctx).pop();
          onNavTap(i);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: 18),
      decoration: BoxDecoration(
        color: scrolled ? AppColors.ivory.withValues(alpha: 0.96) : Colors.transparent,
        boxShadow: scrolled
            ? [
                BoxShadow(
                  color: AppColors.charcoal.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${WeddingData.brideName[0]} & ${WeddingData.groomName[0]}',
            style: AppText.script(26, color: scrolled ? AppColors.graphite : Colors.white),
          ),
          if (!isMobile)
            Row(
              children: [
                for (int i = 0; i < _items.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: _NavItem(
                      label: _items[i],
                      light: !scrolled,
                      onTap: () => onNavTap(i),
                    ),
                  ),
              ],
            )
          else
            GestureDetector(
              onTap: () => _openMenu(context),
              child: Icon(Icons.menu_rounded, color: scrolled ? AppColors.charcoal : Colors.white),
            ),
        ],
      ),
    );
  }
}

class _MobileMenuSheet extends StatelessWidget {
  const _MobileMenuSheet({required this.onTap});

  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(28, 16, 28, 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.charcoal.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '${WeddingData.brideName} & ${WeddingData.groomName}',
            style: AppText.script(28, color: AppColors.graphite),
          ),
          const SizedBox(height: 22),
          for (int i = 0; i < NavBar._items.length; i++) ...[
            if (i > 0) Divider(color: AppColors.gold.withValues(alpha: 0.2), height: 1),
            InkWell(
              onTap: () => onTap(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      NavBar._items[i].toUpperCase(),
                      style: AppText.label(13, color: AppColors.charcoal, weight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({required this.label, required this.light, required this.onTap});

  final String label;
  final bool light;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.light ? Colors.white : AppColors.charcoal;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label.toUpperCase(),
              style: AppText.label(12, color: color, weight: FontWeight.w400),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 1.4,
              width: _hovering ? 18 : 0,
              color: AppColors.gold,
            ),
          ],
        ),
      ),
    );
  }
}
