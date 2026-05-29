// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nira_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Organization {

 String get id; String get name; String? get description;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of Organization
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizationCopyWith<Organization> get copyWith => _$OrganizationCopyWithImpl<Organization>(this as Organization, _$identity);

  /// Serializes this Organization to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Organization&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt);

@override
String toString() {
  return 'Organization(id: $id, name: $name, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $OrganizationCopyWith<$Res>  {
  factory $OrganizationCopyWith(Organization value, $Res Function(Organization) _then) = _$OrganizationCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$OrganizationCopyWithImpl<$Res>
    implements $OrganizationCopyWith<$Res> {
  _$OrganizationCopyWithImpl(this._self, this._then);

  final Organization _self;
  final $Res Function(Organization) _then;

/// Create a copy of Organization
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Organization].
extension OrganizationPatterns on Organization {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Organization value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Organization() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Organization value)  $default,){
final _that = this;
switch (_that) {
case _Organization():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Organization value)?  $default,){
final _that = this;
switch (_that) {
case _Organization() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Organization() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Organization():
return $default(_that.id,_that.name,_that.description,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Organization() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Organization implements Organization {
  const _Organization({required this.id, required this.name, this.description, @JsonKey(name: 'created_at') this.createdAt});
  factory _Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of Organization
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizationCopyWith<_Organization> get copyWith => __$OrganizationCopyWithImpl<_Organization>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrganizationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Organization&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt);

@override
String toString() {
  return 'Organization(id: $id, name: $name, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$OrganizationCopyWith<$Res> implements $OrganizationCopyWith<$Res> {
  factory _$OrganizationCopyWith(_Organization value, $Res Function(_Organization) _then) = __$OrganizationCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$OrganizationCopyWithImpl<$Res>
    implements _$OrganizationCopyWith<$Res> {
  __$OrganizationCopyWithImpl(this._self, this._then);

  final _Organization _self;
  final $Res Function(_Organization) _then;

/// Create a copy of Organization
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? createdAt = freezed,}) {
  return _then(_Organization(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Profile {

 String get id; String get name;@JsonKey(name: 'login_username') String? get loginUsername; ProfileType get type; String? get specialty;@JsonKey(name: 'organization_id') String? get organizationId;@JsonKey(name: 'access_level') String? get accessLevel; String get status;@JsonKey(name: 'created_at') DateTime? get createdAt; String? get email; double? get lat; double? get lng; String? get area; List<Map<String, Object?>> get notificacoes;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.loginUsername, loginUsername) || other.loginUsername == loginUsername)&&(identical(other.type, type) || other.type == type)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.accessLevel, accessLevel) || other.accessLevel == accessLevel)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.email, email) || other.email == email)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.area, area) || other.area == area)&&const DeepCollectionEquality().equals(other.notificacoes, notificacoes)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,loginUsername,type,specialty,organizationId,accessLevel,status,createdAt,email,lat,lng,area,const DeepCollectionEquality().hash(notificacoes),updatedAt);

