import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_html/flutter_html.dart';
import '../widgets/nira_glass_card.dart';
import '../services/nira_supabase_service.dart';
import '../models/nira_models.dart';

// ── Paleta de marca ────────────────────────────────────────────────────────
const _kBrandPrimary = Color(0xFF8B7EFA);
const _kBgMain = Color(0xFF11111B);
const _kBgSecondary = Color(0xFF1E1E2E);
const _kBorder = Color(0xFF2B2B3C);
const _kTextMuted = Color(0xFFA6A6B0);

// ---------------------------------------------------------
// Providers Locais (Gerência de Estado do Blog/Conteúdos)
// ---------------------------------------------------------
final categoriaAtualProvider = StateProvider<String>((ref) => 'Todos');
final buscaArtigoProvider = StateProvider<String>((ref) => '');
final artigoAtivoProvider = StateProvider<Article?>((ref) => null);

final artigosFutureProvider = FutureProvider.autoDispose<List<Article>>((ref) {
  final service = ref.watch(niraSupabaseProvider);
  return service.buscarArtigos();
});

class ConteudosScreen extends ConsumerWidget {
  const ConteudosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 800;

    final artigosAsync = ref.watch(artigosFutureProvider);
    final categoriaAtual = ref.watch(categoriaAtualProvider);
    final busca = ref.watch(buscaArtigoProvider);
    final artigoAtivo = ref.watch(artigoAtivoProvider);

