import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Wraps [child] and plays a fade + slide-up animation the first time
/// it scrolls into view.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 40,
  });

  final Widget child;
  final Duration delay;
  final double offset;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(widget),
      onVisibilityChanged: (info) {
        if (!_visible && info.visibleFraction > 0.15) {
          setState(() => _visible = true);
        }
      },
      child: _visible
          ? widget.child
              .animate(delay: widget.delay)
              .fadeIn(duration: 700.ms, curve: Curves.easeOut)
              .slideY(begin: 0.12, end: 0, duration: 700.ms, curve: Curves.easeOutCubic)
          : Opacity(opacity: 0, child: widget.child),
    );
  }
}
