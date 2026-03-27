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
import '../entity_template/entity_tmpl.dart' as _i2;
import 'package:akasha_client/src/protocol/protocol.dart' as _i3;

abstract class EntityTmplLink implements _i1.SerializableModel {
  EntityTmplLink._({
    this.id,
    required this.name,
    this.description,
    required this.orderIdx,
    required this.sourceId,
    this.source,
    required this.targetId,
    this.target,
  });

  factory EntityTmplLink({
    _i1.UuidValue? id,
    required String name,
    String? description,
    required int orderIdx,
    required _i1.UuidValue sourceId,
    _i2.EntityTmpl? source,
    required _i1.UuidValue targetId,
    _i2.EntityTmpl? target,
  }) = _EntityTmplLinkImpl;

  factory EntityTmplLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return EntityTmplLink(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      orderIdx: jsonSerialization['orderIdx'] as int,
      sourceId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['sourceId'],
      ),
      source: jsonSerialization['source'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.EntityTmpl>(
              jsonSerialization['source'],
            ),
      targetId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['targetId'],
      ),
      target: jsonSerialization['target'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.EntityTmpl>(
              jsonSerialization['target'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  String name;

  String? description;

  int orderIdx;

  _i1.UuidValue sourceId;

  /// The source of this entity link template.
  _i2.EntityTmpl? source;

  _i1.UuidValue targetId;

  /// The target(s) of this entity link template, this link template points to.
  _i2.EntityTmpl? target;

  /// Returns a shallow copy of this [EntityTmplLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EntityTmplLink copyWith({
    _i1.UuidValue? id,
    String? name,
    String? description,
    int? orderIdx,
    _i1.UuidValue? sourceId,
    _i2.EntityTmpl? source,
    _i1.UuidValue? targetId,
    _i2.EntityTmpl? target,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EntityTmplLink',
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
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntityTmplLinkImpl extends EntityTmplLink {
  _EntityTmplLinkImpl({
    _i1.UuidValue? id,
    required String name,
    String? description,
    required int orderIdx,
    required _i1.UuidValue sourceId,
    _i2.EntityTmpl? source,
    required _i1.UuidValue targetId,
    _i2.EntityTmpl? target,
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

  /// Returns a shallow copy of this [EntityTmplLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EntityTmplLink copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    int? orderIdx,
    _i1.UuidValue? sourceId,
    Object? source = _Undefined,
    _i1.UuidValue? targetId,
    Object? target = _Undefined,
  }) {
    return EntityTmplLink(
      id: id is _i1.UuidValue? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      orderIdx: orderIdx ?? this.orderIdx,
      sourceId: sourceId ?? this.sourceId,
      source: source is _i2.EntityTmpl? ? source : this.source?.copyWith(),
      targetId: targetId ?? this.targetId,
      target: target is _i2.EntityTmpl? ? target : this.target?.copyWith(),
    );
  }
}
