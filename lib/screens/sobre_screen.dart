import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../widgets/nira_glass_card.dart';

// ── Paleta de marca ────────────────────────────────────────────────────────
const _kBrandPrimary = Color(0xFF8B7EFA);
const _kBgMain       = Color(0xFF11111B);
const _kBgSecondary  = Color(0xFF1E1E2E);
const _kBorder       = Color(0xFF2B2B3C);
const _kTextMuted    = Color(0xFFA6A6B0);

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      backgroundColor: _kBgMain,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHero(context, isMobile),
            _buildManifesto(context, isMobile),
            _buildProblema(context, isMobile),
            _buildEquipe(context, isMobile),
            _buildFaq(context, isMobile),   // ← FAQ movido da HomeScreen
            _buildCta(context, isMobile),
          ],
        ),
      ),
    );
  }

  // ── HERO ───────────────────────────────────────────────────────────────────
  Widget _buildHero(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: isMobile ? 64 : 120,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _kBrandPrimary.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: _kBrandPrimary.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    'E.Y.E — Ethical Youth Engineers · SESI-SENAI 2026',
                    style: TextStyle(
                      color: _kTextMuted,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Construindo o\nporto seguro\nque o Brasil precisa.',
                  style: TextStyle(
                    fontSize: isMobile ? 40 : 64,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.1,
                  ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                ),
                const SizedBox(height: 24),
                Text(
                  'Somos cinco estudantes que transformaram indignação em código. A NIRA nasceu da crença de que tecnologia pode ser o primeiro passo para pedir socorro — anônimo, silencioso e imediato.',
                  style: const TextStyle(
                    fontSize: 16,
                    color: _kTextMuted,
                    height: 1.6,
                  ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                ),
                const SizedBox(height: 48),
                Wrap(
                  spacing: 32,
                  runSpacing: 24,
                  alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                  children: [
                    _buildMetric('5', 'Devs no time'),
                    _buildMetric('9', 'Páginas'),
                    _buildMetric('0', 'Dados coletados'),
                    _buildMetric('100%', 'Anônimo'),
                  ],
                ),
              ],
            ),
          ),
          if (!isMobile) const SizedBox(width: 80),
          if (isMobile) const SizedBox(height: 64),
          Expanded(flex: isMobile ? 0 : 1, child: _buildChatPreview()),
        ],
      ),
    );
  }

  Widget _buildMetric(String num, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          num,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: _kTextMuted,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildChatPreview() {
    return NiraGlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0x0CFFFFFF),
              border: Border(bottom: BorderSide(color: _kBorder)),
            ),
            child: const Row(
              children: [
                CircleAvatar(radius: 5, backgroundColor: Color(0xFFE53E3E)),
                SizedBox(width: 8),
                CircleAvatar(radius: 5, backgroundColor: Colors.amber),
                SizedBox(width: 8),
                CircleAvatar(radius: 5, backgroundColor: Colors.green),
                SizedBox(width: 16),
                Text(
                  'Painel Nira — Chat de Triagem',
                  style: TextStyle(color: Color(0x61FFFFFF), fontSize: 12),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildChatBubble(
                  'Olá. Estou aqui por você. Este espaço é 100% anônimo e seguro.',
                  isIa: true,
                ),
                const SizedBox(height: 16),
                _buildChatBubble(
                  'Preciso de ajuda, mas tenho receio de me expor agora.',
                  isIa: false,
                ),
                const SizedBox(height: 16),
                _buildChatBubble(
                  'Aqui não há rastros. Nós garantimos o total sigilo. O que está acontecendo?',
                  isIa: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, {required bool isIa}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isIa ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (isIa) ...[
          CircleAvatar(
            radius: 14,
            backgroundColor: _kBrandPrimary,
            child: const Icon(LucideIcons.shield, size: 14, color: Colors.white),
          ),
          const SizedBox(width: 12),
        ],
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isIa
                  ? const Color(0xFF2D2B4E).withValues(alpha: 0.75)
                  : Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isIa ? 0 : 16),
                bottomRight: Radius.circular(isIa ? 16 : 0),
              ),
              border: Border.all(
                color: isIa
                    ? _kBrandPrimary.withValues(alpha: 0.3)
                    : Colors.white24,
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ),
        if (!isIa) ...[
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 14,
            backgroundColor: _kBrandPrimary.withValues(alpha: 0.5),
            child: const Icon(LucideIcons.user, size: 14, color: Colors.white),
          ),
        ],
      ],
    );
  }

  // ── MANIFESTO ──────────────────────────────────────────────────────────────
  Widget _buildManifesto(BuildContext context, bool isMobile) {
    final valores = [
      {
        'icon': LucideIcons.lock,
        'titulo': 'Anonimato por padrão',
        'texto':
            'O anonimato não é uma feature — é o princípio central. Nenhuma decisão de produto pode comprometer a segurança de quem usa.',
      },
      {
        'icon': LucideIcons.heartHandshake,
        'titulo': 'Acolhimento antes de tudo',
        'texto':
            'Antes da triagem, antes da denúncia — existe a necessidade de ser ouvida sem julgamento. Tecnologia que abraça.',
      },
      {
        'icon': LucideIcons.zap,
        'titulo': 'Código que salva vidas',
        'texto':
            'Cada linha existe para reduzir uma barreira real. Não construímos tecnologia por tecnologia — construímos impacto mensurável.',
      },
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      color: _kBgSecondary,
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nosso Manifesto',
                  style: TextStyle(
                    color: _kBrandPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '"Violência não começa com um soco. Começa com o silêncio forçado, o medo de pedir ajuda, a barreira invisível entre a vítima e o socorro.\n\nA NIRA existe para destruir essa barreira."',
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  '— Equipe E.Y.E, SESI-SENAI 2026',
                  style: TextStyle(color: _kTextMuted),
                ),
              ],
            ),
          ),
          if (!isMobile) const SizedBox(width: 80),
          if (isMobile) const SizedBox(height: 64),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              children: valores
                  .map(
                    (v) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: NiraGlassCard(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: _kBrandPrimary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                v['icon'] as IconData,
                                color: _kBrandPrimary,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    v['titulo'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    v['texto'] as String,
                                    style: const TextStyle(
                                      color: _kTextMuted,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ── O PROBLEMA ─────────────────────────────────────────────────────────────
  Widget _buildProblema(BuildContext context, bool isMobile) {
    final stats = [
      {
        'num': '1 em 4',
        'label': 'casos de violência doméstica é formalmente denunciado no Brasil',
        'src': 'FBSP 2023',
        'color': const Color(0xFFE53E3E),
      },
      {
        'num': '4 min',
        'label': 'é o intervalo médio entre casos de violência doméstica registrados',
        'src': 'FBSP 2023',
        'color': Colors.amber,
      },
      {
        'num': '70%',
        'label': 'das vítimas de feminicídio nunca haviam feito um registro policial',
        'src': 'IPEA 2023',
        'color': _kBrandPrimary,
      },
      {
        'num': '16M',
        'label': 'de mulheres no Brasil já sofreram violência doméstica, segundo IBGE',
        'src': 'IBGE 2024',
        'color': const Color(0xFF48BB78),
      },
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      child: Column(
        children: [
          const Text(
            'O Problema',
            style: TextStyle(
              color: _kBrandPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Números que nos movem',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'A realidade que motivou cada linha de código da NIRA.',
            style: TextStyle(color: _kTextMuted, fontSize: 16),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: stats
                .map(
                  (s) => SizedBox(
                    width: isMobile ? double.infinity : 280,
                    child: NiraGlassCard(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s['num'] as String,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              color: s['color'] as Color,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            s['label'] as String,
                            style: const TextStyle(
                              color: _kTextMuted,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Fonte: ${s['src']}',
                            style: const TextStyle(
                              color: Color(0x61FFFFFF),
                              fontSize: 10,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  // ── EQUIPE ─────────────────────────────────────────────────────────────────
  Widget _buildEquipe(BuildContext context, bool isMobile) {
    final equipe = [
      {'nome': 'Giovanna', 'papel': 'UX / Design',        'icon': LucideIcons.paintbrush},
      {'nome': 'Samuel',   'papel': 'Backend / PHP',      'icon': LucideIcons.code2},
      {'nome': 'Kauã',     'papel': 'Frontend / React',   'icon': LucideIcons.monitorPlay},
      {'nome': 'Pietro',   'papel': 'Full Stack',         'icon': LucideIcons.wrench},
      {'nome': 'Lucas',    'papel': 'QA / Docs',          'icon': LucideIcons.clipboardCheck},
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      color: _kBgSecondary,
      child: Column(
        children: [
          const Text(
            'Time',
            style: TextStyle(
              color: _kBrandPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Quem constrói a NIRA',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Cinco estudantes do SESI-SENAI que decidiram que tecnologia pode ser uma ferramenta de proteção.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _kTextMuted, fontSize: 16),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: equipe
                .map(
                  (e) => SizedBox(
                    width: isMobile
                        ? (MediaQuery.sizeOf(context).width - 72) / 2
                        : 200,
                    child: NiraGlassCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _kBrandPrimary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              e['icon'] as IconData,
                              size: 28,
                              color: _kBrandPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            e['nome'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            e['papel'] as String,
                            style: const TextStyle(
                              color: _kBrandPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'SESI-SENAI · 2026',
                            style: TextStyle(color: Color(0x61FFFFFF), fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  // ── FAQ (movido da HomeScreen) ─────────────────────────────────────────────
  Widget _buildFaq(BuildContext context, bool isMobile) {
    final faq = [
      {
        'q': 'A Nira é realmente anônima? Meus dados ficam salvos?',
        'a': 'Sim. A Nira foi desenhada com anonimato desde o início. Nenhum dado pessoal como nome, CPF ou telefone é solicitado.',
      },
      {
        'q': 'E se o meu agressor pegar meu celular e ver o app?',
        'a': 'A Nira possui um botão de saída rápida que fecha o aplicativo instantaneamente. Recomendamos ativar o modo furtivo.',
      },
      {
        'q': 'Como funciona o botão S.O.S.?',
        'a': 'Com um único toque, o S.O.S. envia sua localização em tempo real para a equipe Nira. Não é necessário digitar nada.',
      },
      {
        'q': 'Preciso criar uma conta para usar?',
        'a': 'Não. A Nira não exige cadastro. Você acessa o chat e o S.O.S. diretamente, sem criar perfil ou fornecer e-mail.',
      },
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Dúvidas Frequentes',
            style: TextStyle(
              color: _kBrandPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Perguntas comuns',
            style: TextStyle(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: faq.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = faq[index];
              return NiraGlassCard(
                padding: EdgeInsets.zero,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    iconColor: _kBrandPrimary,
                    collapsedIconColor: _kTextMuted,
                    title: Text(
                      item['q']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(
                          item['a']!,
                          style: const TextStyle(
                            color: _kTextMuted,
                            height: 1.6,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ── CTA FINAL ──────────────────────────────────────────────────────────────
  Widget _buildCta(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      child: NiraGlassCard(
        padding: EdgeInsets.all(isMobile ? 32 : 64),
        glowPrimary: true,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF48BB78).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: const Color(0xFF48BB78).withValues(alpha: 0.2),
                ),
              ),
              child: const Text(
                'PRONTO PARA COMEÇAR?',
                style: TextStyle(
                  color: Color(0xFF48BB78),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Você não está só',
              style: TextStyle(
                fontSize: isMobile ? 32 : 48,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => context.go('/conteudos'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: _kBorder),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                  ),
                  child: const Text('Ver conteúdos'),
                ),
                ElevatedButton.icon(
                  onPressed: () => context.go('/chat'),
                  icon: const Icon(LucideIcons.lock),
                  label: const Text('INICIAR TRIAGEM AGORA'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kBrandPrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
