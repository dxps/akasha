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
import '../attribute_template/attr_tmpl.dart' as _i2;
import 'package:akasha_client/src/protocol/protocol.dart' as _i3;

abstract class AttributeTmplApiResponse implements _i1.SerializableModel {
  AttributeTmplApiResponse._({
    required this.success,
    this.data,
    this.errorCode,
    this.errorMessage,
  });

  factory AttributeTmplApiResponse({
    required bool success,
    _i2.AttributeTmpl? data,
    String? errorCode,
    String? errorMessage,
  }) = _AttributeTmplApiResponseImpl;

  factory AttributeTmplApiResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AttributeTmplApiResponse(
      success: _i1.BoolJsonExtension.fromJson(jsonSerialization['success']),
      data: jsonSerialization['data'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AttributeTmpl>(
              jsonSerialization['data'],
            ),
      errorCode: jsonSerialization['errorCode'] as String?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
    );
  }

  bool success;

  _i2.AttributeTmpl? data;

  String? errorCode;

  String? errorMessage;

  /// Returns a shallow copy of this [AttributeTmplApiResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AttributeTmplApiResponse copyWith({
    bool? success,
    _i2.AttributeTmpl? data,
    String? errorCode,
    String? errorMessage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AttributeTmplApiResponse',
      'success': success,
      if (data != null) 'data': data?.toJson(),
      if (errorCode != null) 'errorCode': errorCode,
      if (errorMessage != null) 'errorMessage': errorMessage,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AttributeTmplApiResponseImpl extends AttributeTmplApiResponse {
  _AttributeTmplApiResponseImpl({
    required bool success,
    _i2.AttributeTmpl? data,
    String? errorCode,
    String? errorMessage,
  }) : super._(
         success: success,
         data: data,
         errorCode: errorCode,
         errorMessage: errorMessage,
       );

  /// Returns a shallow copy of this [AttributeTmplApiResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AttributeTmplApiResponse copyWith({
    bool? success,
    Object? data = _Undefined,
    Object? errorCode = _Undefined,
    Object? errorMessage = _Undefined,
  }) {
    return AttributeTmplApiResponse(
      success: success ?? this.success,
      data: data is _i2.AttributeTmpl? ? data : this.data?.copyWith(),
      errorCode: errorCode is String? ? errorCode : this.errorCode,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
    );
  }
}
