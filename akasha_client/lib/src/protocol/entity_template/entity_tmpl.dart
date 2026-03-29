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
import '../entity_template/entity_tmpl_attribute.dart' as _i2;
import '../entity_template/entity_tmpl_link.dart' as _i3;
import 'package:akasha_client/src/protocol/protocol.dart' as _i4;

abstract class EntityTmpl implements _i1.SerializableModel {
  EntityTmpl._({
    this.id,
    required this.name,
    this.description,
    this.attributes,
    this.outgoingLinks,
    this.incomingLinks,
  });

  factory EntityTmpl({
    _i1.UuidValue? id,
    required String name,
    String? description,
    List<_i2.EntityTmplAttribute>? attributes,
    List<_i3.EntityTmplLink>? outgoingLinks,
    List<_i3.EntityTmplLink>? incomingLinks,
  }) = _EntityTmplImpl;

  factory EntityTmpl.fromJson(Map<String, dynamic> jsonSerialization) {
    return EntityTmpl(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      attributes: jsonSerialization['attributes'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i2.EntityTmplAttribute>>(
              jsonSerialization['attributes'],
            ),
      outgoingLinks: jsonSerialization['outgoingLinks'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.EntityTmplLink>>(
              jsonSerialization['outgoingLinks'],
            ),
      incomingLinks: jsonSerialization['incomingLinks'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.EntityTmplLink>>(
              jsonSerialization['incomingLinks'],
            ),
    );
  }

  /// The public ID.
  _i1.UuidValue? id;

  String name;

  String? description;

  List<_i2.EntityTmplAttribute>? attributes;

  /// The links where this entity template is the source.
  List<_i3.EntityTmplLink>? outgoingLinks;

  /// Optional reverse traversal: links where this entity template is a target.
  List<_i3.EntityTmplLink>? incomingLinks;

  /// Returns a shallow copy of this [EntityTmpl]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EntityTmpl copyWith({
    _i1.UuidValue? id,
    String? name,
    String? description,
    List<_i2.EntityTmplAttribute>? attributes,
    List<_i3.EntityTmplLink>? outgoingLinks,
    List<_i3.EntityTmplLink>? incomingLinks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EntityTmpl',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      if (attributes != null)
        'attributes': attributes?.toJson(valueToJson: (v) => v.toJson()),
      if (outgoingLinks != null)
        'outgoingLinks': outgoingLinks?.toJson(valueToJson: (v) => v.toJson()),
      if (incomingLinks != null)
        'incomingLinks': incomingLinks?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntityTmplImpl extends EntityTmpl {
  _EntityTmplImpl({
    _i1.UuidValue? id,
    required String name,
    String? description,
    List<_i2.EntityTmplAttribute>? attributes,
    List<_i3.EntityTmplLink>? outgoingLinks,
    List<_i3.EntityTmplLink>? incomingLinks,
  }) : super._(
         id: id,
         name: name,
         description: description,
         attributes: attributes,
         outgoingLinks: outgoingLinks,
         incomingLinks: incomingLinks,
       );

  /// Returns a shallow copy of this [EntityTmpl]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EntityTmpl copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    Object? attributes = _Undefined,
    Object? outgoingLinks = _Undefined,
    Object? incomingLinks = _Undefined,
  }) {
    return EntityTmpl(
      id: id is _i1.UuidValue? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      attributes: attributes is List<_i2.EntityTmplAttribute>?
          ? attributes
          : this.attributes?.map((e0) => e0.copyWith()).toList(),
      outgoingLinks: outgoingLinks is List<_i3.EntityTmplLink>?
          ? outgoingLinks
          : this.outgoingLinks?.map((e0) => e0.copyWith()).toList(),
      incomingLinks: incomingLinks is List<_i3.EntityTmplLink>?
          ? incomingLinks
          : this.incomingLinks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
