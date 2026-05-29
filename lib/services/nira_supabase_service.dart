import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/nira_models.dart';

part 'nira_supabase_service.g.dart';

@riverpod
NiraSupabaseService niraSupabase(NiraSupabaseRef ref) {
  return NiraSupabaseService(Supabase.instance.client);
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
