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
import '../attribute/text_attr.dart' as _i3;
import '../attribute/number_attr.dart' as _i4;
import '../attribute/bool_attr.dart' as _i5;
import '../attribute/date_attr.dart' as _i6;
import '../attribute/datetime_attr.dart' as _i7;
import '../entity/ent_links.dart' as _i8;
import 'package:akasha_client/src/protocol/protocol.dart' as _i9;

abstract class Entity extends _i1.HasId implements _i2.SerializableModel {
  Entity._({
    this.id,
    required this.listingAttribute,
    required this.attributesOrder,
    required this.textAttributes,
    required this.numberAttributes,
    required this.boolAttributes,
    required this.dateAttributes,
    required this.dateTimeAttributes,
    this.outgoingLinks,
    this.incomingLinks,
  });

  factory Entity({
    _i2.UuidValue? id,
    required (String, String) listingAttribute,
    required List<(int, String)> attributesOrder,
    required List<_i3.TextAttribute> textAttributes,
    required List<_i4.NumberAttribute> numberAttributes,
    required List<_i5.BoolAttribute> boolAttributes,
    required List<_i6.DateAttribute> dateAttributes,
    required List<_i7.DateTimeAttribute> dateTimeAttributes,
    List<_i8.EntityLink>? outgoingLinks,
    List<_i8.EntityLink>? incomingLinks,
  }) = _EntityImpl;

