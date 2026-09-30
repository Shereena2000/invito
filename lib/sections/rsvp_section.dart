import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/reveal_on_scroll.dart';

class RsvpSection extends StatefulWidget {
  const RsvpSection({super.key});

  @override
  State<RsvpSection> createState() => _RsvpSectionState();
}

class _RsvpSectionState extends State<RsvpSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _submitted = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);

    return Container(
      color: AppColors.stone,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 64 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: RevealOnScroll(
            child: Column(
              children: [
                Text(
                  'Join our Story',
                  style: AppText.script(isMobile ? 44 : 60),
                ),
                SizedBox(height: isMobile ? 40 : 56),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _submitted ? _ThankYouCard(key: const ValueKey('thanks')) : _buildForm(isMobile),
                ),
                SizedBox(height: isMobile ? 24 : 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(bool isMobile) {
    return Form(
      key: const ValueKey('form'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isMobile)
            Column(
              children: [
                _RsvpField(
                  controller: _nameController,
                  hint: 'YOUR NAME',
                  validatorMsg: 'Please enter your name',
                ),
                const SizedBox(height: 28),
                _RsvpField(controller: _emailController, hint: 'EMAIL ADDRESS'),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _RsvpField(
                    controller: _nameController,
                    hint: 'YOUR NAME',
                    validatorMsg: 'Please enter your name',
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(
                  child: _RsvpField(controller: _emailController, hint: 'EMAIL ADDRESS'),
                ),
              ],
            ),
          const SizedBox(height: 28),
          _RsvpField(
            controller: _messageController,
            hint: 'A MESSAGE FOR THE COUPLE',
            maxLines: 3,
          ),
          SizedBox(height: isMobile ? 36 : 48),
          Center(child: _SendWishesButton(onTap: _submit)),
        ],
      ),
    );
  }
}

class _RsvpField extends StatelessWidget {
  const _RsvpField({
    required this.controller,
    required this.hint,
    this.validatorMsg,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final String? validatorMsg;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: AppText.body(15, color: AppColors.charcoal),
      validator: validatorMsg == null ? null : (v) => (v == null || v.isEmpty) ? validatorMsg : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppText.label(12, color: AppColors.charcoal.withValues(alpha: 0.35)),
        contentPadding: const EdgeInsets.only(bottom: 10),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.charcoal.withValues(alpha: 0.2)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.charcoal.withValues(alpha: 0.2)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.gold, width: 1.4),
        ),
      ),
    );
  }
}

class _SendWishesButton extends StatefulWidget {
  const _SendWishesButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_SendWishesButton> createState() => _SendWishesButtonState();
}

class _SendWishesButtonState extends State<_SendWishesButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _hovering ? 1.04 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: _hovering ? AppColors.charcoal : AppColors.gold,
            foregroundColor: AppColors.ivory,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            elevation: 0,
          ),
          child: Text(
            'SEND WISHES',
            style: AppText.label(13, color: _hovering ? AppColors.gold : AppColors.ivory),
          ),
        ),
      ),
    );
  }
}

class _ThankYouCard extends StatelessWidget {
  const _ThankYouCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('thanks'),
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Icon(Icons.favorite, color: AppColors.gold, size: 36)
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scaleXY(begin: 1, end: 1.15, duration: 700.ms, curve: Curves.easeInOut),
          const SizedBox(height: 16),
          Text('Thank You!', style: AppText.heading(24)),
          const SizedBox(height: 10),
          Text(
            'Your wishes have been sent. We can\'t wait to celebrate with you!',
            textAlign: TextAlign.center,
            style: AppText.body(14),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).scaleXY(begin: 0.94, end: 1, duration: 400.ms, curve: Curves.easeOut);
  }
}
