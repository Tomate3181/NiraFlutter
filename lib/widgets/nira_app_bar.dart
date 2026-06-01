import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';

// ── Paleta de marca ────────────────────────────────────────────────────────
const _kBgMain = Color(0xFF11111B);
const _kBorder = Color(0xFF2B2B3C);
const _kEmergency = Color(0xFFE53E3E);

// ══════════════════════════════════════════════════════════════════════════════
// NiraAppBar — Navbar customizada reutilizável
// ══════════════════════════════════════════════════════════════════════════════
class NiraAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title; // Se null, mostra "Nira"
  final bool showSosButton;

  const NiraAppBar({super.key, this.title, this.showSosButton = true});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kBgMain,
        border: Border(
          bottom: BorderSide(color: _kBorder.withValues(alpha: 0.3)),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? 'Nira',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              if (showSosButton) _buildSosButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSosButton(BuildContext context) {
    return InkWell(
      onTap: () =>
          GoRouter.of(context).go('/chat', extra: {'sos': true, 'start': true}),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _kEmergency.withValues(alpha: 0.15),
          border: Border.all(color: _kEmergency.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.alertTriangle, color: _kEmergency, size: 16),
            const SizedBox(width: 6),
            const Text(
              'S.O.S',
              style: TextStyle(
                color: _kEmergency,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
