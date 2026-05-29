import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../widgets/nira_glass_card.dart';

class ComoFuncionaScreen extends StatelessWidget {
  const ComoFuncionaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Validação de responsividade nativa e segura
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      backgroundColor: const Color(0xFF07070B),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHero(context, isMobile),
            _buildPilares(context, isMobile),
            _buildJornada(context, isMobile),
            _buildTechDivider(context, isMobile),
            _buildFaqShortcut(context, isMobile),
            _buildFinalCta(context, isMobile),
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
            Colors.blueAccent.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.blueAccent.withValues(alpha: 0.2),
              ),
            ),
            child: const Text(
              'ARQUITETURA DE PROTEÇÃO',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Simples por fora.\nPoderoso por dentro.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 40 : 80,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'O ecossistema Nira combina um chatbot acolhedor com uma rede de especialistas humanos para criar uma ponte segura entre a dor e a proteção.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white70, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildPilares(BuildContext context, bool isMobile) {
    final pilares = [
      {
        'icon': LucideIcons.shield,
        'title': 'Privacidade Radical',
        'desc':
            'Sua identidade é protegida por criptografia e protocolos de anonimato total.',
        'color': Colors.blueAccent,
      },
      {
        'icon': LucideIcons.zap,
        'title': 'Velocidade Crítica',
        'desc':
            'Segundos salvam vidas. Nossa resposta é instantânea e automatizada.',
        'color': Colors.redAccent,
      },
      {
        'icon': LucideIcons.users,
        'title': 'Rede Humana',
        'desc':
            'A tecnologia é a ponte, mas o destino final é sempre o acolhimento humano.',
        'color': Colors.greenAccent,
      },
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      decoration: const BoxDecoration(
        color: Color(0xFF11111A),
        border: Border.symmetric(horizontal: BorderSide(color: Colors.white10)),
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        children: pilares
            .map(
              (p) => Expanded(
                flex: isMobile ? 0 : 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: isMobile ? 32 : 0,
                    right: isMobile ? 0 : 32,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          p['icon'] as IconData,
                          color: p['color'] as Color,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        p['title'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        p['desc'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildJornada(BuildContext context, bool isMobile) {
    final stages = [
      {
        'id': '01',
        'title': 'Silêncio e Segurança',
        'subtitle': 'O Primeiro Contato',
        'desc':
            'O acesso à Nira é totalmente anônimo. Não pedimos CPF, nome ou telefone. Um botão de "Saída Rápida" está sempre visível.',
        'icon': LucideIcons.eyeOff,
        'color': Colors.blueAccent,
        'features': ['Zero Logs de IP', 'Sem Cadastro Prévio', 'Modo Furtivo'],
      },
      {
        'id': '02',
        'title': 'Triagem Humanizada',
        'subtitle': 'Escuta Ativa Digital',
        'desc':
            'Nosso chatbot acolhedor realiza uma triagem estruturada identificando o nível de risco e tipo de abuso, preparando terreno para suporte.',
        'icon': LucideIcons.messageSquare,
        'color': Colors.purpleAccent,
        'features': [
          'Linguagem Acolhedora',
          'Protocolo Científico',
          'Triagem Automática',
        ],
      },
      {
        'id': '03',
        'title': 'Resposta Imediata',
        'subtitle': 'Ação em Tempo Real',
        'desc':
            'Se o risco for alto, sua localização vai para equipes de pronta resposta. Senão, conectamos você a uma especialista no chat.',
        'icon': LucideIcons.zap,
        'color': Colors.redAccent,
        'features': [
          'Alerta Silencioso',
          'Geolocalização Ativa',
          'Conexão Especializada',
        ],
      },
      {
        'id': '04',
        'title': 'Cuidado Contínuo',
        'subtitle': 'A Rede de Apoio',
        'desc':
            'O suporte não termina no chat. Mapeamos e encaminhamos você para ONGs, delegacias e abrigos da rede física.',
        'icon': LucideIcons.heartHandshake,
        'color': Colors.greenAccent,
        'features': [
          'Mapeamento de ONGs',
          'Encaminhamento VIP',
          'Apoio Constante',
        ],
      },
    ];

    Widget buildStage(Map<String, dynamic> stage) {
      return NiraGlassCard(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: (stage['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    stage['icon'] as IconData,
                    color: stage['color'] as Color,
                    size: 32,
                  ),
                ),
                Text(
                  stage['id'] as String,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.white12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              stage['subtitle'] as String,
              style: TextStyle(
                color: stage['color'] as Color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              stage['title'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              stage['desc'] as String,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white10),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: (stage['features'] as List<String>).map((feat) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.checkCircle2,
                      size: 14,
                      color: stage['color'] as Color,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      feat,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A Jornada do Acolhimento',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Container(
            height: 6,
            width: 120,
            margin: const EdgeInsets.only(top: 16, bottom: 48),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          if (isMobile)
            Column(
              children: [
                buildStage(stages[0]),
                const SizedBox(height: 24),
                buildStage(stages[1]),
                const SizedBox(height: 24),
                buildStage(stages[2]),
                const SizedBox(height: 24),
                buildStage(stages[3]),
              ],
            )
          else
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: buildStage(stages[0])),
                    const SizedBox(width: 32),
                    Expanded(child: buildStage(stages[1])),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: buildStage(stages[2])),
                    const SizedBox(width: 32),
                    Expanded(child: buildStage(stages[3])),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildTechDivider(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.blueAccent.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF181825),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white10),
            ),
            child: const Text(
              'Chatbot + Especialistas = Proteção de Ponta a Ponta',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Por que usamos um Chatbot?',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Text(
            'O chatbot não substitui o humano, ele o escala. Em casos de abuso, a vítima muitas vezes sente vergonha ou medo de ser julgada. O sistema oferece um espaço de desabafo imediato, 24/7, que prepara a vítima emocionalmente para o contato com a psicóloga humana, filtrando urgências e salvando vidas.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 18, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqShortcut(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      child: NiraGlassCard(
        padding: EdgeInsets.all(isMobile ? 32 : 64),
        child: Column(
          children: [
            const Icon(LucideIcons.helpCircle, size: 64, color: Colors.white24),
            const SizedBox(height: 24),
            Text(
              'Ainda tem dúvidas?',
              style: TextStyle(
                fontSize: isMobile ? 28 : 40,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nossa central de ajuda e perguntas frequentes está sempre atualizada com as diretrizes das principais ONGs de proteção.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => context.go('/sobre'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white24),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                  ),
                  child: const Text('Conhecer a Equipe'),
                ),
                ElevatedButton.icon(
                  onPressed: () => context.go('/'),
                  icon: const Icon(LucideIcons.arrowRight),
                  label: const Text('Voltar ao Início'),
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

  Widget _buildFinalCta(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 32 : 64),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
          ),
          borderRadius: BorderRadius.circular(48),
        ),
        child: Column(
          children: [
            const Icon(LucideIcons.bellRing, size: 64, color: Colors.white),
            const SizedBox(height: 24),
            Text(
              'Não espere o pior acontecer.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 32 : 56,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Dê o primeiro passo rumo à sua segurança hoje. É rápido, é anônimo e é o começo da sua nova história.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.go('/chat'),
              icon: const Icon(LucideIcons.lock),
              label: const Text('INICIAR TRIAGEM AGORA'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 24,
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
