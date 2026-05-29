import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/nira_models.dart';

part 'nira_supabase_service.g.dart';

@riverpod
NiraSupabaseService niraSupabase(Ref ref) {
  try {
    final client = Supabase.instance.client;
    return NiraSupabaseService(client);
  } catch (_) {
    // Tenta valores em tempo de compilação primeiro, depois cai no .env (se
    // foi carregado no `main`).
    String url = const String.fromEnvironment('SUPABASE_URL', defaultValue: '');
    String anonKey = const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');

    if (url.isEmpty || anonKey.isEmpty) {
      final envUrl = dotenv.env['VITE_SUPABASE_URL'] ?? dotenv.env['SUPABASE_URL'];
      final envKey = dotenv.env['VITE_SUPABASE_ANON_KEY'] ?? dotenv.env['SUPABASE_ANON_KEY'];
      url = url.isNotEmpty ? url : (envUrl ?? '');
      anonKey = anonKey.isNotEmpty ? anonKey : (envKey ?? '');
    }

    if (url.isNotEmpty && anonKey.isNotEmpty) {
      final client = SupabaseClient(url, anonKey);
      return NiraSupabaseService(client);
    }

    throw Exception('Supabase não inicializado. Forneça SUPABASE_URL e SUPABASE_ANON_KEY via --dart-define, .env, ou inicialize Supabase antes de usar o serviço.');
  }
}

class NiraSupabaseService {
  final SupabaseClient _client;

  NiraSupabaseService(this._client);

  /// 1. Escutar Alertas SOS Ativos
  Stream<List<Alert>> escutarAlertasSOS() {
    try {
      return _client
          .from('alerts')
          .stream(primaryKey: ['id'])
          .eq('status', 'ATIVO')
          .map((data) => data.map((json) => Alert.fromJson(json)).toList());
    } catch (e) {
      throw Exception('Falha ao escutar alertas SOS: $e');
    }
  }

  /// 2. Escutar Chat Anônimo
  Stream<List<ChatMessage>> escutarChatAnonimo(String chatRoomId) {
    try {
      return _client
          .from('chat_messages')
          .stream(primaryKey: ['id'])
          .eq('alert_id', chatRoomId)
          .order('created_at', ascending: true)
          .map((data) => data.map((json) => ChatMessage.fromJson(json)).toList());
    } catch (e) {
      throw Exception('Falha ao escutar chat anônimo: $e');
    }
  }

  /// 3. Disparar SOS
  Future<void> dispararSOS(
    double latitude,
    double longitude,
    String usuarioId,
  ) async {
    try {
      final ticketCode = 'SOS-${DateTime.now().millisecondsSinceEpoch}';

      await _client.from('alerts').insert({
        'ticket_code': ticketCode,
        'user_id': usuarioId,
        'latitude': latitude,
        'longitude': longitude,
        'status': 'ATIVO',
        'type': 'MAP',
        'risk': 'ALTO',
      });
    } catch (e) {
      throw Exception('Falha ao disparar SOS: $e');
    }
  }

  /// 4. Enviar Mensagem no Chat
  Future<void> enviarMensagem(
    String chatRoomId,
    String conteudo,
    String remetenteRole,
  ) async {
    try {
      final isAnonymous = remetenteRole.toLowerCase() == 'vitima' || 
                          remetenteRole.toLowerCase() == 'anonimo';

      final payload = <String, dynamic>{
        'alert_id': chatRoomId,
        'message': conteudo,
        'is_anonymous_victim': isAnonymous,
      };

      if (!isAnonymous) {
        final currentUser = _client.auth.currentUser;
        if (currentUser != null) {
          payload['sender_id'] = currentUser.id;
        }
      }

      await _client.from('chat_messages').insert(payload);
    } catch (e) {
      throw Exception('Falha ao enviar mensagem: $e');
    }
  }

  /// 5. Buscar Artigos
  Future<List<Article>> buscarArtigos() async {
    try {
      final response = await _client
          .from('articles')
          .select()
          .order('created_at', ascending: false);
      return response.map((json) => Article.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Falha ao buscar artigos: $e');
    }
  }
}