@override
String toString() {
  return 'Profile(id: $id, name: $name, loginUsername: $loginUsername, type: $type, specialty: $specialty, organizationId: $organizationId, accessLevel: $accessLevel, status: $status, createdAt: $createdAt, email: $email, lat: $lat, lng: $lng, area: $area, notificacoes: $notificacoes, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res>  {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'login_username') String? loginUsername, ProfileType type, String? specialty,@JsonKey(name: 'organization_id') String? organizationId,@JsonKey(name: 'access_level') String? accessLevel, String status,@JsonKey(name: 'created_at') DateTime? createdAt, String? email, double? lat, double? lng, String? area, List<Map<String, Object?>> notificacoes,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? loginUsername = freezed,Object? type = null,Object? specialty = freezed,Object? organizationId = freezed,Object? accessLevel = freezed,Object? status = null,Object? createdAt = freezed,Object? email = freezed,Object? lat = freezed,Object? lng = freezed,Object? area = freezed,Object? notificacoes = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,loginUsername: freezed == loginUsername ? _self.loginUsername : loginUsername // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ProfileType,specialty: freezed == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String?,accessLevel: freezed == accessLevel ? _self.accessLevel : accessLevel // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,notificacoes: null == notificacoes ? _self.notificacoes : notificacoes // ignore: cast_nullable_to_non_nullable
as List<Map<String, Object?>>,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Profile].
extension ProfilePatterns on Profile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Profile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Profile value)  $default,){
final _that = this;
switch (_that) {
case _Profile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Profile value)?  $default,){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'login_username')  String? loginUsername,  ProfileType type,  String? specialty, @JsonKey(name: 'organization_id')  String? organizationId, @JsonKey(name: 'access_level')  String? accessLevel,  String status, @JsonKey(name: 'created_at')  DateTime? createdAt,  String? email,  double? lat,  double? lng,  String? area,  List<Map<String, Object?>> notificacoes, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.name,_that.loginUsername,_that.type,_that.specialty,_that.organizationId,_that.accessLevel,_that.status,_that.createdAt,_that.email,_that.lat,_that.lng,_that.area,_that.notificacoes,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'login_username')  String? loginUsername,  ProfileType type,  String? specialty, @JsonKey(name: 'organization_id')  String? organizationId, @JsonKey(name: 'access_level')  String? accessLevel,  String status, @JsonKey(name: 'created_at')  DateTime? createdAt,  String? email,  double? lat,  double? lng,  String? area,  List<Map<String, Object?>> notificacoes, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Profile():
return $default(_that.id,_that.name,_that.loginUsername,_that.type,_that.specialty,_that.organizationId,_that.accessLevel,_that.status,_that.createdAt,_that.email,_that.lat,_that.lng,_that.area,_that.notificacoes,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'login_username')  String? loginUsername,  ProfileType type,  String? specialty, @JsonKey(name: 'organization_id')  String? organizationId, @JsonKey(name: 'access_level')  String? accessLevel,  String status, @JsonKey(name: 'created_at')  DateTime? createdAt,  String? email,  double? lat,  double? lng,  String? area,  List<Map<String, Object?>> notificacoes, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.name,_that.loginUsername,_that.type,_that.specialty,_that.organizationId,_that.accessLevel,_that.status,_that.createdAt,_that.email,_that.lat,_that.lng,_that.area,_that.notificacoes,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Profile implements Profile {
  const _Profile({required this.id, required this.name, @JsonKey(name: 'login_username') this.loginUsername, this.type = ProfileType.user, this.specialty, @JsonKey(name: 'organization_id') this.organizationId, @JsonKey(name: 'access_level') this.accessLevel, this.status = 'ATIVO', @JsonKey(name: 'created_at') this.createdAt, this.email, this.lat, this.lng, this.area, final  List<Map<String, Object?>> notificacoes = const [], @JsonKey(name: 'updated_at') this.updatedAt}): _notificacoes = notificacoes;
  factory _Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'login_username') final  String? loginUsername;
@override@JsonKey() final  ProfileType type;
@override final  String? specialty;
@override@JsonKey(name: 'organization_id') final  String? organizationId;
@override@JsonKey(name: 'access_level') final  String? accessLevel;
@override@JsonKey() final  String status;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override final  String? email;
@override final  double? lat;
@override final  double? lng;
@override final  String? area;
 final  List<Map<String, Object?>> _notificacoes;
@override@JsonKey() List<Map<String, Object?>> get notificacoes {
  if (_notificacoes is EqualUnmodifiableListView) return _notificacoes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificacoes);
}

@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCopyWith<_Profile> get copyWith => __$ProfileCopyWithImpl<_Profile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Profile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.loginUsername, loginUsername) || other.loginUsername == loginUsername)&&(identical(other.type, type) || other.type == type)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.accessLevel, accessLevel) || other.accessLevel == accessLevel)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.email, email) || other.email == email)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.area, area) || other.area == area)&&const DeepCollectionEquality().equals(other._notificacoes, _notificacoes)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,loginUsername,type,specialty,organizationId,accessLevel,status,createdAt,email,lat,lng,area,const DeepCollectionEquality().hash(_notificacoes),updatedAt);

