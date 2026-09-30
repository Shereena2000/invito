import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/wedding_data.dart';
import '../theme/app_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.ivory,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      child: Column(
        children: [
          Text(
            '${WeddingData.brideName} & ${WeddingData.groomName}',
            style: AppText.script(32, color: AppColors.graphite),
          ),
          const SizedBox(height: 12),
          Text(
            'With love and gratitude, we thank you for being part of our story.',
            textAlign: TextAlign.center,
            style: AppText.body(13, color: AppColors.charcoal.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 22),
          _SocialIconButton(
            icon: Icons.camera_alt_outlined,
            onTap: () => launchUrl(
              Uri.parse(WeddingData.instagramReelUrl),
              webOnlyWindowName: '_blank',
            ),
          ),
          const SizedBox(height: 22),
          Container(width: 40, height: 1, color: AppColors.gold.withValues(alpha: 0.4)),
          const SizedBox(height: 20),
          Text(
            '© ${WeddingData.weddingDate.year} · Made with love',
            style: AppText.body(12, color: AppColors.charcoal.withValues(alpha: 0.4)),
          ),
        ],
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  const _SocialIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
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
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.gold.withValues(alpha: _hovering ? 1 : 0.5)),
            color: _hovering ? AppColors.gold.withValues(alpha: 0.1) : Colors.transparent,
          ),
          child: Icon(widget.icon, size: 18, color: AppColors.gold),
        ),
      ),
    );
  }
}
