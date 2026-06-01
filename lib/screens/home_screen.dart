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
  // Orb — pulso suave (escala 1.0 ↔ 1.04, 4 s)
  late final AnimationController _orbCtrl;
  late final Animation<double> _orbScale;

  // Anel expansivo (igual ao orbRing do CSS do site)
  late final AnimationController _ringCtrl;
  late final Animation<double> _ringScale;
  late final Animation<double> _ringOpacity;

  @override
  void initState() {
    super.initState();

    _orbCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _orbScale = Tween<double>(
      begin: 1.0,
      end: 1.04,
    ).animate(CurvedAnimation(parent: _orbCtrl, curve: Curves.easeInOut));

    _ringCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat();

    _ringScale = Tween<double>(
      begin: 1.0,
      end: 1.6,
    ).animate(CurvedAnimation(parent: _ringCtrl, curve: Curves.easeOut));
    _ringOpacity = Tween<double>(
      begin: 0.45,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _ringCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _orbCtrl.dispose();
    _ringCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBgMain,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHero(context),
            _buildActionCards(context),
            _buildDores(context),
            _buildParaQuem(context),
          ],
        ),
      ),
    );
  }

  // ── HERO ───────────────────────────────────────────────────────────────────
  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 36),
      decoration: const BoxDecoration(
        // Gradiente radial roxo sutil no canto superior direito (espelha o site)
        gradient: RadialGradient(
          center: Alignment(0.7, -1.0),
          radius: 1.5,
          colors: [Color(0x408B7EFA), Colors.transparent],
        ),
      ),
      child: Column(
        children: [
          // Badge "IA disponível 24/7" com ponto pulsante roxo
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0x208B7EFA),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: const Color(0x478B7EFA)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PulsingDot(color: _kBrandPrimary),
                const SizedBox(width: 8),
                const Text(
                  'IA DISPONÍVEL 24/7',
                  style: TextStyle(
                    color: _kBrandPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),

          // Orb animada com anel expansivo
          AnimatedBuilder(
            animation: Listenable.merge([_orbCtrl, _ringCtrl]),
            builder: (context, _) {
              return SizedBox(
                width: 180,
                height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Anel expansivo
                    Transform.scale(
                      scale: _ringScale.value,
                      child: Opacity(
                        opacity: _ringOpacity.value,
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _kBrandPrimary,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Orb principal
                    Transform.scale(
                      scale: _orbScale.value,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            center: Alignment(-0.3, -0.3),
                            colors: [
                              Color(0x668B7EFA),
                              Color(0x268B7EFA),
                              Color(0x0511111B),
                            ],
                            stops: [0.0, 0.5, 1.0],
                          ),
                          border: Border.all(
                            color: const Color(0x4D8B7EFA),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _kBrandPrimary.withValues(alpha: 0.24),
                              blurRadius: 60,
                            ),
                            BoxShadow(
                              color: _kBrandPrimary.withValues(alpha: 0.10),
                              blurRadius: 120,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'NIRA',
                            style: TextStyle(
                              color: _kBrandPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 28),

          // Título e subtítulo
          const Text(
            'Tecnologia que acolhe.',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'Um canal anônimo, seguro e disponível\nde qualquer lugar.',
            style: TextStyle(fontSize: 14, color: _kTextMuted, height: 1.65),
            textAlign: TextAlign.center,
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
  Widget _buildDores(BuildContext context) {
    final dores = [
      {
        'title': 'O SILÊNCIO',
        'desc':
            'Medo de represália, vergonha e dependência do agressor tornam o silêncio uma armadilha, não uma escolha.',
        'icon': LucideIcons.eyeOff,
      },
      {
        'title': 'FALTA DE ACESSO',
        'desc':
            'Ir a uma delegacia ou psicólogo presencialmente é impossível para quem vive sob vigilância constante.',
        'icon': LucideIcons.userX,
      },
      {
        'title': 'SEM RESPOSTA RÁPIDA',
        'desc':
            'Em momentos de agressão, ligar e falar ao telefone não é uma opção. É preciso socorro silencioso.',
        'icon': LucideIcons.clock,
      },
      {
        'title': 'AUSÊNCIA DE ACOLHIMENTO',
        'desc':
            'Antes da denúncia, existe a necessidade de ser ouvida. Sem julgamento, sem burocracia, sem se expor.',
        'icon': LucideIcons.heart,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      color: _kBgSecondary,
      child: Column(
        children: [
          const Text(
            'QUAL A DOR QUE NOS MOVE?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          const Text(
            'Criamos a Nira para ser a voz de quem precisa de proteção imediata e anônima.',
            style: TextStyle(fontSize: 13, color: _kTextMuted, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ...dores.map(
            (d) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: NiraGlassCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _kBrandPrimary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        d['icon'] as IconData,
                        color: _kBrandPrimary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            d['desc'] as String,
                            style: const TextStyle(
                              color: _kTextMuted,
                              fontSize: 12,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── PARA QUEM ──────────────────────────────────────────────────────────────
  Widget _buildParaQuem(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'Para quem é a Nira?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          NiraGlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CardHeader(
                  icon: LucideIcons.shield,
                  label: 'USUÁRIOS FINAIS',
                  color: const Color(0xFF48BB78),
                ),
                const SizedBox(height: 14),
                _buildCheckItem(
                  'Pessoas em situação de violência ou risco.',
                  const Color(0xFF48BB78),
                ),
                _buildCheckItem(
                  'Indivíduos em vulnerabilidade social e emocional.',
                  const Color(0xFF48BB78),
                ),
                _buildCheckItem(
                  'Quem precisa de ajuda mas teme se expor.',
                  const Color(0xFF48BB78),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          NiraGlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CardHeader(
                  icon: LucideIcons.heartHandshake,
                  label: 'GESTORES E PARCEIROS',
                  color: _kBrandPrimary,
                ),
                const SizedBox(height: 14),
                _buildCheckItem(
                  'Psicólogos e assistentes sociais.',
                  _kBrandPrimary,
                ),
                _buildCheckItem('ONGs e centros de apoio.', _kBrandPrimary),
                _buildCheckItem(
                  'Autoridades e agentes de segurança.',
                  _kBrandPrimary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LucideIcons.checkCircle2, color: color, size: 15),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: _kTextMuted, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
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

class _CardHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _CardHeader({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
