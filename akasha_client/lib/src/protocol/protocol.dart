/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'access_level/access_level.dart' as _i2;
import 'access_level/access_level_api_resp.dart' as _i3;
import 'attribute/bool_attr.dart' as _i4;
import 'attribute/date_attr.dart' as _i5;
import 'attribute/datetime_attr.dart' as _i6;
import 'attribute/number_attr.dart' as _i7;
import 'attribute/text_attr.dart' as _i8;
import 'attribute/attr.dart' as _i9;
import 'attribute_template/attr_tmpl.dart' as _i10;
import 'attribute_template/attr_tmpl_api_resp.dart' as _i11;
import 'entity/ent_links.dart' as _i12;
import 'entity/entity.dart' as _i13;
import 'entity_template/entity_tmpl.dart' as _i14;
import 'entity_template/entity_tmpl_api_resp.dart' as _i15;
import 'entity_template/entity_tmpl_attribute.dart' as _i16;
import 'entity_template/entity_tmpl_link.dart' as _i17;
import 'shared/api/exceptions/api_exception.dart' as _i18;
import 'shared/model/has_id.dart' as _i19;
import 'shared/model/value_type.dart' as _i20;
import 'package:akasha_client/src/protocol/access_level/access_level.dart'
    as _i21;
import 'package:akasha_client/src/protocol/attribute_template/attr_tmpl.dart'
    as _i22;
import 'package:akasha_client/src/protocol/entity_template/entity_tmpl.dart'
    as _i23;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i24;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i25;
