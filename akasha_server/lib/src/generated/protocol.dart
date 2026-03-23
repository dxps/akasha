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
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'access_level/access_level.dart' as _i5;
import 'access_level/access_level_api_resp.dart' as _i6;
import 'attr_tmpls/attr_tmpl.dart' as _i7;
import 'attr_tmpls/attr_tmpl_api_resp.dart' as _i8;
import 'greetings/greeting.dart' as _i9;
import 'shared/api/exceptions/api_exception.dart' as _i10;
import 'package:akasha_server/src/generated/access_level/access_level.dart'
    as _i11;
import 'package:akasha_server/src/generated/attr_tmpls/attr_tmpl.dart' as _i12;
export 'access_level/access_level.dart';
export 'access_level/access_level_api_resp.dart';
export 'attr_tmpls/attr_tmpl.dart';
export 'attr_tmpls/attr_tmpl_api_resp.dart';
export 'greetings/greeting.dart';
export 'shared/api/exceptions/api_exception.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'access_levels',
      dartName: 'AccessLevel',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'access_levels_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'access_levels_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'access_level_name_uniq_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'attribute_tmpls',
      dartName: 'AttributeTmpl',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'valueType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'defaultValue',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'required',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'accessLevelId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'attribute_tmpls_fk_0',
          columns: ['accessLevelId'],
          referenceTable: 'access_levels',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'attribute_tmpls_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'attr_tmpl_name_desc_uniq_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'description',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

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

    if (t == _i5.AccessLevel) {
      return _i5.AccessLevel.fromJson(data) as T;
    }
    if (t == _i6.AccessLevelApiResponse) {
      return _i6.AccessLevelApiResponse.fromJson(data) as T;
    }
    if (t == _i7.AttributeTmpl) {
      return _i7.AttributeTmpl.fromJson(data) as T;
    }
    if (t == _i8.AttributeTmplApiResponse) {
      return _i8.AttributeTmplApiResponse.fromJson(data) as T;
    }
    if (t == _i9.Greeting) {
      return _i9.Greeting.fromJson(data) as T;
    }
    if (t == _i10.ApiException) {
      return _i10.ApiException.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AccessLevel?>()) {
      return (data != null ? _i5.AccessLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AccessLevelApiResponse?>()) {
      return (data != null ? _i6.AccessLevelApiResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.AttributeTmpl?>()) {
      return (data != null ? _i7.AttributeTmpl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AttributeTmplApiResponse?>()) {
      return (data != null ? _i8.AttributeTmplApiResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.Greeting?>()) {
      return (data != null ? _i9.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.ApiException?>()) {
      return (data != null ? _i10.ApiException.fromJson(data) : null) as T;
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
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.AccessLevel => 'AccessLevel',
      _i6.AccessLevelApiResponse => 'AccessLevelApiResponse',
      _i7.AttributeTmpl => 'AttributeTmpl',
      _i8.AttributeTmplApiResponse => 'AttributeTmplApiResponse',
      _i9.Greeting => 'Greeting',
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
      case _i5.AccessLevel():
        return 'AccessLevel';
      case _i6.AccessLevelApiResponse():
        return 'AccessLevelApiResponse';
      case _i7.AttributeTmpl():
        return 'AttributeTmpl';
      case _i8.AttributeTmplApiResponse():
        return 'AttributeTmplApiResponse';
      case _i9.Greeting():
        return 'Greeting';
      case _i10.ApiException():
        return 'ApiException';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
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
      return deserialize<_i5.AccessLevel>(data['data']);
    }
    if (dataClassName == 'AccessLevelApiResponse') {
      return deserialize<_i6.AccessLevelApiResponse>(data['data']);
    }
    if (dataClassName == 'AttributeTmpl') {
      return deserialize<_i7.AttributeTmpl>(data['data']);
    }
    if (dataClassName == 'AttributeTmplApiResponse') {
      return deserialize<_i8.AttributeTmplApiResponse>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i9.Greeting>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_i10.ApiException>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.AccessLevel:
        return _i5.AccessLevel.t;
      case _i7.AttributeTmpl:
        return _i7.AttributeTmpl.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'akasha';

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
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
