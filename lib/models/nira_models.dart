import 'package:freezed_annotation/freezed_annotation.dart';

part 'nira_models.freezed.dart';
part 'nira_models.g.dart';

// ----------------------------------------------------------------------
// ENUMS
// ----------------------------------------------------------------------

enum ProfileType {
  @JsonValue('ADMIN') admin,
  @JsonValue('ONG') ong,
  @JsonValue('PROFISSIONAL') profissional,
  @JsonValue('AGENTE') agente,
  @JsonValue('USER') user,
}

enum AlertStatus {
  @JsonValue('ATIVO') ativo,
  @JsonValue('CONCLUIDO') concluido,
  @JsonValue('PENDENTE') pendente,
}

enum RiskLevel {
  @JsonValue('ALTO') alto,
  @JsonValue('MEDIO') medio,
  @JsonValue('BAIXO') baixo,
}

enum AlertType {
  @JsonValue('MAP') map,
  @JsonValue('CHAT') chat,
}

// ----------------------------------------------------------------------
// MODELS
// ----------------------------------------------------------------------

@freezed
class Organization with _$Organization {
  const factory Organization({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Organization;

  factory Organization.fromJson(Map<String, Object?> json) => 
      _$OrganizationFromJson(json);
}

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String name,
    @JsonKey(name: 'login_username') String? loginUsername,
    @Default(ProfileType.user) ProfileType type,
    String? specialty,
    @JsonKey(name: 'organization_id') String? organizationId,
    @JsonKey(name: 'access_level') String? accessLevel,
    @Default('ATIVO') String status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    String? email,
    double? lat,
    double? lng,
    String? area,
    @Default([]) List<Map<String, Object?>> notificacoes,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Profile;

  factory Profile.fromJson(Map<String, Object?> json) => 
      _$ProfileFromJson(json);
}

@freezed
class Article with _$Article {
  const factory Article({
    required String id,
    required String title,
    String? description,
    String? category,
    @JsonKey(name: 'author_organization_id') String? authorOrganizationId,
    @JsonKey(name: 'read_time_minutes') int? readTimeMinutes,
    @Default(false) bool featured,
    @Default([]) List<String> tags,
    @JsonKey(name: 'image_url') String? imageUrl,
    String? content,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Article;

  factory Article.fromJson(Map<String, Object?> json) => 
      _$ArticleFromJson(json);
}

@freezed
class Alert with _$Alert {
  const factory Alert({
    required String id,
    @JsonKey(name: 'ticket_code') required String ticketCode,
    @JsonKey(name: 'anonymous_user_ref') String? anonymousUserRef,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'location_name') String? locationName,
    double? latitude,
    double? longitude,
    @Default(AlertStatus.ativo) AlertStatus status,
    @Default(RiskLevel.baixo) RiskLevel risk,
    @Default(AlertType.map) AlertType type,
    @JsonKey(name: 'assigned_to') String? assignedTo,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Alert;

  factory Alert.fromJson(Map<String, Object?> json) => 
      _$AlertFromJson(json);
}

@freezed
class AlertLog with _$AlertLog {
  const factory AlertLog({
    required String id,
    @JsonKey(name: 'alert_id') String? alertId,
    @JsonKey(name: 'log_message') required String logMessage,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _AlertLog;

  factory AlertLog.fromJson(Map<String, Object?> json) => 
      _$AlertLogFromJson(json);
}

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    @JsonKey(name: 'alert_id') String? alertId,
    @JsonKey(name: 'sender_id') String? senderId,
    @JsonKey(name: 'is_anonymous_victim') @Default(false) bool isAnonymousVictim,
    required String message,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, Object?> json) => 
      _$ChatMessageFromJson(json);
}
