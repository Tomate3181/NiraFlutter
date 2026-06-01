import 'dart:ui';
import 'package:flutter/material.dart';

// Paleta de cores da marca (alinhada com o site React)
const _kBgSecondary  = Color(0xFF1E1E2E);
const _kBorder       = Color(0xFF2B2B3C);
const _kBrandPrimary = Color(0xFF8B7EFA);

class NiraGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blurIntensity;
  final bool glowPrimary;

  const NiraGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 16.0,
    this.blurIntensity = 10.0,
    this.glowPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // ClipRRect é crucial para evitar vazamento de blur no Flutter Web (HTML/CanvasKit)
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurIntensity, sigmaY: blurIntensity),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            // Fundo levemente escuro-azulado, alinhado com #1E1E2E do site
            color: _kBgSecondary.withValues(alpha: 0.65),
            // Borda sutil #2B2B3C (igual ao CSS do site React)
            border: Border.all(
              color: glowPrimary
                  ? _kBrandPrimary.withValues(alpha: 0.28)
                  : _kBorder,
              width: 1.0,
            ),
            boxShadow: glowPrimary
                ? [
                    BoxShadow(
                      color: _kBrandPrimary.withValues(alpha: 0.1),
                      blurRadius: 24,
                    ),
                  ]
                : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
