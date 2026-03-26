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
import '../attribute_template/attr_tmpl.dart' as _i3;
import 'package:akasha_client/src/protocol/protocol.dart' as _i4;

abstract class EntityTmplAttribute implements _i1.SerializableModel {
  EntityTmplAttribute._({
    this.id,
    required this.entityTmplId,
    this.entityTmpl,
    required this.attributeTmplId,
    this.attributeTmpl,
    required this.orderIdx,
  });

  factory EntityTmplAttribute({
    int? id,
    required _i1.UuidValue entityTmplId,
    _i2.EntityTmpl? entityTmpl,
    required _i1.UuidValue attributeTmplId,
    _i3.AttributeTmpl? attributeTmpl,
    required int orderIdx,
  }) = _EntityTmplAttributeImpl;

  factory EntityTmplAttribute.fromJson(Map<String, dynamic> jsonSerialization) {
    return EntityTmplAttribute(
      id: jsonSerialization['id'] as int?,
      entityTmplId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['entityTmplId'],
      ),
      entityTmpl: jsonSerialization['entityTmpl'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.EntityTmpl>(
              jsonSerialization['entityTmpl'],
            ),
      attributeTmplId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['attributeTmplId'],
      ),
      attributeTmpl: jsonSerialization['attributeTmpl'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.AttributeTmpl>(
              jsonSerialization['attributeTmpl'],
            ),
      orderIdx: jsonSerialization['orderIdx'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue entityTmplId;

  _i2.EntityTmpl? entityTmpl;

  _i1.UuidValue attributeTmplId;

  _i3.AttributeTmpl? attributeTmpl;

  int orderIdx;

  /// Returns a shallow copy of this [EntityTmplAttribute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EntityTmplAttribute copyWith({
    int? id,
    _i1.UuidValue? entityTmplId,
    _i2.EntityTmpl? entityTmpl,
    _i1.UuidValue? attributeTmplId,
    _i3.AttributeTmpl? attributeTmpl,
    int? orderIdx,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EntityTmplAttribute',
      if (id != null) 'id': id,
      'entityTmplId': entityTmplId.toJson(),
      if (entityTmpl != null) 'entityTmpl': entityTmpl?.toJson(),
      'attributeTmplId': attributeTmplId.toJson(),
      if (attributeTmpl != null) 'attributeTmpl': attributeTmpl?.toJson(),
      'orderIdx': orderIdx,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntityTmplAttributeImpl extends EntityTmplAttribute {
  _EntityTmplAttributeImpl({
    int? id,
    required _i1.UuidValue entityTmplId,
    _i2.EntityTmpl? entityTmpl,
    required _i1.UuidValue attributeTmplId,
    _i3.AttributeTmpl? attributeTmpl,
    required int orderIdx,
  }) : super._(
         id: id,
         entityTmplId: entityTmplId,
         entityTmpl: entityTmpl,
         attributeTmplId: attributeTmplId,
         attributeTmpl: attributeTmpl,
         orderIdx: orderIdx,
       );

  /// Returns a shallow copy of this [EntityTmplAttribute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EntityTmplAttribute copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? entityTmplId,
    Object? entityTmpl = _Undefined,
    _i1.UuidValue? attributeTmplId,
    Object? attributeTmpl = _Undefined,
    int? orderIdx,
  }) {
    return EntityTmplAttribute(
      id: id is int? ? id : this.id,
      entityTmplId: entityTmplId ?? this.entityTmplId,
      entityTmpl: entityTmpl is _i2.EntityTmpl?
          ? entityTmpl
          : this.entityTmpl?.copyWith(),
      attributeTmplId: attributeTmplId ?? this.attributeTmplId,
      attributeTmpl: attributeTmpl is _i3.AttributeTmpl?
          ? attributeTmpl
          : this.attributeTmpl?.copyWith(),
      orderIdx: orderIdx ?? this.orderIdx,
    );
  }
}
