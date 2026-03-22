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

abstract class ApiException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  ApiException._({
    required this.errorCode,
    required this.message,
  });

  factory ApiException({
    required String errorCode,
    required String message,
  }) = _ApiExceptionImpl;

  factory ApiException.fromJson(Map<String, dynamic> jsonSerialization) {
    return ApiException(
      errorCode: jsonSerialization['errorCode'] as String,
      message: jsonSerialization['message'] as String,
    );
  }

  String errorCode;

  String message;

  /// Returns a shallow copy of this [ApiException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ApiException copyWith({
    String? errorCode,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ApiException',
      'errorCode': errorCode,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ApiException',
      'errorCode': errorCode,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'ApiException(errorCode: $errorCode, message: $message)';
  }
}

class _ApiExceptionImpl extends ApiException {
  _ApiExceptionImpl({
    required String errorCode,
    required String message,
  }) : super._(
         errorCode: errorCode,
         message: message,
       );

  /// Returns a shallow copy of this [ApiException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ApiException copyWith({
    String? errorCode,
    String? message,
  }) {
    return ApiException(
      errorCode: errorCode ?? this.errorCode,
      message: message ?? this.message,
    );
  }
}