@override
String toString() {
  return 'Profile(id: $id, name: $name, loginUsername: $loginUsername, type: $type, specialty: $specialty, organizationId: $organizationId, accessLevel: $accessLevel, status: $status, createdAt: $createdAt, email: $email, lat: $lat, lng: $lng, area: $area, notificacoes: $notificacoes, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) = __$ProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'login_username') String? loginUsername, ProfileType type, String? specialty,@JsonKey(name: 'organization_id') String? organizationId,@JsonKey(name: 'access_level') String? accessLevel, String status,@JsonKey(name: 'created_at') DateTime? createdAt, String? email, double? lat, double? lng, String? area, List<Map<String, Object?>> notificacoes,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$ProfileCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? loginUsername = freezed,Object? type = null,Object? specialty = freezed,Object? organizationId = freezed,Object? accessLevel = freezed,Object? status = null,Object? createdAt = freezed,Object? email = freezed,Object? lat = freezed,Object? lng = freezed,Object? area = freezed,Object? notificacoes = null,Object? updatedAt = freezed,}) {
  return _then(_Profile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,loginUsername: freezed == loginUsername ? _self.loginUsername : loginUsername // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ProfileType,specialty: freezed == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String?,accessLevel: freezed == accessLevel ? _self.accessLevel : accessLevel // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,notificacoes: null == notificacoes ? _self._notificacoes : notificacoes // ignore: cast_nullable_to_non_nullable
as List<Map<String, Object?>>,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Article {

 String get id; String get title; String? get description; String? get category;@JsonKey(name: 'author_organization_id') String? get authorOrganizationId;@JsonKey(name: 'read_time_minutes') int? get readTimeMinutes; bool get featured; List<String> get tags;@JsonKey(name: 'image_url') String? get imageUrl; String? get content;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleCopyWith<Article> get copyWith => _$ArticleCopyWithImpl<Article>(this as Article, _$identity);

  /// Serializes this Article to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Article&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.authorOrganizationId, authorOrganizationId) || other.authorOrganizationId == authorOrganizationId)&&(identical(other.readTimeMinutes, readTimeMinutes) || other.readTimeMinutes == readTimeMinutes)&&(identical(other.featured, featured) || other.featured == featured)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,category,authorOrganizationId,readTimeMinutes,featured,const DeepCollectionEquality().hash(tags),imageUrl,content,createdAt);

@override
String toString() {
  return 'Article(id: $id, title: $title, description: $description, category: $category, authorOrganizationId: $authorOrganizationId, readTimeMinutes: $readTimeMinutes, featured: $featured, tags: $tags, imageUrl: $imageUrl, content: $content, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ArticleCopyWith<$Res>  {
  factory $ArticleCopyWith(Article value, $Res Function(Article) _then) = _$ArticleCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, String? category,@JsonKey(name: 'author_organization_id') String? authorOrganizationId,@JsonKey(name: 'read_time_minutes') int? readTimeMinutes, bool featured, List<String> tags,@JsonKey(name: 'image_url') String? imageUrl, String? content,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$ArticleCopyWithImpl<$Res>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._self, this._then);

  final Article _self;
  final $Res Function(Article) _then;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? category = freezed,Object? authorOrganizationId = freezed,Object? readTimeMinutes = freezed,Object? featured = null,Object? tags = null,Object? imageUrl = freezed,Object? content = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,authorOrganizationId: freezed == authorOrganizationId ? _self.authorOrganizationId : authorOrganizationId // ignore: cast_nullable_to_non_nullable
as String?,readTimeMinutes: freezed == readTimeMinutes ? _self.readTimeMinutes : readTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Article].
extension ArticlePatterns on Article {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Article value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Article value)  $default,){
final _that = this;
switch (_that) {
case _Article():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Article value)?  $default,){
final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? category, @JsonKey(name: 'author_organization_id')  String? authorOrganizationId, @JsonKey(name: 'read_time_minutes')  int? readTimeMinutes,  bool featured,  List<String> tags, @JsonKey(name: 'image_url')  String? imageUrl,  String? content, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.authorOrganizationId,_that.readTimeMinutes,_that.featured,_that.tags,_that.imageUrl,_that.content,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? category, @JsonKey(name: 'author_organization_id')  String? authorOrganizationId, @JsonKey(name: 'read_time_minutes')  int? readTimeMinutes,  bool featured,  List<String> tags, @JsonKey(name: 'image_url')  String? imageUrl,  String? content, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Article():
return $default(_that.id,_that.title,_that.description,_that.category,_that.authorOrganizationId,_that.readTimeMinutes,_that.featured,_that.tags,_that.imageUrl,_that.content,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  String? category, @JsonKey(name: 'author_organization_id')  String? authorOrganizationId, @JsonKey(name: 'read_time_minutes')  int? readTimeMinutes,  bool featured,  List<String> tags, @JsonKey(name: 'image_url')  String? imageUrl,  String? content, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.authorOrganizationId,_that.readTimeMinutes,_that.featured,_that.tags,_that.imageUrl,_that.content,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Article implements Article {
  const _Article({required this.id, required this.title, this.description, this.category, @JsonKey(name: 'author_organization_id') this.authorOrganizationId, @JsonKey(name: 'read_time_minutes') this.readTimeMinutes, this.featured = false, final  List<String> tags = const [], @JsonKey(name: 'image_url') this.imageUrl, this.content, @JsonKey(name: 'created_at') this.createdAt}): _tags = tags;
  factory _Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  String? category;
@override@JsonKey(name: 'author_organization_id') final  String? authorOrganizationId;
@override@JsonKey(name: 'read_time_minutes') final  int? readTimeMinutes;
@override@JsonKey() final  bool featured;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override final  String? content;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleCopyWith<_Article> get copyWith => __$ArticleCopyWithImpl<_Article>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Article&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.authorOrganizationId, authorOrganizationId) || other.authorOrganizationId == authorOrganizationId)&&(identical(other.readTimeMinutes, readTimeMinutes) || other.readTimeMinutes == readTimeMinutes)&&(identical(other.featured, featured) || other.featured == featured)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,category,authorOrganizationId,readTimeMinutes,featured,const DeepCollectionEquality().hash(_tags),imageUrl,content,createdAt);

@override
String toString() {
  return 'Article(id: $id, title: $title, description: $description, category: $category, authorOrganizationId: $authorOrganizationId, readTimeMinutes: $readTimeMinutes, featured: $featured, tags: $tags, imageUrl: $imageUrl, content: $content, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$ArticleCopyWith(_Article value, $Res Function(_Article) _then) = __$ArticleCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, String? category,@JsonKey(name: 'author_organization_id') String? authorOrganizationId,@JsonKey(name: 'read_time_minutes') int? readTimeMinutes, bool featured, List<String> tags,@JsonKey(name: 'image_url') String? imageUrl, String? content,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$ArticleCopyWithImpl<$Res>
    implements _$ArticleCopyWith<$Res> {
  __$ArticleCopyWithImpl(this._self, this._then);

  final _Article _self;
  final $Res Function(_Article) _then;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? category = freezed,Object? authorOrganizationId = freezed,Object? readTimeMinutes = freezed,Object? featured = null,Object? tags = null,Object? imageUrl = freezed,Object? content = freezed,Object? createdAt = freezed,}) {
  return _then(_Article(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,authorOrganizationId: freezed == authorOrganizationId ? _self.authorOrganizationId : authorOrganizationId // ignore: cast_nullable_to_non_nullable
as String?,readTimeMinutes: freezed == readTimeMinutes ? _self.readTimeMinutes : readTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Alert {

 String get id;@JsonKey(name: 'ticket_code') String get ticketCode;@JsonKey(name: 'anonymous_user_ref') String? get anonymousUserRef;@JsonKey(name: 'user_id') String? get userId;@JsonKey(name: 'location_name') String? get locationName; double? get latitude; double? get longitude; AlertStatus get status; RiskLevel get risk; AlertType get type;@JsonKey(name: 'assigned_to') String? get assignedTo;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of Alert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertCopyWith<Alert> get copyWith => _$AlertCopyWithImpl<Alert>(this as Alert, _$identity);

  /// Serializes this Alert to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Alert&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketCode, ticketCode) || other.ticketCode == ticketCode)&&(identical(other.anonymousUserRef, anonymousUserRef) || other.anonymousUserRef == anonymousUserRef)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.status, status) || other.status == status)&&(identical(other.risk, risk) || other.risk == risk)&&(identical(other.type, type) || other.type == type)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ticketCode,anonymousUserRef,userId,locationName,latitude,longitude,status,risk,type,assignedTo,createdAt,updatedAt);

@override
String toString() {
  return 'Alert(id: $id, ticketCode: $ticketCode, anonymousUserRef: $anonymousUserRef, userId: $userId, locationName: $locationName, latitude: $latitude, longitude: $longitude, status: $status, risk: $risk, type: $type, assignedTo: $assignedTo, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AlertCopyWith<$Res>  {
  factory $AlertCopyWith(Alert value, $Res Function(Alert) _then) = _$AlertCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'ticket_code') String ticketCode,@JsonKey(name: 'anonymous_user_ref') String? anonymousUserRef,@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'location_name') String? locationName, double? latitude, double? longitude, AlertStatus status, RiskLevel risk, AlertType type,@JsonKey(name: 'assigned_to') String? assignedTo,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$AlertCopyWithImpl<$Res>
    implements $AlertCopyWith<$Res> {
  _$AlertCopyWithImpl(this._self, this._then);

  final Alert _self;
  final $Res Function(Alert) _then;

/// Create a copy of Alert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ticketCode = null,Object? anonymousUserRef = freezed,Object? userId = freezed,Object? locationName = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? status = null,Object? risk = null,Object? type = null,Object? assignedTo = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ticketCode: null == ticketCode ? _self.ticketCode : ticketCode // ignore: cast_nullable_to_non_nullable
as String,anonymousUserRef: freezed == anonymousUserRef ? _self.anonymousUserRef : anonymousUserRef // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AlertStatus,risk: null == risk ? _self.risk : risk // ignore: cast_nullable_to_non_nullable
as RiskLevel,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AlertType,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Alert].
extension AlertPatterns on Alert {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Alert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Alert() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Alert value)  $default,){
final _that = this;
switch (_that) {
case _Alert():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Alert value)?  $default,){
final _that = this;
switch (_that) {
case _Alert() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'ticket_code')  String ticketCode, @JsonKey(name: 'anonymous_user_ref')  String? anonymousUserRef, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'location_name')  String? locationName,  double? latitude,  double? longitude,  AlertStatus status,  RiskLevel risk,  AlertType type, @JsonKey(name: 'assigned_to')  String? assignedTo, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Alert() when $default != null:
return $default(_that.id,_that.ticketCode,_that.anonymousUserRef,_that.userId,_that.locationName,_that.latitude,_that.longitude,_that.status,_that.risk,_that.type,_that.assignedTo,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'ticket_code')  String ticketCode, @JsonKey(name: 'anonymous_user_ref')  String? anonymousUserRef, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'location_name')  String? locationName,  double? latitude,  double? longitude,  AlertStatus status,  RiskLevel risk,  AlertType type, @JsonKey(name: 'assigned_to')  String? assignedTo, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Alert():
return $default(_that.id,_that.ticketCode,_that.anonymousUserRef,_that.userId,_that.locationName,_that.latitude,_that.longitude,_that.status,_that.risk,_that.type,_that.assignedTo,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'ticket_code')  String ticketCode, @JsonKey(name: 'anonymous_user_ref')  String? anonymousUserRef, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'location_name')  String? locationName,  double? latitude,  double? longitude,  AlertStatus status,  RiskLevel risk,  AlertType type, @JsonKey(name: 'assigned_to')  String? assignedTo, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Alert() when $default != null:
return $default(_that.id,_that.ticketCode,_that.anonymousUserRef,_that.userId,_that.locationName,_that.latitude,_that.longitude,_that.status,_that.risk,_that.type,_that.assignedTo,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Alert implements Alert {
  const _Alert({required this.id, @JsonKey(name: 'ticket_code') required this.ticketCode, @JsonKey(name: 'anonymous_user_ref') this.anonymousUserRef, @JsonKey(name: 'user_id') this.userId, @JsonKey(name: 'location_name') this.locationName, this.latitude, this.longitude, this.status = AlertStatus.ativo, this.risk = RiskLevel.baixo, this.type = AlertType.map, @JsonKey(name: 'assigned_to') this.assignedTo, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);

@override final  String id;
@override@JsonKey(name: 'ticket_code') final  String ticketCode;
@override@JsonKey(name: 'anonymous_user_ref') final  String? anonymousUserRef;
@override@JsonKey(name: 'user_id') final  String? userId;
@override@JsonKey(name: 'location_name') final  String? locationName;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey() final  AlertStatus status;
@override@JsonKey() final  RiskLevel risk;
@override@JsonKey() final  AlertType type;
@override@JsonKey(name: 'assigned_to') final  String? assignedTo;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of Alert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertCopyWith<_Alert> get copyWith => __$AlertCopyWithImpl<_Alert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Alert&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketCode, ticketCode) || other.ticketCode == ticketCode)&&(identical(other.anonymousUserRef, anonymousUserRef) || other.anonymousUserRef == anonymousUserRef)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.status, status) || other.status == status)&&(identical(other.risk, risk) || other.risk == risk)&&(identical(other.type, type) || other.type == type)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ticketCode,anonymousUserRef,userId,locationName,latitude,longitude,status,risk,type,assignedTo,createdAt,updatedAt);

