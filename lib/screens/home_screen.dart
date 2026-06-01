import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../widgets/nira_app_bar.dart';

// ── Paleta de marca (alinhada com o site React) ────────────────────────────
const _kBrandPrimary = Color(0xFF8B7EFA);
const _kBgMain = Color(0xFF11111B); // Fundo bem escuro
const _kBgSecondary = Color(0xFF1E1E2E);
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
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _kBgMain,
      appBar: const NiraAppBar(),
      body: Stack(
        children: [
          // 1. O GLOW ROXO DE FUNDO
          Positioned(
            top: -screenSize.height * 0.05,
            left: 0,
            right: 0,
            child: Container(
              height: screenSize.height * 0.7,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.0, -0.2),
                  radius: 0.8,
                  colors: [
                    _kBrandPrimary.withValues(alpha: 0.35), // Roxo neon difuso
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 2. A IMAGEM DO PERSONAGEM (image_e1d73f.png) - Responsiva
          Positioned(
            top: screenSize.height * 0.08, // Começa um pouco abaixo do navbar
            left: -screenSize.width * 0.15, // Sai um pouco da esquerda
            right: -screenSize.width * 0.15, // Sai um pouco da direita
            bottom: -screenSize.height * 0.1, // Desce além da bottom nav
            child: Opacity(
              opacity: 0.95,
              child: Image.asset(
                'assets/images/home-img.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),

          // 3. GRADIENTE DE FUSÃO (Apaga a base da foto e prepara o fundo para os botões)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    _kBgMain.withValues(alpha: 0.5),
                    _kBgMain,
                    _kBgMain, // Cor sólida total na parte inferior
                  ],
                  stops: const [0.35, 0.55, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // 4. INTERFACE DO USUÁRIO (Na frente de tudo)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  _buildHeroTitle(), // Novo título baseado no React

                  const Spacer(), // Empurra os cards para baixo

                  _buildActionCards(context),
                  const SizedBox(height: 16), // Espaçamento na base
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── TEXTOS DO HERO (Alinhado com a versão Web) ───────────────────────────
  Widget _buildHeroTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'PROTEÇÃO • ACOLHIMENTO • ANONIMATO',
          style: TextStyle(
            color: _kBrandPrimary.withValues(alpha: 0.9),
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Porto seguro\ndigital',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w900,
            height: 1.1,
            letterSpacing: -1,
          ),
        ),
      ],
    );
  }

  // ── ACTION CARDS ───────────────────────────────────────────────────────────
  Widget _buildActionCards(BuildContext context) {
    return Column(
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
        const SizedBox(height: 12),

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
            const SizedBox(width: 12),
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
        const SizedBox(height: 12),

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
            const SizedBox(width: 12),
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
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// _ActionCard — Com efeito Glassmorphism suave
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
          builder: (_, _) => Container(
            padding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: widget.isPrimary ? 18 : 14,
            ),
            decoration: BoxDecoration(
              // Aplicação do Glassmorphism (fundos translúcidos)
              color: widget.isPrimary
                  ? widget.color.withValues(alpha: 0.12)
                  : _kBgSecondary.withValues(
                      alpha: 0.5,
                    ), // Fundo mais transparente
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.isPrimary
                    ? widget.color.withValues(alpha: 0.40)
                    : Colors.white.withValues(
                        alpha: 0.05,
                      ), // Borda fina e reflexiva
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
                const SizedBox(width: 12),
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
                          fontSize: widget.isPrimary ? 16 : 13,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: widget.isPrimary
                              ? widget.color.withValues(alpha: 0.85)
                              : _kTextMuted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                // Seta removida dos cards menores para ficar mais limpo
                if (widget.isPrimary)
                  Icon(
                    LucideIcons.arrowRight,
                    color: widget.color.withValues(alpha: 0.8),
                    size: 18,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
