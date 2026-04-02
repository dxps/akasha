/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import '../protocol.dart' as _i1;
import 'package:serverpod/serverpod.dart' as _i2;
import '../shared/model/value_type.dart' as _i3;
import '../access_level/access_level.dart' as _i4;
import 'package:akasha_server/src/generated/protocol.dart' as _i5;

/// An attribute whose value represents a date.
abstract class DateAttribute extends _i1.Attribute
    implements _i2.TableRow<_i2.UuidValue?>, _i2.ProtocolSerialization {
  DateAttribute._({
    this.id,
    required super.name,
    super.description,
    required super.valueType,
    required this.value,
    required this.accessLevelId,
    required this.accessLevel,
  });

  factory DateAttribute({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required _i3.ValueType valueType,
    required DateTime value,
    required int accessLevelId,
    required _i4.AccessLevel? accessLevel,
  }) = _DateAttributeImpl;

  factory DateAttribute.fromJson(Map<String, dynamic> jsonSerialization) {
    return DateAttribute(
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

  static final t = DateAttributeTable();

  static const db = DateAttributeRepository._();

  @override
  _i2.UuidValue? id;

  DateTime value;

  int accessLevelId;

  _i4.AccessLevel? accessLevel;

  @override
  _i2.Table<_i2.UuidValue?> get table => t;

  /// Returns a shallow copy of this [DateAttribute]
  /// with some or all fields replaced by the given arguments.
  @override
  @_i2.useResult
  DateAttribute copyWith({
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
      '__className__': 'DateAttribute',
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DateAttribute',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'valueType': valueType.toJson(),
      'value': value.toJson(),
      'accessLevelId': accessLevelId,
      if (accessLevel != null) 'accessLevel': accessLevel?.toJsonForProtocol(),
    };
  }

  static DateAttributeInclude include({_i4.AccessLevelInclude? accessLevel}) {
    return DateAttributeInclude._(accessLevel: accessLevel);
  }

  static DateAttributeIncludeList includeList({
    _i2.WhereExpressionBuilder<DateAttributeTable>? where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<DateAttributeTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<DateAttributeTable>? orderByList,
    DateAttributeInclude? include,
  }) {
    return DateAttributeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DateAttribute.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DateAttribute.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i2.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DateAttributeImpl extends DateAttribute {
  _DateAttributeImpl({
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

  /// Returns a shallow copy of this [DateAttribute]
  /// with some or all fields replaced by the given arguments.
  @_i2.useResult
  @override
  DateAttribute copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    _i3.ValueType? valueType,
    DateTime? value,
    int? accessLevelId,
    Object? accessLevel = _Undefined,
  }) {
    return DateAttribute(
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

class DateAttributeUpdateTable extends _i2.UpdateTable<DateAttributeTable> {
  DateAttributeUpdateTable(super.table);

  _i2.ColumnValue<String, String> name(String value) => _i2.ColumnValue(
    table.name,
    value,
  );

  _i2.ColumnValue<String, String> description(String? value) => _i2.ColumnValue(
    table.description,
    value,
  );

  _i2.ColumnValue<_i3.ValueType, _i3.ValueType> valueType(
    _i3.ValueType value,
  ) => _i2.ColumnValue(
    table.valueType,
    value,
  );

  _i2.ColumnValue<DateTime, DateTime> value(DateTime value) => _i2.ColumnValue(
    table.value,
    value,
  );

  _i2.ColumnValue<int, int> accessLevelId(int value) => _i2.ColumnValue(
    table.accessLevelId,
    value,
  );
}

class DateAttributeTable extends _i2.Table<_i2.UuidValue?> {
  DateAttributeTable({super.tableRelation})
    : super(tableName: 'date_attributes') {
    updateTable = DateAttributeUpdateTable(this);
    name = _i2.ColumnString(
      'name',
      this,
    );
    description = _i2.ColumnString(
      'description',
      this,
    );
    valueType = _i2.ColumnEnum(
      'valueType',
      this,
      _i2.EnumSerialization.byName,
    );
    value = _i2.ColumnDateTime(
      'value',
      this,
    );
    accessLevelId = _i2.ColumnInt(
      'accessLevelId',
      this,
    );
  }

  late final DateAttributeUpdateTable updateTable;

  late final _i2.ColumnString name;

  late final _i2.ColumnString description;

  late final _i2.ColumnEnum<_i3.ValueType> valueType;

  late final _i2.ColumnDateTime value;

  late final _i2.ColumnInt accessLevelId;

  _i4.AccessLevelTable? _accessLevel;

  _i4.AccessLevelTable get accessLevel {
    if (_accessLevel != null) return _accessLevel!;
    _accessLevel = _i2.createRelationTable(
      relationFieldName: 'accessLevel',
      field: DateAttribute.t.accessLevelId,
      foreignField: _i4.AccessLevel.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.AccessLevelTable(tableRelation: foreignTableRelation),
    );
    return _accessLevel!;
  }

  @override
  List<_i2.Column> get columns => [
    id,
    name,
    description,
    valueType,
    value,
    accessLevelId,
  ];

  @override
  _i2.Table? getRelationTable(String relationField) {
    if (relationField == 'accessLevel') {
      return accessLevel;
    }
    return null;
  }
}

class DateAttributeInclude extends _i2.IncludeObject {
  DateAttributeInclude._({_i4.AccessLevelInclude? accessLevel}) {
    _accessLevel = accessLevel;
  }

  _i4.AccessLevelInclude? _accessLevel;

  @override
  Map<String, _i2.Include?> get includes => {'accessLevel': _accessLevel};

  @override
  _i2.Table<_i2.UuidValue?> get table => DateAttribute.t;
}

class DateAttributeIncludeList extends _i2.IncludeList {
  DateAttributeIncludeList._({
    _i2.WhereExpressionBuilder<DateAttributeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DateAttribute.t);
  }

  @override
  Map<String, _i2.Include?> get includes => include?.includes ?? {};

  @override
  _i2.Table<_i2.UuidValue?> get table => DateAttribute.t;
}

class DateAttributeRepository {
  const DateAttributeRepository._();

  final attachRow = const DateAttributeAttachRowRepository._();

  /// Returns a list of [DateAttribute]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<DateAttribute>> find(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<DateAttributeTable>? where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<DateAttributeTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<DateAttributeTable>? orderByList,
    _i2.Transaction? transaction,
    DateAttributeInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DateAttribute>(
      where: where?.call(DateAttribute.t),
      orderBy: orderBy?.call(DateAttribute.t),
      orderByList: orderByList?.call(DateAttribute.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DateAttribute] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<DateAttribute?> findFirstRow(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<DateAttributeTable>? where,
    int? offset,
    _i2.OrderByBuilder<DateAttributeTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<DateAttributeTable>? orderByList,
    _i2.Transaction? transaction,
    DateAttributeInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DateAttribute>(
      where: where?.call(DateAttribute.t),
      orderBy: orderBy?.call(DateAttribute.t),
      orderByList: orderByList?.call(DateAttribute.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DateAttribute] by its [id] or null if no such row exists.
  Future<DateAttribute?> findById(
    _i2.DatabaseSession session,
    _i2.UuidValue id, {
    _i2.Transaction? transaction,
    DateAttributeInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DateAttribute>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DateAttribute]s in the list and returns the inserted rows.
  ///
  /// The returned [DateAttribute]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DateAttribute>> insert(
    _i2.DatabaseSession session,
    List<DateAttribute> rows, {
    _i2.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DateAttribute>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DateAttribute] and returns the inserted row.
  ///
  /// The returned [DateAttribute] will have its `id` field set.
  Future<DateAttribute> insertRow(
    _i2.DatabaseSession session,
    DateAttribute row, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.insertRow<DateAttribute>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DateAttribute]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DateAttribute>> update(
    _i2.DatabaseSession session,
    List<DateAttribute> rows, {
    _i2.ColumnSelections<DateAttributeTable>? columns,
    _i2.Transaction? transaction,
  }) async {
    return session.db.update<DateAttribute>(
      rows,
      columns: columns?.call(DateAttribute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DateAttribute]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DateAttribute> updateRow(
    _i2.DatabaseSession session,
    DateAttribute row, {
    _i2.ColumnSelections<DateAttributeTable>? columns,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateRow<DateAttribute>(
      row,
      columns: columns?.call(DateAttribute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DateAttribute] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DateAttribute?> updateById(
    _i2.DatabaseSession session,
    _i2.UuidValue id, {
    required _i2.ColumnValueListBuilder<DateAttributeUpdateTable> columnValues,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateById<DateAttribute>(
      id,
      columnValues: columnValues(DateAttribute.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DateAttribute]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DateAttribute>> updateWhere(
    _i2.DatabaseSession session, {
    required _i2.ColumnValueListBuilder<DateAttributeUpdateTable> columnValues,
    required _i2.WhereExpressionBuilder<DateAttributeTable> where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<DateAttributeTable>? orderBy,
    _i2.OrderByListBuilder<DateAttributeTable>? orderByList,
    bool orderDescending = false,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DateAttribute>(
      columnValues: columnValues(DateAttribute.t.updateTable),
      where: where(DateAttribute.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DateAttribute.t),
      orderByList: orderByList?.call(DateAttribute.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DateAttribute]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DateAttribute>> delete(
    _i2.DatabaseSession session,
    List<DateAttribute> rows, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.delete<DateAttribute>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DateAttribute].
  Future<DateAttribute> deleteRow(
    _i2.DatabaseSession session,
    DateAttribute row, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DateAttribute>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DateAttribute>> deleteWhere(
    _i2.DatabaseSession session, {
    required _i2.WhereExpressionBuilder<DateAttributeTable> where,
    _i2.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DateAttribute>(
      where: where(DateAttribute.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<DateAttributeTable>? where,
    int? limit,
    _i2.Transaction? transaction,
  }) async {
    return session.db.count<DateAttribute>(
      where: where?.call(DateAttribute.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DateAttribute] rows matching the [where] expression.
  Future<void> lockRows(
    _i2.DatabaseSession session, {
    required _i2.WhereExpressionBuilder<DateAttributeTable> where,
    required _i2.LockMode lockMode,
    required _i2.Transaction transaction,
    _i2.LockBehavior lockBehavior = _i2.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DateAttribute>(
      where: where(DateAttribute.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DateAttributeAttachRowRepository {
  const DateAttributeAttachRowRepository._();

  /// Creates a relation between the given [DateAttribute] and [AccessLevel]
  /// by setting the [DateAttribute]'s foreign key `accessLevelId` to refer to the [AccessLevel].
  Future<void> accessLevel(
    _i2.DatabaseSession session,
    DateAttribute dateAttribute,
    _i4.AccessLevel accessLevel, {
    _i2.Transaction? transaction,
  }) async {
    if (dateAttribute.id == null) {
      throw ArgumentError.notNull('dateAttribute.id');
    }
    if (accessLevel.id == null) {
      throw ArgumentError.notNull('accessLevel.id');
    }

    var $dateAttribute = dateAttribute.copyWith(accessLevelId: accessLevel.id);
    await session.db.updateRow<DateAttribute>(
      $dateAttribute,
      columns: [DateAttribute.t.accessLevelId],
      transaction: transaction,
    );
  }
}