export 'access_level/access_level.dart';
export 'access_level/access_level_api_resp.dart';
export 'attribute/bool_attr.dart';
export 'attribute/date_attr.dart';
export 'attribute/datetime_attr.dart';
export 'attribute/number_attr.dart';
export 'attribute/text_attr.dart';
export 'attribute/attr.dart';
export 'attribute_template/attr_tmpl.dart';
export 'attribute_template/attr_tmpl_api_resp.dart';
export 'entity/ent_links.dart';
export 'entity/entity.dart';
export 'entity_template/entity_tmpl.dart';
export 'entity_template/entity_tmpl_api_resp.dart';
export 'entity_template/entity_tmpl_attribute.dart';
export 'entity_template/entity_tmpl_link.dart';
export 'shared/api/exceptions/api_exception.dart';
export 'shared/model/has_id.dart';
export 'shared/model/value_type.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.AccessLevel) {
      return _i2.AccessLevel.fromJson(data) as T;
    }
    if (t == _i3.AccessLevelApiResponse) {
      return _i3.AccessLevelApiResponse.fromJson(data) as T;
    }
    if (t == _i4.BoolAttribute) {
      return _i4.BoolAttribute.fromJson(data) as T;
    }
    if (t == _i5.DateAttribute) {
      return _i5.DateAttribute.fromJson(data) as T;
    }
    if (t == _i6.DateTimeAttribute) {
      return _i6.DateTimeAttribute.fromJson(data) as T;
    }
    if (t == _i7.NumberAttribute) {
      return _i7.NumberAttribute.fromJson(data) as T;
    }
    if (t == _i8.TextAttribute) {
      return _i8.TextAttribute.fromJson(data) as T;
    }
    if (t == _i9.Attribute) {
      return _i9.Attribute.fromJson(data) as T;
    }
    if (t == _i10.AttributeTmpl) {
      return _i10.AttributeTmpl.fromJson(data) as T;
    }
    if (t == _i11.AttributeTmplApiResponse) {
      return _i11.AttributeTmplApiResponse.fromJson(data) as T;
    }
    if (t == _i12.EntityLink) {
      return _i12.EntityLink.fromJson(data) as T;
    }
    if (t == _i13.Entity) {
      return _i13.Entity.fromJson(data) as T;
    }
    if (t == _i14.EntityTmpl) {
      return _i14.EntityTmpl.fromJson(data) as T;
    }
    if (t == _i15.EntityTmplApiResponse) {
      return _i15.EntityTmplApiResponse.fromJson(data) as T;
    }
    if (t == _i16.EntityTmplAttribute) {
      return _i16.EntityTmplAttribute.fromJson(data) as T;
    }
    if (t == _i17.EntityTmplLink) {
      return _i17.EntityTmplLink.fromJson(data) as T;
    }
    if (t == _i18.ApiException) {
      return _i18.ApiException.fromJson(data) as T;
    }
    if (t == _i19.HasId) {
      return _i19.HasId.fromJson(data) as T;
    }
    if (t == _i20.ValueType) {
      return _i20.ValueType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AccessLevel?>()) {
      return (data != null ? _i2.AccessLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AccessLevelApiResponse?>()) {
      return (data != null ? _i3.AccessLevelApiResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.BoolAttribute?>()) {
      return (data != null ? _i4.BoolAttribute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.DateAttribute?>()) {
      return (data != null ? _i5.DateAttribute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.DateTimeAttribute?>()) {
      return (data != null ? _i6.DateTimeAttribute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.NumberAttribute?>()) {
      return (data != null ? _i7.NumberAttribute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.TextAttribute?>()) {
      return (data != null ? _i8.TextAttribute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Attribute?>()) {
      return (data != null ? _i9.Attribute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AttributeTmpl?>()) {
      return (data != null ? _i10.AttributeTmpl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.AttributeTmplApiResponse?>()) {
      return (data != null
              ? _i11.AttributeTmplApiResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i12.EntityLink?>()) {
      return (data != null ? _i12.EntityLink.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Entity?>()) {
      return (data != null ? _i13.Entity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.EntityTmpl?>()) {
      return (data != null ? _i14.EntityTmpl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.EntityTmplApiResponse?>()) {
      return (data != null ? _i15.EntityTmplApiResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.EntityTmplAttribute?>()) {
      return (data != null ? _i16.EntityTmplAttribute.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.EntityTmplLink?>()) {
      return (data != null ? _i17.EntityTmplLink.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.ApiException?>()) {
      return (data != null ? _i18.ApiException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.HasId?>()) {
      return (data != null ? _i19.HasId.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.ValueType?>()) {
      return (data != null ? _i20.ValueType.fromJson(data) : null) as T;
    }
    if (t == List<(int, String)>) {
      return (data as List).map((e) => deserialize<(int, String)>(e)).toList()
          as T;
    }
    if (t == _i1.getType<(int, String)>()) {
      return (
            deserialize<int>(((data as Map)['p'] as List)[0]),
            deserialize<String>(data['p'][1]),
          )
          as T;
    }
    if (t == List<_i8.TextAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i8.TextAttribute>(e))
              .toList()
          as T;
    }
    if (t == List<_i7.NumberAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i7.NumberAttribute>(e))
              .toList()
          as T;
    }
    if (t == List<_i4.BoolAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i4.BoolAttribute>(e))
              .toList()
          as T;
    }
    if (t == List<_i5.DateAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i5.DateAttribute>(e))
              .toList()
          as T;
    }
    if (t == List<_i6.DateTimeAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i6.DateTimeAttribute>(e))
              .toList()
          as T;
    }
    if (t == List<_i12.EntityLink>) {
      return (data as List).map((e) => deserialize<_i12.EntityLink>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i12.EntityLink>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i12.EntityLink>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i16.EntityTmplAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i16.EntityTmplAttribute>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i16.EntityTmplAttribute>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i16.EntityTmplAttribute>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i17.EntityTmplLink>) {
      return (data as List)
              .map((e) => deserialize<_i17.EntityTmplLink>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i17.EntityTmplLink>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i17.EntityTmplLink>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i21.AccessLevel>) {
      return (data as List)
              .map((e) => deserialize<_i21.AccessLevel>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.AttributeTmpl>) {
      return (data as List)
              .map((e) => deserialize<_i22.AttributeTmpl>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.EntityTmpl>) {
      return (data as List).map((e) => deserialize<_i23.EntityTmpl>(e)).toList()
          as T;
    }
    if (t == _i1.getType<(int, String)>()) {
      return (
            deserialize<int>(((data as Map)['p'] as List)[0]),
            deserialize<String>(data['p'][1]),
          )
          as T;
    }
    if (t == _i1.getType<(int, String)>()) {
      return (
            deserialize<int>(((data as Map)['p'] as List)[0]),
            deserialize<String>(data['p'][1]),
          )
          as T;
    }
    try {
      return _i24.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i25.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AccessLevel => 'AccessLevel',
      _i3.AccessLevelApiResponse => 'AccessLevelApiResponse',
      _i4.BoolAttribute => 'BoolAttribute',
      _i5.DateAttribute => 'DateAttribute',
      _i6.DateTimeAttribute => 'DateTimeAttribute',
      _i7.NumberAttribute => 'NumberAttribute',
      _i8.TextAttribute => 'TextAttribute',
      _i9.Attribute => 'Attribute',
      _i10.AttributeTmpl => 'AttributeTmpl',
      _i11.AttributeTmplApiResponse => 'AttributeTmplApiResponse',
      _i12.EntityLink => 'EntityLink',
      _i13.Entity => 'Entity',
      _i14.EntityTmpl => 'EntityTmpl',
      _i15.EntityTmplApiResponse => 'EntityTmplApiResponse',
      _i16.EntityTmplAttribute => 'EntityTmplAttribute',
      _i17.EntityTmplLink => 'EntityTmplLink',
      _i18.ApiException => 'ApiException',
      _i19.HasId => 'HasId',
      _i20.ValueType => 'ValueType',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('akasha.', '');
    }

    switch (data) {
      case _i2.AccessLevel():
        return 'AccessLevel';
      case _i3.AccessLevelApiResponse():
        return 'AccessLevelApiResponse';
      case _i4.BoolAttribute():
        return 'BoolAttribute';
      case _i5.DateAttribute():
        return 'DateAttribute';
      case _i6.DateTimeAttribute():
        return 'DateTimeAttribute';
      case _i7.NumberAttribute():
        return 'NumberAttribute';
      case _i8.TextAttribute():
        return 'TextAttribute';
      case _i9.Attribute():
        return 'Attribute';
      case _i10.AttributeTmpl():
        return 'AttributeTmpl';
      case _i11.AttributeTmplApiResponse():
        return 'AttributeTmplApiResponse';
      case _i12.EntityLink():
        return 'EntityLink';
      case _i13.Entity():
        return 'Entity';
      case _i14.EntityTmpl():
        return 'EntityTmpl';
      case _i15.EntityTmplApiResponse():
        return 'EntityTmplApiResponse';
      case _i16.EntityTmplAttribute():
        return 'EntityTmplAttribute';
      case _i17.EntityTmplLink():
        return 'EntityTmplLink';
      case _i18.ApiException():
        return 'ApiException';
      case _i19.HasId():
        return 'HasId';
      case _i20.ValueType():
        return 'ValueType';
    }
    className = _i24.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i25.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AccessLevel') {
      return deserialize<_i2.AccessLevel>(data['data']);
    }
    if (dataClassName == 'AccessLevelApiResponse') {
      return deserialize<_i3.AccessLevelApiResponse>(data['data']);
    }
    if (dataClassName == 'BoolAttribute') {
      return deserialize<_i4.BoolAttribute>(data['data']);
    }
    if (dataClassName == 'DateAttribute') {
      return deserialize<_i5.DateAttribute>(data['data']);
    }
    if (dataClassName == 'DateTimeAttribute') {
      return deserialize<_i6.DateTimeAttribute>(data['data']);
    }
    if (dataClassName == 'NumberAttribute') {
      return deserialize<_i7.NumberAttribute>(data['data']);
    }
    if (dataClassName == 'TextAttribute') {
      return deserialize<_i8.TextAttribute>(data['data']);
    }
    if (dataClassName == 'Attribute') {
      return deserialize<_i9.Attribute>(data['data']);
    }
    if (dataClassName == 'AttributeTmpl') {
      return deserialize<_i10.AttributeTmpl>(data['data']);
    }
    if (dataClassName == 'AttributeTmplApiResponse') {
      return deserialize<_i11.AttributeTmplApiResponse>(data['data']);
    }
    if (dataClassName == 'EntityLink') {
      return deserialize<_i12.EntityLink>(data['data']);
    }
    if (dataClassName == 'Entity') {
      return deserialize<_i13.Entity>(data['data']);
    }
    if (dataClassName == 'EntityTmpl') {
      return deserialize<_i14.EntityTmpl>(data['data']);
    }
    if (dataClassName == 'EntityTmplApiResponse') {
      return deserialize<_i15.EntityTmplApiResponse>(data['data']);
    }
    if (dataClassName == 'EntityTmplAttribute') {
      return deserialize<_i16.EntityTmplAttribute>(data['data']);
    }
    if (dataClassName == 'EntityTmplLink') {
      return deserialize<_i17.EntityTmplLink>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_i18.ApiException>(data['data']);
    }
    if (dataClassName == 'HasId') {
      return deserialize<_i19.HasId>(data['data']);
    }
    if (dataClassName == 'ValueType') {
      return deserialize<_i20.ValueType>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i24.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i25.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    if (record is (int, String)) {
      return {
        "p": [
          record.$1,
          record.$2,
        ],
      };
    }
    try {
      return _i24.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i25.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }

  /// Maps container types (like [List], [Map], [Set]) containing
  /// [Record]s or non-String-keyed [Map]s to their JSON representation.
  ///
  /// It should not be called for [SerializableModel] types. These
  /// handle the "[Record] in container" mapping internally already.
  ///
  /// It is only supposed to be called from generated protocol code.
  ///
  /// Returns either a `List<dynamic>` (for List, Sets, and Maps with
  /// non-String keys) or a `Map<String, dynamic>` in case the input was
  /// a `Map<String, …>`.
  Object? mapContainerToJson(Object obj) {
    if (obj is! Iterable && obj is! Map) {
      throw ArgumentError.value(
        obj,
        'obj',
        'The object to serialize should be of type List, Map, or Set',
      );
    }

    dynamic mapIfNeeded(Object? obj) {
      return switch (obj) {
        Record record => mapRecordToJson(record),
        Iterable iterable => mapContainerToJson(iterable),
        Map map => mapContainerToJson(map),
        Object? value => value,
      };
    }

    switch (obj) {
      case Map<String, dynamic>():
        return {
          for (var entry in obj.entries) entry.key: mapIfNeeded(entry.value),
        };
      case Map():
        return [
          for (var entry in obj.entries)
            {
              'k': mapIfNeeded(entry.key),
              'v': mapIfNeeded(entry.value),
            },
        ];

      case Iterable():
        return [
          for (var e in obj) mapIfNeeded(e),
        ];
    }

    return obj;
  }
}
