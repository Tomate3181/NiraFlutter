import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/nira_models.dart';

part 'nira_gemini_service.g.dart';

String _resolveGeminiApiKey() {
  var key = const String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
  if (key.isEmpty) {
    key = dotenv.env['VITE_GEMINI_API_KEY'] ?? dotenv.env['GEMINI_API_KEY'] ?? '';
  }
  return key;
}

@riverpod
NiraGeminiService niraGemini(Ref ref) {
  return NiraGeminiService(_resolveGeminiApiKey());
}

class NiraGeminiService {
  final String _apiKey;
  late final GenerativeModel _model;

  NiraGeminiService(this._apiKey) {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _apiKey,
      systemInstruction: Content.system('''
Você é um Analista Estratégico de Segurança Pública altamente qualificado.
Sua missão é analisar dados históricos de incidentes (alertas de SOS e denúncias) e gerar relatórios preditivos e operacionais.
Você deve identificar padrões de horários, áreas de maior risco (hotspots), tendências de severidade e sugerir alocações táticas de recursos e equipes.
A sua resposta DEVE ser formatada obrigatoriamente em Markdown limpo, utilizando títulos, listas, negritos e itálicos para facilitar a leitura no painel administrativo do software. Não use tags HTML brutas.
'''),
    );
  }

  /// Gera um relatório analítico profundo com base na lista de alertas/incidentes
  Future<String> gerarAnaliseProfunda(List<Alert> dadosIncidentes) async {
    try {
      if (_apiKey.isEmpty) {
        throw Exception(
            'Chave da API do Gemini não configurada. Forneça a chave por meio do ambiente (GEMINI_API_KEY).');
      }

      if (dadosIncidentes.isEmpty) {
        return 'Nenhum incidente registrado para gerar análise neste período.';
      }

      // Converte os dados do Dart para JSON estruturado em String para o LLM entender as entidades
      final dadosExtraidos = dadosIncidentes.map((alerta) {
        return {
          'codigo': alerta.ticketCode,
          'status': alerta.status.name,
          'risco': alerta.risk.name,
          'tipo': alerta.type.name,
          'lat': alerta.latitude,
          'lng': alerta.longitude,
          'data': alerta.createdAt?.toIso8601String(),
        };
      }).toList();

      final promptText =
          'Analise o seguinte lote de dados de incidentes recentes e gere o relatório estratégico conforme suas instruções de sistema:\n\n${jsonEncode(dadosExtraidos)}';

      final response = await _model.generateContent([
        Content.text(promptText),
      ]);

      final textoGerado = response.text;
      if (textoGerado == null || textoGerado.trim().isEmpty) {
        throw Exception('A Inteligência Artificial retornou uma resposta vazia.');
      }

      return textoGerado;
    } catch (e) {
      // Captura e repassa o erro formatado para a UI lidar com ele (ex: mostrar Snackbar)
      throw Exception('Falha ao processar análise preditiva com o Gemini: $e');
    }
  }
}
