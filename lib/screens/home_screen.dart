import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../widgets/nira_glass_card.dart';

// ── Paleta de marca (alinhada com o site React) ────────────────────────────
const _kBrandPrimary = Color(0xFF8B7EFA);
const _kBgMain = Color(0xFF11111B);
const _kBgSecondary = Color(0xFF1E1E2E);
const _kBorder = Color(0xFF2B2B3C);
const _kTextMuted = Color(0xFFA6A6B0);
const _kEmergency = Color(0xFFE53E3E);

// ══════════════════════════════════════════════════════════════════════════════
// HomeScreen
// ══════════════════════════════════════════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // Removed orb animations (hero simplified)
  late final AnimationController _orbCtrl;

  @override
  void initState() {
    super.initState();

    _orbCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void dispose() {
    _orbCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBgMain,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHero(context),
              const SizedBox(height: 24),
              _buildActionCards(context),
            ],
          ),
        ),
      ),
    );
  }

  // ── HERO ───────────────────────────────────────────────────────────────────
  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.7, -1.0),
          radius: 1.5,
          colors: [Color(0x208B7EFA), Colors.transparent],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'NIRA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 56,
              fontWeight: FontWeight.w900,
              letterSpacing: 6,
            ),
          ),
        ],
      ),
    );
  }

  // ── ACTION CARDS ───────────────────────────────────────────────────────────
  Widget _buildActionCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        children: [
          // SOS — destaque máximo, full-width
          _ActionCard(
            icon: LucideIcons.alertTriangle,
            title: 'S.O.S. Emergência',
            subtitle: 'Acionar socorro silencioso agora',
            color: _kEmergency,
            isPrimary: true,
            isPulsing: true,
            onTap: () => GoRouter.of(
              context,
            ).go('/chat', extra: {'sos': true, 'start': true}),
          ),
          const SizedBox(height: 10),

          // Chat + Conteúdos
          Row(
            children: [
              Expanded(
                child: _ActionCard(
                  icon: LucideIcons.messageSquare,
                  title: 'Chat NIRA',
                  subtitle: 'Converse de forma anônima',
                  color: _kBrandPrimary,
                  onTap: () =>
                      GoRouter.of(context).go('/chat', extra: {'start': true}),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionCard(
                  icon: LucideIcons.bookOpen,
                  title: 'Conteúdos',
                  subtitle: 'Guias e orientações',
                  color: const Color(0xFF38B2AC),
                  onTap: () => GoRouter.of(context).go('/conteudos'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Como Funciona + Sobre
          Row(
            children: [
              Expanded(
                child: _ActionCard(
                  icon: LucideIcons.helpCircle,
                  title: 'Como Funciona',
                  subtitle: 'Entenda a plataforma',
                  color: const Color(0xFFED8936),
                  onTap: () => GoRouter.of(context).go('/como'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionCard(
                  icon: LucideIcons.users,
                  title: 'Sobre a NIRA',
                  subtitle: 'Nossa missão e equipe',
                  color: const Color(0xFF48BB78),
                  onTap: () => GoRouter.of(context).go('/sobre'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── DORES ──────────────────────────────────────────────────────────────────
  // Removed: _buildDores (section removed per redesign)

  // ── PARA QUEM ──────────────────────────────────────────────────────────────
  // Removed: _buildParaQuem (section removed per redesign)

  // Removed: _buildCheckItem (no longer used)
}

// ══════════════════════════════════════════════════════════════════════════════
// _ActionCard — cartão grande e tappável com efeito de pulso no SOS
// ══════════════════════════════════════════════════════════════════════════════
class _ActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final bool isPrimary;
  final bool isPulsing;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.isPrimary = false,
    this.isPulsing = false,
  });

  @override
  State<_ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<_ActionCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _pulseAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _pulse, curve: Curves.easeOut));
    if (widget.isPulsing) _pulse.repeat();
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: widget.color.withValues(alpha: 0.18),
        highlightColor: widget.color.withValues(alpha: 0.08),
        child: AnimatedBuilder(
          animation: _pulseAnim,
          builder: (_, __) => Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: widget.isPrimary ? 18 : 14,
            ),
            decoration: BoxDecoration(
              color: widget.isPrimary
                  ? widget.color.withValues(alpha: 0.10)
                  : _kBgSecondary,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.isPrimary
                    ? widget.color.withValues(alpha: 0.40)
                    : _kBorder,
              ),
              boxShadow: widget.isPulsing
                  ? [
                      BoxShadow(
                        color: widget.color.withValues(
                          alpha: 0.28 * (1.0 - _pulseAnim.value),
                        ),
                        blurRadius: 16 + (24 * _pulseAnim.value),
                        spreadRadius: 3 * _pulseAnim.value,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                // Ícone com fundo colorido
                Container(
                  padding: EdgeInsets.all(widget.isPrimary ? 12 : 10),
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.color,
                    size: widget.isPrimary ? 22 : 18,
                  ),
                ),
                const SizedBox(width: 14),
                // Textos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.isPrimary ? 15 : 13,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          color: widget.isPrimary
                              ? widget.color.withValues(alpha: 0.85)
                              : _kTextMuted,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
                // Seta
                Icon(
                  LucideIcons.arrowRight,
                  color: widget.isPrimary
                      ? widget.color.withValues(alpha: 0.8)
                      : _kBorder,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Helpers
// ══════════════════════════════════════════════════════════════════════════════
class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _opacity = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (_, __) => Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: widget.color.withValues(alpha: _opacity.value),
          borderRadius: BorderRadius.circular(3),
          boxShadow: [
            BoxShadow(
              color: widget.color.withValues(alpha: 0.6 * _opacity.value),
              blurRadius: 6,
            ),
          ],
        ),
      ),
    );
  }
}

// _CardHeader removed — sections simplified on HomeScreen
