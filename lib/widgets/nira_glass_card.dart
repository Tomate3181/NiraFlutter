import 'dart:ui';
import 'package:flutter/material.dart';

class NiraGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blurOpacity;
  final double blurIntensity;

  const NiraGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 16.0,
    this.blurOpacity = 0.1,
    this.blurIntensity = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // O ClipRRect é crucial aqui para evitar vazamento de blur no Flutter Web (HTML/CanvasKit)
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        // Aplica o desfoque de fundo
        filter: ImageFilter.blur(
          sigmaX: blurIntensity,
          sigmaY: blurIntensity,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            // Gradiente linear sutil semi-transparente usando tons muito escuros
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF333333).withValues(alpha: blurOpacity + 0.05), // Cinza muito escuro
                const Color(0xFF000000).withValues(alpha: blurOpacity),        // Preto puro
              ],
            ),
            // Contorno fino para simular a borda física do vidro (efeito cristal)
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
