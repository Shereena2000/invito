import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A pill-shaped button with a leading icon, used for secondary actions
/// like "Get Directions" or "Watch Engagement Glimpse". Lifts and fills
/// with gold on hover.
class ElegantPillButton extends StatefulWidget {
  const ElegantPillButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  State<ElegantPillButton> createState() => _ElegantPillButtonState();
}

class _ElegantPillButtonState extends State<ElegantPillButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.filled || _hovering;
    final bg = active ? AppColors.gold : Colors.transparent;
    final fg = active ? AppColors.ivory : AppColors.gold;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovering ? -3 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: AppColors.gold, width: 1.2),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 17, color: fg),
              const SizedBox(width: 10),
              Text(
                widget.label.toUpperCase(),
                style: AppText.label(11.5, color: fg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
