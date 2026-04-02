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
import '../entity/entity.dart' as _i3;
import 'package:akasha_client/src/protocol/protocol.dart' as _i4;

abstract class EntityLink extends _i1.HasId implements _i2.SerializableModel {
  EntityLink._({
    this.id,
    required this.name,
    this.description,
    required this.orderIdx,
    required this.sourceId,
    this.source,
    required this.targetId,
    this.target,
  });

  factory EntityLink({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required int orderIdx,
    required _i2.UuidValue sourceId,
    _i3.Entity? source,
    required _i2.UuidValue targetId,
    _i3.Entity? target,
  }) = _EntityLinkImpl;

  factory EntityLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return EntityLink(
      id: jsonSerialization['id'] == null
          ? null
          : _i2.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      orderIdx: jsonSerialization['orderIdx'] as int,
      sourceId: _i2.UuidValueJsonExtension.fromJson(
        jsonSerialization['sourceId'],
      ),
      source: jsonSerialization['source'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Entity>(jsonSerialization['source']),
      targetId: _i2.UuidValueJsonExtension.fromJson(
        jsonSerialization['targetId'],
      ),
      target: jsonSerialization['target'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Entity>(jsonSerialization['target']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i2.UuidValue? id;

  String name;

  String? description;

  int orderIdx;

  _i2.UuidValue sourceId;

  /// The source of this entity link.
  _i3.Entity? source;

  _i2.UuidValue targetId;

  /// The target of this entity link.
  _i3.Entity? target;

  /// Returns a shallow copy of this [EntityLink]
  /// with some or all fields replaced by the given arguments.
  @override
  @_i2.useResult
  EntityLink copyWith({
    Object? id,
    String? name,
    String? description,
    int? orderIdx,
    _i2.UuidValue? sourceId,
    _i3.Entity? source,
    _i2.UuidValue? targetId,
    _i3.Entity? target,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EntityLink',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'orderIdx': orderIdx,
      'sourceId': sourceId.toJson(),
      if (source != null) 'source': source?.toJson(),
      'targetId': targetId.toJson(),
      if (target != null) 'target': target?.toJson(),
    };
  }

  @override
  String toString() {
    return _i2.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntityLinkImpl extends EntityLink {
  _EntityLinkImpl({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required int orderIdx,
    required _i2.UuidValue sourceId,
    _i3.Entity? source,
    required _i2.UuidValue targetId,
    _i3.Entity? target,
  }) : super._(
         id: id,
         name: name,
         description: description,
         orderIdx: orderIdx,
         sourceId: sourceId,
         source: source,
         targetId: targetId,
         target: target,
       );

  /// Returns a shallow copy of this [EntityLink]
  /// with some or all fields replaced by the given arguments.
  @_i2.useResult
  @override
  EntityLink copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    int? orderIdx,
    _i2.UuidValue? sourceId,
    Object? source = _Undefined,
    _i2.UuidValue? targetId,
    Object? target = _Undefined,
  }) {
    return EntityLink(
      id: id is _i2.UuidValue? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      orderIdx: orderIdx ?? this.orderIdx,
      sourceId: sourceId ?? this.sourceId,
      source: source is _i3.Entity? ? source : this.source?.copyWith(),
      targetId: targetId ?? this.targetId,
      target: target is _i3.Entity? ? target : this.target?.copyWith(),
    );
  }
}
