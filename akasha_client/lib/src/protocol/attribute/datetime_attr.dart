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
import '../shared/model/value_type.dart' as _i3;
import '../access_level/access_level.dart' as _i4;
import 'package:akasha_client/src/protocol/protocol.dart' as _i5;

/// An attribute whose value represents a date and time.
abstract class DateTimeAttribute extends _i1.Attribute
    implements _i2.SerializableModel {
  DateTimeAttribute._({
    this.id,
    required super.name,
    super.description,
    required super.valueType,
    required this.value,
    required this.accessLevelId,
    required this.accessLevel,
  });

  factory DateTimeAttribute({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required _i3.ValueType valueType,
    required DateTime value,
    required int accessLevelId,
    required _i4.AccessLevel? accessLevel,
  }) = _DateTimeAttributeImpl;

  factory DateTimeAttribute.fromJson(Map<String, dynamic> jsonSerialization) {
    return DateTimeAttribute(
      id: jsonSerialization['id'] == null
          ? null
          : _i2.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      valueType: _i3.ValueType.fromJson(
        (jsonSerialization['valueType'] as String),
      ),
      value: _i2.DateTimeJsonExtension.fromJson(jsonSerialization['value']),
      accessLevelId: jsonSerialization['accessLevelId'] as int,
      accessLevel: jsonSerialization['accessLevel'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.AccessLevel>(
              jsonSerialization['accessLevel'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i2.UuidValue? id;

  DateTime value;

  int accessLevelId;

  _i4.AccessLevel? accessLevel;

  /// Returns a shallow copy of this [DateTimeAttribute]
  /// with some or all fields replaced by the given arguments.
  @override
  @_i2.useResult
  DateTimeAttribute copyWith({
    Object? id,
    String? name,
    Object? description,
    _i3.ValueType? valueType,
    DateTime? value,
    int? accessLevelId,
    _i4.AccessLevel? accessLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DateTimeAttribute',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'valueType': valueType.toJson(),
      'value': value.toJson(),
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

class _DateTimeAttributeImpl extends DateTimeAttribute {
  _DateTimeAttributeImpl({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required _i3.ValueType valueType,
    required DateTime value,
    required int accessLevelId,
    required _i4.AccessLevel? accessLevel,
  }) : super._(
         id: id,
         name: name,
         description: description,
         valueType: valueType,
         value: value,
         accessLevelId: accessLevelId,
         accessLevel: accessLevel,
       );

  /// Returns a shallow copy of this [DateTimeAttribute]
  /// with some or all fields replaced by the given arguments.
  @_i2.useResult
  @override
  DateTimeAttribute copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    _i3.ValueType? valueType,
    DateTime? value,
    int? accessLevelId,
    Object? accessLevel = _Undefined,
  }) {
    return DateTimeAttribute(
      id: id is _i2.UuidValue? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      valueType: valueType ?? this.valueType,
      value: value ?? this.value,
      accessLevelId: accessLevelId ?? this.accessLevelId,
      accessLevel: accessLevel is _i4.AccessLevel?
          ? accessLevel
          : this.accessLevel?.copyWith(),
    );
  }
}