    return Scaffold(
      backgroundColor: _kBgMain,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHero(context, ref, isMobile, categoriaAtual, busca),
                artigosAsync.when(
                  data: (artigos) {
                    final filtrados = artigos.where((a) {
                      final matchCat =
                          categoriaAtual == 'Todos' ||
                          a.category == categoriaAtual;
                      final matchBusca =
                          busca.isEmpty ||
                          a.title.toLowerCase().contains(busca.toLowerCase()) ||
                          (a.description?.toLowerCase().contains(
                                busca.toLowerCase(),
                              ) ??
                              false);
                      return matchCat && matchBusca;
                    }).toList();

                    final destaque =
                        artigos.where((a) => a.featured).firstOrNull ??
                        artigos.firstOrNull;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (destaque != null &&
                            busca.isEmpty &&
                            categoriaAtual == 'Todos')
                          _buildDestaque(context, ref, isMobile, destaque),
                        _buildListagem(
                          context,
                          ref,
                          isMobile,
                          filtrados,
                          busca,
                        ),
                      ],
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.all(100.0),
                    child: Center(
                      child: CircularProgressIndicator(color: _kBrandPrimary),
                    ),
                  ),
                  error: (err, stack) => Padding(
                    padding: const EdgeInsets.all(64.0),
                    child: Text(
                      'Erro ao carregar artigos: $err',
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (artigoAtivo != null)
            _buildModalArtigo(context, ref, isMobile, artigoAtivo),
        ],
      ),
    );
  }

  Widget _buildHero(
    BuildContext context,
    WidgetRef ref,
    bool isMobile,
    String categoriaAtual,
    String busca,
  ) {
    const cats = [
      'Todos',
      'Direitos',
      'Saúde Mental',
      'Segurança',
      'Apoio',
      'Família',
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: isMobile ? 64 : 120,
      ),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -1.2),
          radius: 1.5,
          colors: [_kBrandPrimary.withValues(alpha: 0.15), Colors.transparent],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: isMobile
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: isMobile ? 0 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _kBrandPrimary.withValues(alpha: 0.1),
                        border: Border.all(
                          color: _kBrandPrimary.withValues(alpha: 0.2),
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.shield,
                            size: 12,
                            color: _kBrandPrimary,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'CONEXÃO SEGURA ATIVA',
                            style: TextStyle(
                              color: _kBrandPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Informação que\nSalva Vidas.',
                      style: TextStyle(
                        fontSize: isMobile ? 40 : 64,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Guias técnicos, apoio psicológico e orientações jurídicas produzidas por especialistas da rede NIRA.',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
              if (isMobile) const SizedBox(height: 32),
              SizedBox(
                width: isMobile ? double.infinity : 400,
                child: TextField(
                  onChanged: (val) =>
                      ref.read(buscaArtigoProvider.notifier).state = val,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Pesquisar por tema ou palavra-chave...',
                    hintStyle: const TextStyle(color: Colors.white38),
                    prefixIcon: const Icon(
                      LucideIcons.search,
                      color: Colors.white38,
                    ),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: _kBrandPrimary.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: cats.map((c) {
              final ativo = categoriaAtual == c;
              return InkWell(
                onTap: () =>
                    ref.read(categoriaAtualProvider.notifier).state = c,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: ativo
                        ? _kBrandPrimary
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: ativo
                        ? [
                            BoxShadow(
                              color: _kBrandPrimary.withValues(alpha: 0.3),
                              blurRadius: 12,
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    c.toUpperCase(),
                    style: TextStyle(
                      color: ativo ? Colors.white : Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDestaque(
    BuildContext context,
    WidgetRef ref,
    bool isMobile,
    Article destaque,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: 32,
      ),
      child: InkWell(
        onTap: () => ref.read(artigoAtivoProvider.notifier).state = destaque,
        borderRadius: BorderRadius.circular(48),
        child: Container(
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            image: DecorationImage(
              image: NetworkImage(
                destaque.imageUrl ??
                    'https://images.unsplash.com/photo-1576091160550-217359971f8b?auto=format&fit=crop&q=80&w=800',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.5),
                BlendMode.darken,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  const Color(0xFF07070B).withValues(alpha: 0.9),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _kBrandPrimary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Text(
                        '📌 MATÉRIA EM DESTAQUE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${destaque.category?.toUpperCase() ?? "GERAL"} · ${destaque.readTimeMinutes ?? 5} MIN',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  destaque.title,
                  style: TextStyle(
                    fontSize: isMobile ? 32 : 56,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  destaque.description ?? '',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListagem(
    BuildContext context,
    WidgetRef ref,
    bool isMobile,
    List<Article> artigos,
    String busca,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: 64,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'EXPLORE A BIBLIOTECA${busca.isNotEmpty ? ' · Resultados para "$busca"' : ''}',
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              Text(
                '${artigos.length} ARTIGOS',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white10),
          const SizedBox(height: 48),
          if (artigos.isEmpty)
            const Center(
              child: Column(
                children: [
                  Icon(LucideIcons.search, size: 64, color: _kBrandPrimary),
                  SizedBox(height: 16),
                  Text(
                    'NENHUM RESULTADO ENCONTRADO',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            )
          else
            Wrap(
              spacing: 32,
              runSpacing: 32,
              children: artigos
                  .map((art) => _buildArticleCard(context, ref, isMobile, art))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(
    BuildContext context,
    WidgetRef ref,
    bool isMobile,
    Article art,
  ) {
    final width = isMobile
        ? double.infinity
        : (MediaQuery.sizeOf(context).width - 128 - 64) / 3;

    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => ref.read(artigoAtivoProvider.notifier).state = art,
        child: NiraGlassCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      art.imageUrl ??
                          'https://images.unsplash.com/photo-1576091160550-217359971f8b?auto=format&fit=crop&q=80&w=800',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            const Color(0xFF151521).withValues(alpha: 0.9),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 24,
                      left: 24,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF07070B).withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: _kBrandPrimary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          art.category?.toUpperCase() ?? 'GERAL',
                          style: const TextStyle(
                            color: _kBrandPrimary,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      art.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      art.description ?? '',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                        height: 1.6,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 32),
                    const Divider(color: Colors.white10),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: _kBrandPrimary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  'N',
                                  style: TextStyle(
                                    color: _kBrandPrimary,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'REDE NIRA',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              LucideIcons.clock,
                              size: 12,
                              color: Colors.white38,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${art.readTimeMinutes ?? 5} MIN',
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalArtigo(
    BuildContext context,
    WidgetRef ref,
    bool isMobile,
    Article artigo,
  ) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => ref.read(artigoAtivoProvider.notifier).state = null,
            child: Container(
              color: const Color(0xFF07070B).withValues(alpha: 0.9),
            ),
          ),
          Center(
            child: Container(
              width: isMobile ? double.infinity : 900,
              height: isMobile
                  ? double.infinity
                  : MediaQuery.sizeOf(context).height * 0.9,
              margin: isMobile ? EdgeInsets.zero : const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFF11111B),
                borderRadius: BorderRadius.circular(isMobile ? 0 : 48),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 40,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                artigo.imageUrl ??
                                    'https://images.unsplash.com/photo-1576091160550-217359971f8b?auto=format&fit=crop&q=80&w=800',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(48),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  const Color(0xFF11111B),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _kBrandPrimary,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    artigo.category?.toUpperCase() ?? 'GERAL',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  artigo.title,
                                  style: TextStyle(
                                    fontSize: isMobile ? 32 : 48,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    height: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(isMobile ? 32 : 64),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                children: [
                                  const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        LucideIcons.heart,
                                        size: 14,
                                        color: _kBrandPrimary,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'ESCRITO POR REDE NIRA',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    '|',
                                    style: TextStyle(color: Colors.white24),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        LucideIcons.clock,
                                        size: 14,
                                        color: Colors.white54,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'LEITURA DE ${artigo.readTimeMinutes ?? 5} MIN',
                                        style: const TextStyle(
                                          color: Colors.white54,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              const Divider(color: Colors.white10),
                              const SizedBox(height: 32),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 24,
                                  top: 8,
                                  bottom: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: _kBrandPrimary,
                                      width: 4,
                                    ),
                                  ),
                                ),
                                child: Html(
                                  data: artigo.description ?? '',
                                  style: {
                                    'body': Style(
                                      margin: Margins.zero,
                                      padding: HtmlPaddings.zero,
                                      color: Colors.white,
                                      fontSize: FontSize(20),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: const LineHeight(1.6),
                                    ),
                                  },
                                ),
                              ),
                              const SizedBox(height: 32),
                              Html(
                                data:
                                    artigo.content ??
                                    '<p>Conteúdo não disponível para leitura no momento.</p>',
                                style: {
                                  'body': Style(
                                    color: Colors.white70,
                                    fontSize: FontSize(18),
                                    lineHeight: const LineHeight(1.8),
                                  ),
                                  'p': Style(
                                    margin: Margins.symmetric(vertical: 8),
                                  ),
                                  'ul': Style(
                                    margin: Margins.symmetric(vertical: 8),
                                    padding: HtmlPaddings.only(left: 20),
                                  ),
                                  'li': Style(
                                    margin: Margins.symmetric(vertical: 4),
                                  ),
                                },
                              ),
                              const SizedBox(height: 48),
                              Container(
                                padding: const EdgeInsets.all(40),
                                decoration: BoxDecoration(
                                  color: _kBrandPrimary.withValues(alpha: 0.05),
                                  border: Border.all(
                                    color: _kBrandPrimary.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(
                                          LucideIcons.shield,
                                          size: 16,
                                          color: _kBrandPrimary,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'AVISO DE SEGURANÇA:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    const Text(
                                      'Este é um conteúdo informativo fornecido para auxiliar mulheres em situação de risco. O NIRA não substitui o aconselhamento jurídico formal, mas oferece as primeiras diretrizes de segurança e suporte emocional.',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        height: 1.6,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    _buildSafetyRule(
                                      '1',
                                      'Busque um local seguro e silencioso antes de continuar a leitura ou solicitar ajuda.',
                                    ),
                                    const SizedBox(height: 16),
                                    _buildSafetyRule(
                                      '2',
                                      'Lembre-se de usar o modo de navegação anônima para sua segurança digital.',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 48),
                              const Divider(color: Colors.white10),
                              const SizedBox(height: 48),
                              Flex(
                                direction: isMobile
                                    ? Axis.vertical
                                    : Axis.horizontal,
                                children: [
                                  Expanded(
                                    flex: isMobile ? 0 : 1,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        ref
                                                .read(
                                                  artigoAtivoProvider.notifier,
                                                )
                                                .state =
                                            null;
                                      },
                                      icon: const Icon(LucideIcons.arrowRight),
                                      label: const Text(
                                        'SOLICITAR APOIO AGORA',
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _kBrandPrimary,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 24,
                                        ),
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: isMobile ? 0 : 16,
                                    height: isMobile ? 16 : 0,
                                  ),
                                  Expanded(
                                    flex: isMobile ? 0 : 1,
                                    child: OutlinedButton(
                                      onPressed: () =>
                                          ref
                                                  .read(
                                                    artigoAtivoProvider
                                                        .notifier,
                                                  )
                                                  .state =
                                              null,
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(
                                          color: Colors.white24,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 24,
                                        ),
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      child: const Text('VOLTAR PARA GALERIA'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 24,
                    right: 24,
                    child: IconButton(
                      icon: const Icon(LucideIcons.x, color: Colors.white),
                      onPressed: () =>
                          ref.read(artigoAtivoProvider.notifier).state = null,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black45,
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyRule(String num, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: _kBrandPrimary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              num,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