@override
String toString() {
  return 'Alert(id: $id, ticketCode: $ticketCode, anonymousUserRef: $anonymousUserRef, userId: $userId, locationName: $locationName, latitude: $latitude, longitude: $longitude, status: $status, risk: $risk, type: $type, assignedTo: $assignedTo, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AlertCopyWith<$Res> implements $AlertCopyWith<$Res> {
  factory _$AlertCopyWith(_Alert value, $Res Function(_Alert) _then) = __$AlertCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'ticket_code') String ticketCode,@JsonKey(name: 'anonymous_user_ref') String? anonymousUserRef,@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'location_name') String? locationName, double? latitude, double? longitude, AlertStatus status, RiskLevel risk, AlertType type,@JsonKey(name: 'assigned_to') String? assignedTo,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$AlertCopyWithImpl<$Res>
    implements _$AlertCopyWith<$Res> {
  __$AlertCopyWithImpl(this._self, this._then);

  final _Alert _self;
  final $Res Function(_Alert) _then;

/// Create a copy of Alert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ticketCode = null,Object? anonymousUserRef = freezed,Object? userId = freezed,Object? locationName = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? status = null,Object? risk = null,Object? type = null,Object? assignedTo = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Alert(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ticketCode: null == ticketCode ? _self.ticketCode : ticketCode // ignore: cast_nullable_to_non_nullable
as String,anonymousUserRef: freezed == anonymousUserRef ? _self.anonymousUserRef : anonymousUserRef // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AlertStatus,risk: null == risk ? _self.risk : risk // ignore: cast_nullable_to_non_nullable
as RiskLevel,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AlertType,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$AlertLog {

 String get id;@JsonKey(name: 'alert_id') String? get alertId;@JsonKey(name: 'log_message') String get logMessage;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of AlertLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertLogCopyWith<AlertLog> get copyWith => _$AlertLogCopyWithImpl<AlertLog>(this as AlertLog, _$identity);

  /// Serializes this AlertLog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlertLog&&(identical(other.id, id) || other.id == id)&&(identical(other.alertId, alertId) || other.alertId == alertId)&&(identical(other.logMessage, logMessage) || other.logMessage == logMessage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,alertId,logMessage,createdAt);

@override
String toString() {
  return 'AlertLog(id: $id, alertId: $alertId, logMessage: $logMessage, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AlertLogCopyWith<$Res>  {
  factory $AlertLogCopyWith(AlertLog value, $Res Function(AlertLog) _then) = _$AlertLogCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'alert_id') String? alertId,@JsonKey(name: 'log_message') String logMessage,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$AlertLogCopyWithImpl<$Res>
    implements $AlertLogCopyWith<$Res> {
  _$AlertLogCopyWithImpl(this._self, this._then);

  final AlertLog _self;
  final $Res Function(AlertLog) _then;

/// Create a copy of AlertLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? alertId = freezed,Object? logMessage = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,alertId: freezed == alertId ? _self.alertId : alertId // ignore: cast_nullable_to_non_nullable
as String?,logMessage: null == logMessage ? _self.logMessage : logMessage // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AlertLog].
extension AlertLogPatterns on AlertLog {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlertLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlertLog() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlertLog value)  $default,){
final _that = this;
switch (_that) {
case _AlertLog():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlertLog value)?  $default,){
final _that = this;
switch (_that) {
case _AlertLog() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'alert_id')  String? alertId, @JsonKey(name: 'log_message')  String logMessage, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlertLog() when $default != null:
return $default(_that.id,_that.alertId,_that.logMessage,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'alert_id')  String? alertId, @JsonKey(name: 'log_message')  String logMessage, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AlertLog():
return $default(_that.id,_that.alertId,_that.logMessage,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'alert_id')  String? alertId, @JsonKey(name: 'log_message')  String logMessage, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AlertLog() when $default != null:
return $default(_that.id,_that.alertId,_that.logMessage,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlertLog implements AlertLog {
  const _AlertLog({required this.id, @JsonKey(name: 'alert_id') this.alertId, @JsonKey(name: 'log_message') required this.logMessage, @JsonKey(name: 'created_at') this.createdAt});
  factory _AlertLog.fromJson(Map<String, dynamic> json) => _$AlertLogFromJson(json);

@override final  String id;
@override@JsonKey(name: 'alert_id') final  String? alertId;
@override@JsonKey(name: 'log_message') final  String logMessage;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of AlertLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertLogCopyWith<_AlertLog> get copyWith => __$AlertLogCopyWithImpl<_AlertLog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlertLogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlertLog&&(identical(other.id, id) || other.id == id)&&(identical(other.alertId, alertId) || other.alertId == alertId)&&(identical(other.logMessage, logMessage) || other.logMessage == logMessage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,alertId,logMessage,createdAt);

@override
String toString() {
  return 'AlertLog(id: $id, alertId: $alertId, logMessage: $logMessage, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AlertLogCopyWith<$Res> implements $AlertLogCopyWith<$Res> {
  factory _$AlertLogCopyWith(_AlertLog value, $Res Function(_AlertLog) _then) = __$AlertLogCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'alert_id') String? alertId,@JsonKey(name: 'log_message') String logMessage,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$AlertLogCopyWithImpl<$Res>
    implements _$AlertLogCopyWith<$Res> {
  __$AlertLogCopyWithImpl(this._self, this._then);

  final _AlertLog _self;
  final $Res Function(_AlertLog) _then;

/// Create a copy of AlertLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? alertId = freezed,Object? logMessage = null,Object? createdAt = freezed,}) {
  return _then(_AlertLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,alertId: freezed == alertId ? _self.alertId : alertId // ignore: cast_nullable_to_non_nullable
as String?,logMessage: null == logMessage ? _self.logMessage : logMessage // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ChatMessage {

 String get id;@JsonKey(name: 'alert_id') String? get alertId;@JsonKey(name: 'sender_id') String? get senderId;@JsonKey(name: 'is_anonymous_victim') bool get isAnonymousVictim; String get message;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.alertId, alertId) || other.alertId == alertId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.isAnonymousVictim, isAnonymousVictim) || other.isAnonymousVictim == isAnonymousVictim)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,alertId,senderId,isAnonymousVictim,message,createdAt);

@override
String toString() {
  return 'ChatMessage(id: $id, alertId: $alertId, senderId: $senderId, isAnonymousVictim: $isAnonymousVictim, message: $message, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'alert_id') String? alertId,@JsonKey(name: 'sender_id') String? senderId,@JsonKey(name: 'is_anonymous_victim') bool isAnonymousVictim, String message,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? alertId = freezed,Object? senderId = freezed,Object? isAnonymousVictim = null,Object? message = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,alertId: freezed == alertId ? _self.alertId : alertId // ignore: cast_nullable_to_non_nullable
as String?,senderId: freezed == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String?,isAnonymousVictim: null == isAnonymousVictim ? _self.isAnonymousVictim : isAnonymousVictim // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'alert_id')  String? alertId, @JsonKey(name: 'sender_id')  String? senderId, @JsonKey(name: 'is_anonymous_victim')  bool isAnonymousVictim,  String message, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.alertId,_that.senderId,_that.isAnonymousVictim,_that.message,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'alert_id')  String? alertId, @JsonKey(name: 'sender_id')  String? senderId, @JsonKey(name: 'is_anonymous_victim')  bool isAnonymousVictim,  String message, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.alertId,_that.senderId,_that.isAnonymousVictim,_that.message,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'alert_id')  String? alertId, @JsonKey(name: 'sender_id')  String? senderId, @JsonKey(name: 'is_anonymous_victim')  bool isAnonymousVictim,  String message, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.alertId,_that.senderId,_that.isAnonymousVictim,_that.message,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessage implements ChatMessage {
  const _ChatMessage({required this.id, @JsonKey(name: 'alert_id') this.alertId, @JsonKey(name: 'sender_id') this.senderId, @JsonKey(name: 'is_anonymous_victim') this.isAnonymousVictim = false, required this.message, @JsonKey(name: 'created_at') this.createdAt});
  factory _ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

@override final  String id;
@override@JsonKey(name: 'alert_id') final  String? alertId;
@override@JsonKey(name: 'sender_id') final  String? senderId;
@override@JsonKey(name: 'is_anonymous_victim') final  bool isAnonymousVictim;
@override final  String message;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.alertId, alertId) || other.alertId == alertId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.isAnonymousVictim, isAnonymousVictim) || other.isAnonymousVictim == isAnonymousVictim)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,alertId,senderId,isAnonymousVictim,message,createdAt);

@override
String toString() {
  return 'ChatMessage(id: $id, alertId: $alertId, senderId: $senderId, isAnonymousVictim: $isAnonymousVictim, message: $message, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'alert_id') String? alertId,@JsonKey(name: 'sender_id') String? senderId,@JsonKey(name: 'is_anonymous_victim') bool isAnonymousVictim, String message,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? alertId = freezed,Object? senderId = freezed,Object? isAnonymousVictim = null,Object? message = null,Object? createdAt = freezed,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,alertId: freezed == alertId ? _self.alertId : alertId // ignore: cast_nullable_to_non_nullable
as String?,senderId: freezed == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String?,isAnonymousVictim: null == isAnonymousVictim ? _self.isAnonymousVictim : isAnonymousVictim // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