  factory Entity.fromJson(Map<String, dynamic> jsonSerialization) {
    return Entity(
      id: jsonSerialization['id'] == null
          ? null
          : _i2.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      listingAttribute: _i9.Protocol().deserialize<(String, String)>(
        (jsonSerialization['listingAttribute'] as Map<String, dynamic>),
      ),
      attributesOrder: _i9.Protocol().deserialize<List<(int, String)>>(
        jsonSerialization['attributesOrder'],
      ),
      textAttributes: _i9.Protocol().deserialize<List<_i3.TextAttribute>>(
        jsonSerialization['textAttributes'],
      ),
      numberAttributes: _i9.Protocol().deserialize<List<_i4.NumberAttribute>>(
        jsonSerialization['numberAttributes'],
      ),
      boolAttributes: _i9.Protocol().deserialize<List<_i5.BoolAttribute>>(
        jsonSerialization['boolAttributes'],
      ),
      dateAttributes: _i9.Protocol().deserialize<List<_i6.DateAttribute>>(
        jsonSerialization['dateAttributes'],
      ),
      dateTimeAttributes: _i9.Protocol()
          .deserialize<List<_i7.DateTimeAttribute>>(
            jsonSerialization['dateTimeAttributes'],
          ),
      outgoingLinks: jsonSerialization['outgoingLinks'] == null
          ? null
          : _i9.Protocol().deserialize<List<_i8.EntityLink>>(
              jsonSerialization['outgoingLinks'],
            ),
      incomingLinks: jsonSerialization['incomingLinks'] == null
          ? null
          : _i9.Protocol().deserialize<List<_i8.EntityLink>>(
              jsonSerialization['incomingLinks'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i2.UuidValue? id;

  /// The attribute (the name and its value) that is presented in the listing of entities.
  (String, String) listingAttribute;

  /// The order of attributes. Each list item is a tuple of (order-idx, attribute-type).
  List<(int, String)> attributesOrder;

  List<_i3.TextAttribute> textAttributes;

  List<_i4.NumberAttribute> numberAttributes;

  List<_i5.BoolAttribute> boolAttributes;

  List<_i6.DateAttribute> dateAttributes;

  List<_i7.DateTimeAttribute> dateTimeAttributes;

  List<_i8.EntityLink>? outgoingLinks;

  List<_i8.EntityLink>? incomingLinks;

  /// Returns a shallow copy of this [Entity]
  /// with some or all fields replaced by the given arguments.
  @override
  @_i2.useResult
  Entity copyWith({
    Object? id,
    (String, String)? listingAttribute,
    List<(int, String)>? attributesOrder,
    List<_i3.TextAttribute>? textAttributes,
    List<_i4.NumberAttribute>? numberAttributes,
    List<_i5.BoolAttribute>? boolAttributes,
    List<_i6.DateAttribute>? dateAttributes,
    List<_i7.DateTimeAttribute>? dateTimeAttributes,
    List<_i8.EntityLink>? outgoingLinks,
    List<_i8.EntityLink>? incomingLinks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Entity',
      if (id != null) 'id': id?.toJson(),
      'listingAttribute': _i9.Protocol().mapRecordToJson(listingAttribute),
      'attributesOrder': _i9.Protocol().mapContainerToJson(attributesOrder),
      'textAttributes': textAttributes.toJson(valueToJson: (v) => v.toJson()),
      'numberAttributes': numberAttributes.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'boolAttributes': boolAttributes.toJson(valueToJson: (v) => v.toJson()),
      'dateAttributes': dateAttributes.toJson(valueToJson: (v) => v.toJson()),
      'dateTimeAttributes': dateTimeAttributes.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      if (outgoingLinks != null)
        'outgoingLinks': outgoingLinks?.toJson(valueToJson: (v) => v.toJson()),
      if (incomingLinks != null)
        'incomingLinks': incomingLinks?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i2.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntityImpl extends Entity {
  _EntityImpl({
    _i2.UuidValue? id,
    required (String, String) listingAttribute,
    required List<(int, String)> attributesOrder,
    required List<_i3.TextAttribute> textAttributes,
    required List<_i4.NumberAttribute> numberAttributes,
    required List<_i5.BoolAttribute> boolAttributes,
    required List<_i6.DateAttribute> dateAttributes,
    required List<_i7.DateTimeAttribute> dateTimeAttributes,
    List<_i8.EntityLink>? outgoingLinks,
    List<_i8.EntityLink>? incomingLinks,
  }) : super._(
         id: id,
         listingAttribute: listingAttribute,
         attributesOrder: attributesOrder,
         textAttributes: textAttributes,
         numberAttributes: numberAttributes,
         boolAttributes: boolAttributes,
         dateAttributes: dateAttributes,
         dateTimeAttributes: dateTimeAttributes,
         outgoingLinks: outgoingLinks,
         incomingLinks: incomingLinks,
       );

  /// Returns a shallow copy of this [Entity]
  /// with some or all fields replaced by the given arguments.
  @_i2.useResult
  @override
  Entity copyWith({
    Object? id = _Undefined,
    (String, String)? listingAttribute,
    List<(int, String)>? attributesOrder,
    List<_i3.TextAttribute>? textAttributes,
    List<_i4.NumberAttribute>? numberAttributes,
    List<_i5.BoolAttribute>? boolAttributes,
    List<_i6.DateAttribute>? dateAttributes,
    List<_i7.DateTimeAttribute>? dateTimeAttributes,
    Object? outgoingLinks = _Undefined,
    Object? incomingLinks = _Undefined,
  }) {
    return Entity(
      id: id is _i2.UuidValue? ? id : this.id,
      listingAttribute:
          listingAttribute ??
          (
            this.listingAttribute.$1,
            this.listingAttribute.$2,
          ),
      attributesOrder:
          attributesOrder ??
          this.attributesOrder
              .map(
                (e0) => (
                  e0.$1,
                  e0.$2,
                ),
              )
              .toList(),
      textAttributes:
          textAttributes ??
          this.textAttributes.map((e0) => e0.copyWith()).toList(),
      numberAttributes:
          numberAttributes ??
          this.numberAttributes.map((e0) => e0.copyWith()).toList(),
      boolAttributes:
          boolAttributes ??
          this.boolAttributes.map((e0) => e0.copyWith()).toList(),
      dateAttributes:
          dateAttributes ??
          this.dateAttributes.map((e0) => e0.copyWith()).toList(),
      dateTimeAttributes:
          dateTimeAttributes ??
          this.dateTimeAttributes.map((e0) => e0.copyWith()).toList(),
      outgoingLinks: outgoingLinks is List<_i8.EntityLink>?
          ? outgoingLinks
          : this.outgoingLinks?.map((e0) => e0.copyWith()).toList(),
      incomingLinks: incomingLinks is List<_i8.EntityLink>?
          ? incomingLinks
          : this.incomingLinks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
