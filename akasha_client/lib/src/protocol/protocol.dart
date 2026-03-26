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
import 'attribute_template/attr_tmpl.dart' as _i4;
import 'attribute_template/attr_tmpl_api_resp.dart' as _i5;
import 'entity_template/entity_link_tmpl.dart' as _i6;
import 'entity_template/entity_tmpl.dart' as _i7;
import 'entity_template/entity_tmpl_api_resp.dart' as _i8;
import 'entity_template/entity_tmpl_attribute.dart' as _i9;
import 'shared/api/exceptions/api_exception.dart' as _i10;
import 'package:akasha_client/src/protocol/access_level/access_level.dart'
    as _i11;
import 'package:akasha_client/src/protocol/attribute_template/attr_tmpl.dart'
    as _i12;
import 'package:akasha_client/src/protocol/entity_template/entity_tmpl.dart'
    as _i13;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i14;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i15;
export 'access_level/access_level.dart';
export 'access_level/access_level_api_resp.dart';
export 'attribute_template/attr_tmpl.dart';
export 'attribute_template/attr_tmpl_api_resp.dart';
export 'entity_template/entity_link_tmpl.dart';
export 'entity_template/entity_tmpl.dart';
export 'entity_template/entity_tmpl_api_resp.dart';
export 'entity_template/entity_tmpl_attribute.dart';
export 'shared/api/exceptions/api_exception.dart';
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
    if (t == _i4.AttributeTmpl) {
      return _i4.AttributeTmpl.fromJson(data) as T;
    }
    if (t == _i5.AttributeTmplApiResponse) {
      return _i5.AttributeTmplApiResponse.fromJson(data) as T;
    }
    if (t == _i6.EntityTmplLink) {
      return _i6.EntityTmplLink.fromJson(data) as T;
    }
    if (t == _i7.EntityTmpl) {
      return _i7.EntityTmpl.fromJson(data) as T;
    }
    if (t == _i8.EntityTmplApiResponse) {
      return _i8.EntityTmplApiResponse.fromJson(data) as T;
    }
    if (t == _i9.EntityTmplAttribute) {
      return _i9.EntityTmplAttribute.fromJson(data) as T;
    }
    if (t == _i10.ApiException) {
      return _i10.ApiException.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AccessLevel?>()) {
      return (data != null ? _i2.AccessLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AccessLevelApiResponse?>()) {
      return (data != null ? _i3.AccessLevelApiResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.AttributeTmpl?>()) {
      return (data != null ? _i4.AttributeTmpl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AttributeTmplApiResponse?>()) {
      return (data != null ? _i5.AttributeTmplApiResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.EntityTmplLink?>()) {
      return (data != null ? _i6.EntityTmplLink.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.EntityTmpl?>()) {
      return (data != null ? _i7.EntityTmpl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.EntityTmplApiResponse?>()) {
      return (data != null ? _i8.EntityTmplApiResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.EntityTmplAttribute?>()) {
      return (data != null ? _i9.EntityTmplAttribute.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.ApiException?>()) {
      return (data != null ? _i10.ApiException.fromJson(data) : null) as T;
    }
    if (t == List<_i9.EntityTmplAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i9.EntityTmplAttribute>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i9.EntityTmplAttribute>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i9.EntityTmplAttribute>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i6.EntityTmplLink>) {
      return (data as List)
              .map((e) => deserialize<_i6.EntityTmplLink>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i6.EntityTmplLink>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i6.EntityTmplLink>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i11.AccessLevel>) {
      return (data as List)
              .map((e) => deserialize<_i11.AccessLevel>(e))
              .toList()
          as T;
    }
    if (t == List<_i12.AttributeTmpl>) {
      return (data as List)
              .map((e) => deserialize<_i12.AttributeTmpl>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.EntityTmpl>) {
      return (data as List).map((e) => deserialize<_i13.EntityTmpl>(e)).toList()
          as T;
    }
    try {
      return _i14.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i15.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AccessLevel => 'AccessLevel',
      _i3.AccessLevelApiResponse => 'AccessLevelApiResponse',
      _i4.AttributeTmpl => 'AttributeTmpl',
      _i5.AttributeTmplApiResponse => 'AttributeTmplApiResponse',
      _i6.EntityTmplLink => 'EntityTmplLink',
      _i7.EntityTmpl => 'EntityTmpl',
      _i8.EntityTmplApiResponse => 'EntityTmplApiResponse',
      _i9.EntityTmplAttribute => 'EntityTmplAttribute',
      _i10.ApiException => 'ApiException',
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
      case _i4.AttributeTmpl():
        return 'AttributeTmpl';
      case _i5.AttributeTmplApiResponse():
        return 'AttributeTmplApiResponse';
      case _i6.EntityTmplLink():
        return 'EntityTmplLink';
      case _i7.EntityTmpl():
        return 'EntityTmpl';
      case _i8.EntityTmplApiResponse():
        return 'EntityTmplApiResponse';
      case _i9.EntityTmplAttribute():
        return 'EntityTmplAttribute';
      case _i10.ApiException():
        return 'ApiException';
    }
    className = _i14.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i15.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AttributeTmpl') {
      return deserialize<_i4.AttributeTmpl>(data['data']);
    }
    if (dataClassName == 'AttributeTmplApiResponse') {
      return deserialize<_i5.AttributeTmplApiResponse>(data['data']);
    }
    if (dataClassName == 'EntityTmplLink') {
      return deserialize<_i6.EntityTmplLink>(data['data']);
    }
    if (dataClassName == 'EntityTmpl') {
      return deserialize<_i7.EntityTmpl>(data['data']);
    }
    if (dataClassName == 'EntityTmplApiResponse') {
      return deserialize<_i8.EntityTmplApiResponse>(data['data']);
    }
    if (dataClassName == 'EntityTmplAttribute') {
      return deserialize<_i9.EntityTmplAttribute>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_i10.ApiException>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i14.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i15.Protocol().deserializeByClassName(data);
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
    try {
      return _i14.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i15.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
