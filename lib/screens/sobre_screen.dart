import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../widgets/nira_glass_card.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Validação de responsividade nativa para evitar quebras em web/mobile
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      backgroundColor: const Color(0xFF07070B),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHero(context, isMobile),
            _buildManifesto(context, isMobile),
            _buildProblema(context, isMobile),
            _buildEquipe(context, isMobile),
            _buildCta(context, isMobile),
          ],
        ),
      ),
    );
  }

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
            Colors.purpleAccent.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    'E.Y.E — Ethical Youth Engineers · SESI-SENAI 2026',
                    style: TextStyle(
                      color: Colors.white70,
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
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.6,
                  ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                ),
                const SizedBox(height: 48),
                Wrap(
                  spacing: 32,
                  runSpacing: 24,
                  alignment: isMobile
                      ? WrapAlignment.center
                      : WrapAlignment.start,
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
          Expanded(flex: isMobile ? 0 : 1, child: _buildChatPreview(isMobile)),
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
            color: Colors.white54,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildChatPreview(bool isMobile) {
    return NiraGlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              border: const Border(bottom: BorderSide(color: Colors.white10)),
            ),
            child: const Row(
              children: [
                CircleAvatar(radius: 5, backgroundColor: Colors.redAccent),
                SizedBox(width: 8),
                CircleAvatar(radius: 5, backgroundColor: Colors.amber),
                SizedBox(width: 8),
                CircleAvatar(radius: 5, backgroundColor: Colors.green),
                SizedBox(width: 16),
                Text(
                  'Painel Nira — Chat de Triagem',
                  style: TextStyle(color: Colors.white38, fontSize: 12),
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
          const CircleAvatar(
            radius: 14,
            backgroundColor: Colors.blueAccent,
            child: Icon(LucideIcons.shield, size: 14, color: Colors.white),
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
                    ? Colors.blueAccent.withValues(alpha: 0.3)
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
          const CircleAvatar(
            radius: 14,
            backgroundColor: Colors.purpleAccent,
            child: Icon(LucideIcons.user, size: 14, color: Colors.white),
          ),
        ],
      ],
    );
  }

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
      color: const Color(0xFF11111A),
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
                    color: Colors.blueAccent,
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
                  style: TextStyle(color: Colors.white54),
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
                            Icon(
                              v['icon'] as IconData,
                              color: Colors.blueAccent,
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
                                      color: Colors.white70,
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

  Widget _buildProblema(BuildContext context, bool isMobile) {
    final stats = [
      {
        'num': '1 em 4',
        'label':
            'casos de violência doméstica é formalmente denunciado no Brasil',
        'src': 'FBSP 2023',
        'color': Colors.redAccent,
      },
      {
        'num': '4 min',
        'label':
            'é o intervalo médio entre casos de violência doméstica registrados',
        'src': 'FBSP 2023',
        'color': Colors.amber,
      },
      {
        'num': '70%',
        'label':
            'das vítimas de feminicídio nunca haviam feito um registro policial',
        'src': 'IPEA 2023',
        'color': Colors.purpleAccent,
      },
      {
        'num': '16M',
        'label':
            'de mulheres no Brasil já sofreram violência doméstica, segundo IBGE',
        'src': 'IBGE 2024',
        'color': Colors.greenAccent,
      },
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      child: Column(
        children: [
          const Text(
            'O Problema',
            style: TextStyle(
              color: Colors.blueAccent,
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
            style: TextStyle(color: Colors.white70, fontSize: 16),
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
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Fonte: ${s['src']}',
                            style: const TextStyle(
                              color: Colors.white38,
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

  Widget _buildEquipe(BuildContext context, bool isMobile) {
    final equipe = [
      {
        'nome': 'Giovanna',
        'papel': 'UX / Design',
        'icon': LucideIcons.paintbrush,
      },
      {'nome': 'Samuel', 'papel': 'Backend / PHP', 'icon': LucideIcons.code2},
      {
        'nome': 'Kauã',
        'papel': 'Frontend / React',
        'icon': LucideIcons.monitorPlay,
      },
      {'nome': 'Pietro', 'papel': 'Full Stack', 'icon': LucideIcons.wrench},
      {
        'nome': 'Lucas',
        'papel': 'QA / Docs',
        'icon': LucideIcons.clipboardCheck,
      },
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      color: const Color(0xFF11111A),
      child: Column(
        children: [
          const Text(
            'Time',
            style: TextStyle(
              color: Colors.blueAccent,
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
            style: TextStyle(color: Colors.white70, fontSize: 16),
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
                          Icon(
                            e['icon'] as IconData,
                            size: 40,
                            color: Colors.blueAccent,
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
                              color: Colors.blueAccent,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'SESI-SENAI · 2026',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
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

  Widget _buildCta(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      child: NiraGlassCard(
        padding: EdgeInsets.all(isMobile ? 32 : 64),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.greenAccent.withValues(alpha: 0.2),
                ),
              ),
              child: const Text(
                'PRONTO PARA COMEÇAR?',
                style: TextStyle(
                  color: Colors.greenAccent,
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
                    side: const BorderSide(color: Colors.white24),
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
                    backgroundColor: Colors.blueAccent,
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
