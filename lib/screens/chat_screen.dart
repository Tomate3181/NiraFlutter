import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/nira_glass_card.dart';
import '../services/nira_supabase_service.dart';
import '../models/nira_models.dart';

// Definindo o Stream do chat real-time dinamicamente com base no chatId
final chatMessagesStreamProvider = StreamProvider.autoDispose.family<List<ChatMessage>, String>((ref, chatId) {
  final service = ref.watch(niraSupabaseProvider);
  return service.escutarChatAnonimo(chatId);
});

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  // --- Estados do Chat ---
  bool _chatAtivo = false;
  bool _isHumanSupport = false;
  bool _sosConfirmed = false;
  bool _digitando = false;
  String _inputVal = '';
  String _currentChatId = '';
  String? _riscoAtual;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  // Histórico de mensagens local (Triage Chatbot)
  final List<Map<String, dynamic>> _messages = [];

  // O fluxo de triagem estático baseado no React
  final List<Map<String, dynamic>> _flow = [
    {
      'id': 'start',
      'msg': 'Oi. Seja bem-vindo(a) ao espaço de cuidado da Nira.\n\nEste lugar é totalmente seguro e anônimo. Não guardamos nenhuma informação sua.\n\nComo podemos te ajudar agora?',
      'options': [
        {'text': 'Estou em perigo agora', 'next': 'perigo'},
        {'text': 'Preciso desabafar / conversar', 'next': 'conversar'},
        {'text': 'Quero saber meus direitos', 'next': 'direitos'},
        {'text': 'Procuro ajuda perto de mim', 'next': 'servicos'},
      ],
    },
    {
      'id': 'perigo',
      'msg': 'Entendo. Sua segurança é o mais importante agora.\n\nVocê consegue apertar o botão vermelho de S.O.S. na tela? Ele avisa nossa equipe onde você está para podermos agir.\n\nSe preferir ligar para a polícia, disque 190. Para ajuda específica, disque 180.',
      'options': [
        {'text': 'Apertei o S.O.S.', 'next': 'sos_ativo'},
        {'text': 'Estou em lugar seguro agora', 'next': 'seguro'},
      ],
      'risco': 'alto',
    },
    {
      'id': 'sos_ativo',
      'msg': 'Alerta ligado! Já avisamos nossa equipe.\n\nFique em um lugar seguro se puder e tente trancar a porta. Alguém vai falar com você por aqui em breve.',
      'options': [
        {'text': 'Estou aguardando', 'next': 'aguardando'},
      ],
      'risco': 'alto',
    },
    {
      'id': 'aguardando',
      'msg': 'Nossa equipe está vindo. Tente respirar fundo.\n\nVocê não está só nessa.',
      'options': <Map<String, dynamic>>[],
      'final': true,
      'risco': 'alto',
    },
    {
      'id': 'conversar',
      'msg': 'Estamos aqui para te ouvir com carinho e sem te julgar.\n\nIsso está acontecendo agora ou já faz tempo?',
      'options': [
        {'text': 'Está acontecendo agora', 'next': 'seguro'},
        {'text': 'Aconteceu faz pouco tempo', 'next': 'recente'},
        {'text': 'Faz tempo, mas ainda sofro', 'next': 'passado'},
      ],
    },
    // Aqui incluímos apenas o básico do fluxo para não inchar o código (simulação da IA)
    {
      'id': 'conectar_humano',
      'msg': 'Estabelecendo protocolo de conexão segura...\n\nEm curtos instantes, uma especialista ou assistente social da nossa rede estará conectada a essa sessão.',
      'options': <Map<String, dynamic>>[],
      'final': true,
      'risco': 'medio',
    },
    {
      'id': 'seguro',
      'msg': 'Fico mais tranquila por você estar em segurança agora.\n\nO que aconteceu exatamente?',
      'options': [
        {'text': 'Sofri agressão física', 'next': 'tipo_fisica'},
        {'text': 'Fui ameaçado(a)', 'next': 'tipo_ameaca'},
      ],
      'risco': 'medio',
    },
  ];

  final List<Map<String, dynamic>> _quickDiagnostics = [
    {'text': 'PERIGO IMEDIATO', 'next': 'perigo', 'type': 'sos'},
    {'text': '👊 Violência Física', 'next': 'tipo_fisica'},
    {'text': '🧠 Abuso Psicológico', 'next': 'conversar'},
    {'text': '⚠️ Ameaças Graves', 'next': 'seguro'},
    {'text': '🛡️ Meus Direitos', 'next': 'direitos'},
  ];

  String _formatTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  void _scrollBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _iniciarChat() {
    setState(() {
      _chatAtivo = true;
      _isHumanSupport = false;
      _messages.clear();
      _riscoAtual = null;
      _currentChatId = 'T${DateTime.now().millisecondsSinceEpoch}';
    });

    final step = _flow.firstWhere((f) => f['id'] == 'start');
    
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => _digitando = true);
      
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (!mounted) return;
        setState(() {
          _digitando = false;
          _messages.add({
            'role': 'bot',
            'text': step['msg'],
            'options': step['options'],
            'time': _formatTime(),
          });
        });
        _scrollBottom();
      });
    });
  }

  void _escolherOpcao(Map<String, dynamic> opcao) {
    if (_isHumanSupport) return;
    
    setState(() {
      // Remove opções da última mensagem do bot
      if (_messages.isNotEmpty && _messages.last['role'] == 'bot') {
        _messages.last.remove('options');
      }
      _messages.add({
        'role': 'user',
        'text': opcao['text'],
        'time': _formatTime(),
      });
    });
    _scrollBottom();

    if (opcao['next'] == 'conectar_humano') {
      _conectarAtendimentoHumano();
      return;
    }

    final proxStep = _flow.firstWhere(
      (f) => f['id'] == opcao['next'],
      orElse: () => {
        'id': 'fallback',
        'msg': 'Agradecemos por compartilhar. Como prefere seguir?',
        'options': [
          {'text': 'Necessito conexão com profissionais', 'next': 'conectar_humano'},
        ]
      },
    );

    if (proxStep.containsKey('risco')) {
      setState(() => _riscoAtual = proxStep['risco'] as String);
    }

    setState(() => _digitando = true);
    
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _digitando = false;
        _messages.add({
          'role': 'bot',
          'text': proxStep['msg'],
          'options': proxStep['final'] == true ? [] : proxStep['options'],
          'time': _formatTime(),
          'risco': proxStep['risco'],
          'final': proxStep['final'],
        });
      });
      _scrollBottom();
    });
  }

  Future<void> _conectarAtendimentoHumano() async {
    if (_isHumanSupport) return;

    setState(() {
      _isHumanSupport = true;
      if (_messages.isNotEmpty && _messages.last['role'] == 'bot') {
        _messages.last.remove('options');
      }
      _messages.add({
        'role': 'bot',
        'text': '⌛ **Aguardando conexão com psicólogo(a)...**\n\nNossa equipe especializada foi notificada. Um profissional se conectará em instantes.',
        'time': _formatTime(),
      });
    });
    _scrollBottom();

    // Na integração real, o _currentChatId será usado para enviar as mensagens para o Supabase
    // Já podemos garantir que o chatId seja criado caso necessário
  }

  Future<void> _enviarTexto() async {
    if (_inputVal.trim().isEmpty) return;
    final txt = _inputVal.trim();
    
    setState(() {
      _inputVal = '';
      _textController.clear();
    });

    if (_isHumanSupport) {
      // Usa o SupabaseService para enviar a mensagem em Realtime
      try {
        final service = ref.read(niraSupabaseProvider);
        await service.enviarMensagem(_currentChatId, txt, 'vitima');
      } catch (e) {
        debugPrint('Erro ao enviar msg pro supabase: $e');
      }
      return;
    }

    // Fluxo Triage Chatbot
    setState(() {
      if (_messages.isNotEmpty && _messages.last['role'] == 'bot') {
        _messages.last.remove('options');
      }
      _messages.add({'role': 'user', 'text': txt, 'time': _formatTime()});
      _digitando = true;
    });
    _scrollBottom();

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _digitando = false;
        _messages.add({
          'role': 'bot',
          'text': 'Compreendo. Gostaria de se conectar com um especialista agora ou precisa acionar um alerta de perigo?',
          'options': [
            {'text': 'Estou em perigo', 'next': 'perigo'},
            {'text': 'Falar com especialista', 'next': 'conectar_humano'},
          ],
          'time': _formatTime(),
        });
      });
      _scrollBottom();
    });
  }

  Future<void> _ativarSOS() async {
    // Integração com Supabase dispararSOS (coordenadas fictícias para exemplo de geolocalização)
    try {
      final service = ref.read(niraSupabaseProvider);
      await service.dispararSOS(-23.550520, -46.633308, 'anonimo'); // Ex: Centro de SP
    } catch (e) {
      debugPrint('Erro ao disparar SOS: $e');
    }

    setState(() {
      _sosConfirmed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 900;

    return Scaffold(
      backgroundColor: const Color(0xFF111119),
      body: Stack(
        children: [
          Row(
            children: [
              if (!isMobile) _buildSidebar(),
              Expanded(
                child: Column(
                  children: [
                    _buildHeader(isMobile),
                    Expanded(
                      child: _chatAtivo ? _buildChatArea() : _buildWelcome(),
                    ),
                    if (_chatAtivo) _buildInputArea(),
                  ],
                ),
              )
            ],
          ),
          
          if (_sosConfirmed) _buildSOSOverlay(),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 290,
      decoration: BoxDecoration(
        color: const Color(0xFF111119),
        border: Border(right: BorderSide(color: const Color(0xFF9B8FFF).withValues(alpha: 0.08))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Row(
                    children: [
                      Icon(LucideIcons.arrowLeft, size: 14, color: Colors.white.withValues(alpha: 0.4)),
                      const SizedBox(width: 6),
                      Text('Voltar ao site', style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text('CONVERSAS', style: TextStyle(color: Color(0xFF8B8A9A), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _iniciarChat,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B7EFA).withValues(alpha: 0.05),
                      border: Border.all(color: const Color(0xFF8B7EFA).withValues(alpha: 0.35)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(LucideIcons.sparkles, size: 14, color: Color(0xFF8A7EF8)),
                        const SizedBox(width: 10),
                        Text('Nova conversa', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: const Color(0xFF9B8FFF).withValues(alpha: 0.08))),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(LucideIcons.lock, size: 18, color: Colors.white.withValues(alpha: 0.8)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Todas as conversas são 100% anônimas. Nenhum dado pessoal é armazenado.', style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11, fontWeight: FontWeight.w500, height: 1.5)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF111119),
        border: Border(bottom: BorderSide(color: const Color(0xFF9B8FFF).withValues(alpha: 0.05))),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (isMobile) ...[
                InkWell(onTap: () => Navigator.of(context).pop(), child: const Icon(LucideIcons.arrowLeft, color: Colors.white54, size: 20)),
                const SizedBox(width: 16),
              ],
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(colors: [Color(0x0DFFFFFF), Color(0x269B8FFF)]),
                  boxShadow: [BoxShadow(color: const Color(0xFF8B7EFA).withValues(alpha: 0.1), blurRadius: 20)],
                ),
                child: const Center(child: Icon(LucideIcons.shield, color: Color(0xFFA491FF), size: 20)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_chatAtivo ? 'Assistente Nira' : 'Painel Nira', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF2ED573), shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Text(
                        !_chatAtivo ? 'Serviço em plantão' : _isHumanSupport ? 'Conectando com psicólogo' : 'Atendimento verificado',
                        style: const TextStyle(color: Color(0xFF2ED573), fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      if (_riscoAtual != null) ...[
                        const SizedBox(width: 8),
                        Text('· Grau: ${_riscoAtual!.toUpperCase()}', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12, fontWeight: FontWeight.bold)),
                      ]
                    ],
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _ativarSOS,
                icon: const Icon(LucideIcons.alertTriangle, size: 14),
                label: const Text('Acionar S.O.S.'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4757).withValues(alpha: 0.1),
                  foregroundColor: const Color(0xFFFF4757),
                  elevation: 0,
                  side: BorderSide(color: const Color(0xFFFF4757).withValues(alpha: 0.3)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              if (_chatAtivo) ...[
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _isHumanSupport ? null : _conectarAtendimentoHumano,
                  icon: const Icon(LucideIcons.messageSquare, size: 14),
                  label: Text(_isHumanSupport ? 'Conexão Iniciada' : 'Atendimento Humano'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isHumanSupport ? const Color(0xFF2ED573).withValues(alpha: 0.15) : Colors.transparent,
                    foregroundColor: _isHumanSupport ? const Color(0xFF2ED573) : Colors.white.withValues(alpha: 0.8),
                    elevation: 0,
                    side: BorderSide(color: _isHumanSupport ? const Color(0xFF2ED573).withValues(alpha: 0.4) : const Color(0xFF9B8FFF).withValues(alpha: 0.25)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ]
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWelcome() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const Icon(LucideIcons.shield, size: 64, color: Color(0xFFA491FF)),
            const SizedBox(height: 24),
            const Text('Como podemos intervir?', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(
              'O painel atua por intermédio reativo e confidencial da plataforma Nira.\nEscolha o vetor primário que requer nossa atenção agora:',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 15, height: 1.6),
            ),
            const SizedBox(height: 48),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _buildStartCard('Estou em perigo', 'Preciso de ajuda agora', LucideIcons.alertTriangle),
                _buildStartCard('Quero conversar', 'Preciso ser ouvido(a)', LucideIcons.messageSquare),
                _buildStartCard('Meus direitos', 'Quero me informar', LucideIcons.bookOpen),
                _buildStartCard('Buscar apoio', 'Serviços próximos', LucideIcons.mapPin),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStartCard(String title, String desc, IconData icon) {
    return InkWell(
      onTap: _iniciarChat,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFA491FF).withValues(alpha: 0.05),
          border: Border.all(color: const Color(0xFFA491FF).withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42, height: 42,
              decoration: BoxDecoration(color: const Color(0xFFA491FF).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
              child: Center(child: Icon(icon, color: const Color(0xFFA491FF), size: 20)),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(desc, style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildChatArea() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      itemCount: _isHumanSupport ? 1 : _messages.length + (_digitando ? 1 : 0),
      itemBuilder: (context, index) {
        if (_isHumanSupport) {
          return _buildRealtimeChatArea();
        }

        if (index == _messages.length && _digitando) {
          return _buildTypingIndicator();
        }

        final msg = _messages[index];
        final isUser = msg['role'] == 'user';

        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser) ...[
                Container(
                  width: 42, height: 42,
                  decoration: const BoxDecoration(color: Color(0xFFA491FF), shape: BoxShape.circle),
                  child: const Center(child: Icon(LucideIcons.shield, color: Colors.white, size: 20)),
                ),
                const SizedBox(width: 16),
              ],
              Flexible(
                child: Column(
                  crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA491FF).withValues(alpha: 0.05),
                        border: Border.all(color: const Color(0xFFA491FF).withValues(alpha: 0.2)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        msg['text'].toString().replaceAll('**', ''), // Simples remoção de negrito no app por hora
                        style: const TextStyle(color: Color(0xFFD1D5DB), fontSize: 15, height: 1.6),
                      ),
                    ),
                    if (!isUser && msg['options'] != null && msg['options'].isNotEmpty && index == _messages.length - 1 && !_digitando)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: (msg['options'] as List).map((opt) => OutlinedButton(
                            onPressed: () => _escolherOpcao(opt),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFD1D5DB),
                              side: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            child: Text(opt['text']),
                          )).toList(),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(msg['time'], style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 10, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              if (isUser) ...[
                const SizedBox(width: 16),
                Container(
                  width: 42, height: 42,
                  decoration: BoxDecoration(color: const Color(0xFFA491FF).withValues(alpha: 0.5), shape: BoxShape.circle),
                  child: const Center(child: Icon(LucideIcons.user, color: Colors.white, size: 20)),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildRealtimeChatArea() {
    // Escutando do banco quando human support ativado
    final chatStream = ref.watch(chatMessagesStreamProvider(_currentChatId));

    return Column(
      children: [
        // Mensagens do histórico de triagem (mock para dar contexto ao humano)
        ..._messages.map((msg) {
          final isUser = msg['role'] == 'user';
          return Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isUser) ...[
                  Container(
                    width: 42, height: 42,
                    decoration: const BoxDecoration(color: Color(0xFFA491FF), shape: BoxShape.circle),
                    child: const Center(child: Icon(LucideIcons.shield, color: Colors.white, size: 20)),
                  ),
                  const SizedBox(width: 16),
                ],
                Flexible(
                  child: Column(
                    crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA491FF).withValues(alpha: 0.05),
                          border: Border.all(color: const Color(0xFFA491FF).withValues(alpha: 0.2)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(msg['text'].toString().replaceAll('**', ''), style: const TextStyle(color: Color(0xFFD1D5DB), fontSize: 15, height: 1.6)),
                      ),
                    ],
                  ),
                ),
                if (isUser) ...[
                  const SizedBox(width: 16),
                  Container(
                    width: 42, height: 42,
                    decoration: BoxDecoration(color: const Color(0xFFA491FF).withValues(alpha: 0.5), shape: BoxShape.circle),
                    child: const Center(child: Icon(LucideIcons.user, color: Colors.white, size: 20)),
                  ),
                ],
              ],
            ),
          );
        }),
        
        // Mensagens do Supabase
        chatStream.when(
          data: (messages) {
            return Column(
              children: messages.map((m) {
                final isUser = m.isAnonymousVictim;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Row(
                    mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isUser) ...[
                        Container(
                          width: 42, height: 42,
                          decoration: const BoxDecoration(color: Color(0xFF2ED573), shape: BoxShape.circle),
                          child: const Center(child: Icon(LucideIcons.stethoscope, color: Colors.white, size: 20)),
                        ),
                        const SizedBox(width: 16),
                      ],
                      Flexible(
                        child: Column(
                          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                              decoration: BoxDecoration(
                                color: isUser ? const Color(0xFFA491FF).withValues(alpha: 0.05) : const Color(0xFF2ED573).withValues(alpha: 0.05),
                                border: Border.all(color: isUser ? const Color(0xFFA491FF).withValues(alpha: 0.2) : const Color(0xFF2ED573).withValues(alpha: 0.2)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(m.message, style: const TextStyle(color: Color(0xFFD1D5DB), fontSize: 15, height: 1.6)),
                            ),
                          ],
                        ),
                      ),
                      if (isUser) ...[
                        const SizedBox(width: 16),
                        Container(
                          width: 42, height: 42,
                          decoration: BoxDecoration(color: const Color(0xFFA491FF).withValues(alpha: 0.5), shape: BoxShape.circle),
                          child: const Center(child: Icon(LucideIcons.user, color: Colors.white, size: 20)),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            );
          },
          loading: () => const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator())),
          error: (e, st) => Text('Erro no chat: $e', style: const TextStyle(color: Colors.red)),
        )
      ],
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42, height: 42,
            decoration: const BoxDecoration(color: Color(0xFFA491FF), shape: BoxShape.circle),
            child: const Center(child: Icon(LucideIcons.shield, color: Colors.white, size: 20)),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFA491FF).withValues(alpha: 0.05),
              border: Border.all(color: const Color(0xFFA491FF).withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(), const SizedBox(width: 5), _buildDot(), const SizedBox(width: 5), _buildDot()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 7, height: 7,
      decoration: BoxDecoration(color: const Color(0xFF9B8FFF).withValues(alpha: 0.7), shape: BoxShape.circle),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [const Color(0xFF111119), const Color(0xFF111119).withValues(alpha: 0)],
        ),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _quickDiagnostics.map((diag) => Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 12),
                child: InkWell(
                  onTap: _isHumanSupport ? null : () => _escolherOpcao(diag),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: diag['type'] == 'sos' ? const Color(0xFFFF4757).withValues(alpha: 0.08) : const Color(0xFF8A7EF8).withValues(alpha: 0.08),
                      border: Border.all(color: diag['type'] == 'sos' ? const Color(0xFFFF4757).withValues(alpha: 0.25) : const Color(0xFF8A7EF8).withValues(alpha: 0.25)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      diag['text'],
                      style: TextStyle(
                        color: _isHumanSupport ? Colors.white38 : (diag['type'] == 'sos' ? const Color(0xFFFF4757) : const Color(0xFFA491FF)),
                        fontSize: 12, fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _isHumanSupport ? const Color(0xFF2ED573).withValues(alpha: 0.05) : const Color(0xFFA491FF).withValues(alpha: 0.03),
              border: Border.all(color: _isHumanSupport ? const Color(0xFF2ED573).withValues(alpha: 0.4) : const Color(0xFFA491FF).withValues(alpha: 0.25)),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onChanged: (val) => _inputVal = val,
                    onSubmitted: (_) => _enviarTexto(),
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: _isHumanSupport ? 'Digite sua mensagem para o psicólogo...' : 'Digite uma mensagem ou escolha uma opção acima...',
                      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.25)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                InkWell(
                  onTap: _enviarTexto,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(color: const Color(0xFF8A7EF8), borderRadius: BorderRadius.circular(8)),
                    child: const Center(child: Icon(LucideIcons.send, color: Colors.white, size: 16)),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.lock, size: 11, color: Colors.white.withValues(alpha: 0.3)),
                const SizedBox(width: 6),
                Text(
                  _isHumanSupport ? 'Conversa anônima · Conectado com Especialista' : 'Conversa anônima · Enter para enviar',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 11),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSOSOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.9),
        child: Center(
          child: NiraGlassCard(
            padding: const EdgeInsets.all(40),
            child: SizedBox(
              width: 350,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 96, height: 96,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF4757).withValues(alpha: 0.1),
                      border: Border.all(color: const Color(0xFFFF4757).withValues(alpha: 0.4)),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(child: Icon(LucideIcons.shield, color: Color(0xFFFF4757), size: 48)),
                  ),
                  const SizedBox(height: 32),
                  const Text('S.O.S. ATIVADO!', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
                  const SizedBox(height: 16),
                  Container(height: 4, width: 80, decoration: BoxDecoration(color: const Color(0xFFFF4757), borderRadius: BorderRadius.circular(4))),
                  const SizedBox(height: 16),
                  const Text(
                    'Sua localização exata foi enviada silenciosamente para a central de monitoramento da NIRA.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFFD1D5DB), fontSize: 14, height: 1.6),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF4757).withValues(alpha: 0.1),
                      border: Border.all(color: const Color(0xFFFF4757).withValues(alpha: 0.2)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('Nossa equipe já está agindo.', style: TextStyle(color: Color(0xFFFF4757), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFFF4757), shape: BoxShape.circle)),
                        const SizedBox(width: 12),
                        const Expanded(child: Text('Mantenha-se em local seguro e tranque as portas se possível.', style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => setState(() => _sosConfirmed = false),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('ENTENDIDO, MANTER EM SIGILO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
