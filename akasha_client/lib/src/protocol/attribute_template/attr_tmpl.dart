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
import '../protocol.dart' as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import '../access_level/access_level.dart' as _i3;
import 'package:akasha_client/src/protocol/protocol.dart' as _i4;

abstract class AttributeTmpl extends _i1.HasId
    implements _i2.SerializableModel {
  AttributeTmpl._({
    this.id,
    required this.name,
    this.description,
    required this.valueType,
    required this.defaultValue,
    required this.required,
    required this.accessLevelId,
    required this.accessLevel,
  });

  factory AttributeTmpl({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required String valueType,
    required String defaultValue,
    required bool required,
    required int accessLevelId,
    required _i3.AccessLevel? accessLevel,
  }) = _AttributeTmplImpl;

  factory AttributeTmpl.fromJson(Map<String, dynamic> jsonSerialization) {
    return AttributeTmpl(
      id: jsonSerialization['id'] == null
          ? null
          : _i2.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      valueType: jsonSerialization['valueType'] as String,
      defaultValue: jsonSerialization['defaultValue'] as String,
      required: _i2.BoolJsonExtension.fromJson(jsonSerialization['required']),
      accessLevelId: jsonSerialization['accessLevelId'] as int,
      accessLevel: jsonSerialization['accessLevel'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.AccessLevel>(
              jsonSerialization['accessLevel'],
            ),
    );
  }

  /// Its unique identifier.
  _i2.UuidValue? id;

  String name;

  String? description;

  String valueType;

  String defaultValue;

  bool required;

  int accessLevelId;

  _i3.AccessLevel? accessLevel;

  /// Returns a shallow copy of this [AttributeTmpl]
  /// with some or all fields replaced by the given arguments.
  @override
  @_i2.useResult
  AttributeTmpl copyWith({
    Object? id,
    String? name,
    String? description,
    String? valueType,
    String? defaultValue,
    bool? required,
    int? accessLevelId,
    _i3.AccessLevel? accessLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AttributeTmpl',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'valueType': valueType,
      'defaultValue': defaultValue,
      'required': required,
      'accessLevelId': accessLevelId,
      if (accessLevel != null) 'accessLevel': accessLevel?.toJson(),
    };
  }

  @override
  String toString() {
    return _i2.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AttributeTmplImpl extends AttributeTmpl {
  _AttributeTmplImpl({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required String valueType,
    required String defaultValue,
    required bool required,
    required int accessLevelId,
    required _i3.AccessLevel? accessLevel,
  }) : super._(
         id: id,
         name: name,
         description: description,
         valueType: valueType,
         defaultValue: defaultValue,
         required: required,
         accessLevelId: accessLevelId,
         accessLevel: accessLevel,
       );

  /// Returns a shallow copy of this [AttributeTmpl]
  /// with some or all fields replaced by the given arguments.
  @_i2.useResult
  @override
  AttributeTmpl copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    String? valueType,
    String? defaultValue,
    bool? required,
    int? accessLevelId,
    Object? accessLevel = _Undefined,
  }) {
    return AttributeTmpl(
      id: id is _i2.UuidValue? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      valueType: valueType ?? this.valueType,
      defaultValue: defaultValue ?? this.defaultValue,
      required: required ?? this.required,
      accessLevelId: accessLevelId ?? this.accessLevelId,
      accessLevel: accessLevel is _i3.AccessLevel?
          ? accessLevel
          : this.accessLevel?.copyWith(),
    );
  }
}
