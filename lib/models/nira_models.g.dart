// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nira_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Organization _$OrganizationFromJson(Map<String, dynamic> json) =>
    _Organization(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$OrganizationToJson(_Organization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: json['id'] as String,
  name: json['name'] as String,
  loginUsername: json['login_username'] as String?,
  type:
      $enumDecodeNullable(_$ProfileTypeEnumMap, json['type']) ??
      ProfileType.user,
  specialty: json['specialty'] as String?,
  organizationId: json['organization_id'] as String?,
  accessLevel: json['access_level'] as String?,
  status: json['status'] as String? ?? 'ATIVO',
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  email: json['email'] as String?,
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
  area: json['area'] as String?,
  notificacoes:
      (json['notificacoes'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'login_username': instance.loginUsername,
  'type': _$ProfileTypeEnumMap[instance.type]!,
  'specialty': instance.specialty,
  'organization_id': instance.organizationId,
  'access_level': instance.accessLevel,
  'status': instance.status,
  'created_at': instance.createdAt?.toIso8601String(),
  'email': instance.email,
  'lat': instance.lat,
  'lng': instance.lng,
  'area': instance.area,
  'notificacoes': instance.notificacoes,
  'updated_at': instance.updatedAt?.toIso8601String(),
};

const _$ProfileTypeEnumMap = {
  ProfileType.admin: 'ADMIN',
  ProfileType.ong: 'ONG',
  ProfileType.profissional: 'PROFISSIONAL',
  ProfileType.agente: 'AGENTE',
  ProfileType.user: 'USER',
};

_Article _$ArticleFromJson(Map<String, dynamic> json) => _Article(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  category: json['category'] as String?,
  authorOrganizationId: json['author_organization_id'] as String?,
  readTimeMinutes: (json['read_time_minutes'] as num?)?.toInt(),
  featured: json['featured'] as bool? ?? false,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  imageUrl: json['image_url'] as String?,
  content: json['content'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ArticleToJson(_Article instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'category': instance.category,
  'author_organization_id': instance.authorOrganizationId,
  'read_time_minutes': instance.readTimeMinutes,
  'featured': instance.featured,
  'tags': instance.tags,
  'image_url': instance.imageUrl,
  'content': instance.content,
  'created_at': instance.createdAt?.toIso8601String(),
};

_Alert _$AlertFromJson(Map<String, dynamic> json) => _Alert(
  id: json['id'] as String,
  ticketCode: json['ticket_code'] as String,
  anonymousUserRef: json['anonymous_user_ref'] as String?,
  userId: json['user_id'] as String?,
  locationName: json['location_name'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  status:
      $enumDecodeNullable(_$AlertStatusEnumMap, json['status']) ??
      AlertStatus.ativo,
  risk:
      $enumDecodeNullable(_$RiskLevelEnumMap, json['risk']) ?? RiskLevel.baixo,
  type: $enumDecodeNullable(_$AlertTypeEnumMap, json['type']) ?? AlertType.map,
  assignedTo: json['assigned_to'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$AlertToJson(_Alert instance) => <String, dynamic>{
  'id': instance.id,
  'ticket_code': instance.ticketCode,
  'anonymous_user_ref': instance.anonymousUserRef,
  'user_id': instance.userId,
  'location_name': instance.locationName,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'status': _$AlertStatusEnumMap[instance.status]!,
  'risk': _$RiskLevelEnumMap[instance.risk]!,
  'type': _$AlertTypeEnumMap[instance.type]!,
  'assigned_to': instance.assignedTo,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

const _$AlertStatusEnumMap = {
  AlertStatus.ativo: 'ATIVO',
  AlertStatus.concluido: 'CONCLUIDO',
  AlertStatus.pendente: 'PENDENTE',
};

const _$RiskLevelEnumMap = {
  RiskLevel.alto: 'ALTO',
  RiskLevel.medio: 'MEDIO',
  RiskLevel.baixo: 'BAIXO',
};

const _$AlertTypeEnumMap = {AlertType.map: 'MAP', AlertType.chat: 'CHAT'};

_AlertLog _$AlertLogFromJson(Map<String, dynamic> json) => _AlertLog(
  id: json['id'] as String,
  alertId: json['alert_id'] as String?,
  logMessage: json['log_message'] as String,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$AlertLogToJson(_AlertLog instance) => <String, dynamic>{
  'id': instance.id,
  'alert_id': instance.alertId,
  'log_message': instance.logMessage,
  'created_at': instance.createdAt?.toIso8601String(),
};

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => _ChatMessage(
  id: json['id'] as String,
  alertId: json['alert_id'] as String?,
  senderId: json['sender_id'] as String?,
  isAnonymousVictim: json['is_anonymous_victim'] as bool? ?? false,
  message: json['message'] as String,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ChatMessageToJson(_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'alert_id': instance.alertId,
      'sender_id': instance.senderId,
      'is_anonymous_victim': instance.isAnonymousVictim,
      'message': instance.message,
      'created_at': instance.createdAt?.toIso8601String(),
    };
