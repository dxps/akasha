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

enum ValueType implements _i1.SerializableModel {
  text('text', 'Text'),
  number('number', 'Number'),
  boolean('boolean', 'Boolean'),
  date('date', 'Date'),
  datetime('dateTime', 'DateTime');

  const ValueType(
    this.type,
    this.label,
  );

  final String type;

  final String label;

  static ValueType fromJson(String name) {
    switch (name) {
      case 'text':
        return ValueType.text;
      case 'number':
        return ValueType.number;
      case 'boolean':
        return ValueType.boolean;
      case 'date':
        return ValueType.date;
      case 'datetime':
        return ValueType.datetime;
      default:
        return ValueType.text;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
