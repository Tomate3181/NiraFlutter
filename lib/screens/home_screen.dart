import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:fl_chart/fl_chart.dart';

import '../widgets/nira_glass_card.dart';
import '../services/nira_supabase_service.dart';
import '../models/nira_models.dart';
import 'package:go_router/go_router.dart';

// Provider temporário para ouvir a stream de alertas (Dashboard)
final alertasStreamProvider = StreamProvider.autoDispose<List<Alert>>((ref) {
  final supabaseService = ref.watch(niraSupabaseProvider);
  return supabaseService.escutarAlertasSOS();
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Validação de responsividade robusta para evitar quebras em mobile
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      backgroundColor: const Color(0xFF07070B), // Fundo extremamente escuro
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHero(context, isMobile),
            _buildLiveDashboard(context, ref, isMobile),
            _buildDores(context, isMobile),
            _buildParaQuem(context, isMobile),
            _buildFaq(context, isMobile),
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
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            'NIRA',
            style: TextStyle(
              fontSize: isMobile ? 48 : 80,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 8,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Tecnologia para ouvir, acolher e proteger quem mais precisa.\nUm canal anônimo, seguro e disponível de qualquer lugar.',
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              fontSize: isMobile ? 18 : 24,
              fontWeight: FontWeight.w300,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () => GoRouter.of(
                  context,
                ).go('/chat', extra: {'sos': true, 'start': true}),
                icon: const Icon(LucideIcons.alertTriangle),
                label: const Text('ACIONAR S.O.S AGORA'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => context.go('/como'),
                icon: const Icon(LucideIcons.bookOpen),
                label: const Text('COMO FUNCIONA'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white24),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiveDashboard(
    BuildContext context,
    WidgetRef ref,
    bool isMobile,
  ) {
    final alertasAsync = ref.watch(alertasStreamProvider);

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Monitoramento em Tempo Real',
            style: TextStyle(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Visualização administrativa integrada ao fluxo de Streams do Supabase.',
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
          const SizedBox(height: 32),
          alertasAsync.when(
            data: (alertas) => isMobile
                ? Column(
                    children: [
                      _buildMapCard(alertas),
                      const SizedBox(height: 24),
                      _buildChartCard(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _buildMapCard(alertas)),
                      const SizedBox(width: 32),
                      Expanded(flex: 2, child: _buildChartCard()),
                    ],
                  ),
            loading: () => const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            ),
            error: (err, stack) => Text(
              'Erro ao carregar dados: $err',
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapCard(List<Alert> alertas) {
    return NiraGlassCard(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(LucideIcons.map, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  'Casos Ativos (${alertas.length})',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(-23.5505, -46.6333),
                    initialZoom: 10.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.nira.app',
                    ),
                    MarkerLayer(
                      markers: alertas
                          .map(
                            (a) => Marker(
                              point: LatLng(a.latitude ?? 0, a.longitude ?? 0),
                              width: 40,
                              height: 40,
                              child: const Icon(
                                LucideIcons.alertTriangle,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard() {
    return NiraGlassCard(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(LucideIcons.barChart3, color: Colors.purpleAccent),
                SizedBox(width: 8),
                Text(
                  'Projeção Diária',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTitlesWidget: (value, meta) {
                          final hours = {
                            0: '00h',
                            8: '08h',
                            16: '16h',
                            24: '24h',
                          };
                          if (hours.containsKey(value.toInt())) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                hours[value.toInt()]!,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 12),
                        FlSpot(4, 5),
                        FlSpot(8, 28),
                        FlSpot(12, 45),
                        FlSpot(16, 38),
                        FlSpot(20, 56),
                        FlSpot(24, 30),
                      ],
                      isCurved: true,
                      color: Colors.purpleAccent,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.purpleAccent.withValues(alpha: 0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDores(BuildContext context, bool isMobile) {
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
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      color: const Color(0xFF11111A),
      child: Column(
        children: [
          Text(
            'QUAL A DOR QUE NOS MOVE?',
            style: TextStyle(
              fontSize: isMobile ? 24 : 40,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'O silêncio é o combustível da violência. Criamos a Nira para ser a voz de quem precisa de proteção imediata e anônima.',
            style: TextStyle(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: dores.map((d) {
              return SizedBox(
                width: isMobile ? double.infinity : 280,
                child: NiraGlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          d['icon'] as IconData,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        d['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        d['desc'] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildParaQuem(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      child: Column(
        children: [
          Text(
            'Para quem é a Nira?',
            style: TextStyle(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 48),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            children: [
              Expanded(
                flex: isMobile ? 0 : 1,
                child: NiraGlassCard(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            LucideIcons.shield,
                            color: Colors.greenAccent,
                            size: 32,
                          ),
                          SizedBox(width: 16),
                          Text(
                            'USUÁRIOS FINAIS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildCheckItem(
                        'Pessoas em situação de violência ou risco.',
                      ),
                      _buildCheckItem(
                        'Indivíduos em vulnerabilidade social e emocional.',
                      ),
                      _buildCheckItem(
                        'Quem precisa de ajuda mas teme se expor.',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 24 : 0, width: isMobile ? 0 : 24),
              Expanded(
                flex: isMobile ? 0 : 1,
                child: NiraGlassCard(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            LucideIcons.heartHandshake,
                            color: Colors.blueAccent,
                            size: 32,
                          ),
                          SizedBox(width: 16),
                          Text(
                            'GESTORES E PARCEIROS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildCheckItem('Psicólogos e assistentes sociais.'),
                      _buildCheckItem('ONGs e centros de apoio.'),
                      _buildCheckItem('Autoridades e agentes de segurança.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            LucideIcons.checkCircle2,
            color: Colors.greenAccent,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaq(BuildContext context, bool isMobile) {
    final faq = [
      {
        'q': 'A Nira é realmente anônima? Meus dados ficam salvos?',
        'a':
            'Sim. A Nira foi desenhada com anonimato desde o início. Nenhum dado pessoal como nome, CPF ou telefone é solicitado.',
      },
      {
        'q': 'E se o meu agressor pegar meu celular e ver o site?',
        'a':
            'A Nira possui um botão de saída rápida que fecha o aplicativo instantaneamente. Recomendamos acessar pelo modo anônimo.',
      },
      {
        'q': 'Como funciona o botão S.O.S.?',
        'a':
            'Com um único toque, o S.O.S. envia sua localização em tempo real para a equipe Nira. Não é necessário digitar nada.',
      },
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 64),
      color: const Color(0xFF11111A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Dúvidas Comuns',
            style: TextStyle(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          ListView.separated(
            shrinkWrap: true, // Garante que a lista não quebre o layout
            physics:
                const NeverScrollableScrollPhysics(), // Evita conflito de rolagem
            itemCount: faq.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = faq[index];
              return NiraGlassCard(
                padding: EdgeInsets.zero,
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white70,
                    title: Text(
                      item['q']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          item['a']!,
                          style: const TextStyle(
                            color: Colors.white70,
                            height: 1.5,
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
}
