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

/// An attribute whose value represents a date and time.
abstract class DateTimeAttribute extends _i1.Attribute
    implements _i2.TableRow<_i2.UuidValue?>, _i2.ProtocolSerialization {
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

  static final t = DateTimeAttributeTable();

  static const db = DateTimeAttributeRepository._();

  @override
  _i2.UuidValue? id;

  DateTime value;

  int accessLevelId;

  _i4.AccessLevel? accessLevel;

  @override
  _i2.Table<_i2.UuidValue?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DateTimeAttribute',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'valueType': valueType.toJson(),
      'value': value.toJson(),
      'accessLevelId': accessLevelId,
      if (accessLevel != null) 'accessLevel': accessLevel?.toJsonForProtocol(),
    };
  }

  static DateTimeAttributeInclude include({
    _i4.AccessLevelInclude? accessLevel,
  }) {
    return DateTimeAttributeInclude._(accessLevel: accessLevel);
  }

  static DateTimeAttributeIncludeList includeList({
    _i2.WhereExpressionBuilder<DateTimeAttributeTable>? where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<DateTimeAttributeTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<DateTimeAttributeTable>? orderByList,
    DateTimeAttributeInclude? include,
  }) {
    return DateTimeAttributeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DateTimeAttribute.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DateTimeAttribute.t),
      include: include,
    );
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

class DateTimeAttributeUpdateTable
    extends _i2.UpdateTable<DateTimeAttributeTable> {
  DateTimeAttributeUpdateTable(super.table);

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

class DateTimeAttributeTable extends _i2.Table<_i2.UuidValue?> {
  DateTimeAttributeTable({super.tableRelation})
    : super(tableName: 'datetime_attributes') {
    updateTable = DateTimeAttributeUpdateTable(this);
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

  late final DateTimeAttributeUpdateTable updateTable;

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
      field: DateTimeAttribute.t.accessLevelId,
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

class DateTimeAttributeInclude extends _i2.IncludeObject {
  DateTimeAttributeInclude._({_i4.AccessLevelInclude? accessLevel}) {
    _accessLevel = accessLevel;
  }

  _i4.AccessLevelInclude? _accessLevel;

  @override
  Map<String, _i2.Include?> get includes => {'accessLevel': _accessLevel};

  @override
  _i2.Table<_i2.UuidValue?> get table => DateTimeAttribute.t;
}

class DateTimeAttributeIncludeList extends _i2.IncludeList {
  DateTimeAttributeIncludeList._({
    _i2.WhereExpressionBuilder<DateTimeAttributeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DateTimeAttribute.t);
  }

  @override
  Map<String, _i2.Include?> get includes => include?.includes ?? {};

  @override
  _i2.Table<_i2.UuidValue?> get table => DateTimeAttribute.t;
}

class DateTimeAttributeRepository {
  const DateTimeAttributeRepository._();

  final attachRow = const DateTimeAttributeAttachRowRepository._();

  /// Returns a list of [DateTimeAttribute]s matching the given query parameters.
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
  Future<List<DateTimeAttribute>> find(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<DateTimeAttributeTable>? where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<DateTimeAttributeTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<DateTimeAttributeTable>? orderByList,
    _i2.Transaction? transaction,
    DateTimeAttributeInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DateTimeAttribute>(
      where: where?.call(DateTimeAttribute.t),
      orderBy: orderBy?.call(DateTimeAttribute.t),
      orderByList: orderByList?.call(DateTimeAttribute.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DateTimeAttribute] matching the given query parameters.
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
  Future<DateTimeAttribute?> findFirstRow(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<DateTimeAttributeTable>? where,
    int? offset,
    _i2.OrderByBuilder<DateTimeAttributeTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<DateTimeAttributeTable>? orderByList,
    _i2.Transaction? transaction,
    DateTimeAttributeInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DateTimeAttribute>(
      where: where?.call(DateTimeAttribute.t),
      orderBy: orderBy?.call(DateTimeAttribute.t),
      orderByList: orderByList?.call(DateTimeAttribute.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DateTimeAttribute] by its [id] or null if no such row exists.
  Future<DateTimeAttribute?> findById(
    _i2.DatabaseSession session,
    _i2.UuidValue id, {
    _i2.Transaction? transaction,
    DateTimeAttributeInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DateTimeAttribute>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DateTimeAttribute]s in the list and returns the inserted rows.
  ///
  /// The returned [DateTimeAttribute]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DateTimeAttribute>> insert(
    _i2.DatabaseSession session,
    List<DateTimeAttribute> rows, {
    _i2.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DateTimeAttribute>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DateTimeAttribute] and returns the inserted row.
  ///
  /// The returned [DateTimeAttribute] will have its `id` field set.
  Future<DateTimeAttribute> insertRow(
    _i2.DatabaseSession session,
    DateTimeAttribute row, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.insertRow<DateTimeAttribute>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DateTimeAttribute]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DateTimeAttribute>> update(
    _i2.DatabaseSession session,
    List<DateTimeAttribute> rows, {
    _i2.ColumnSelections<DateTimeAttributeTable>? columns,
    _i2.Transaction? transaction,
  }) async {
    return session.db.update<DateTimeAttribute>(
      rows,
      columns: columns?.call(DateTimeAttribute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DateTimeAttribute]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DateTimeAttribute> updateRow(
    _i2.DatabaseSession session,
    DateTimeAttribute row, {
    _i2.ColumnSelections<DateTimeAttributeTable>? columns,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateRow<DateTimeAttribute>(
      row,
      columns: columns?.call(DateTimeAttribute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DateTimeAttribute] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DateTimeAttribute?> updateById(
    _i2.DatabaseSession session,
    _i2.UuidValue id, {
    required _i2.ColumnValueListBuilder<DateTimeAttributeUpdateTable>
    columnValues,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateById<DateTimeAttribute>(
      id,
      columnValues: columnValues(DateTimeAttribute.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DateTimeAttribute]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DateTimeAttribute>> updateWhere(
    _i2.DatabaseSession session, {
    required _i2.ColumnValueListBuilder<DateTimeAttributeUpdateTable>
    columnValues,
    required _i2.WhereExpressionBuilder<DateTimeAttributeTable> where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<DateTimeAttributeTable>? orderBy,
    _i2.OrderByListBuilder<DateTimeAttributeTable>? orderByList,
    bool orderDescending = false,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DateTimeAttribute>(
      columnValues: columnValues(DateTimeAttribute.t.updateTable),
      where: where(DateTimeAttribute.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DateTimeAttribute.t),
      orderByList: orderByList?.call(DateTimeAttribute.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DateTimeAttribute]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DateTimeAttribute>> delete(
    _i2.DatabaseSession session,
    List<DateTimeAttribute> rows, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.delete<DateTimeAttribute>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DateTimeAttribute].
  Future<DateTimeAttribute> deleteRow(
    _i2.DatabaseSession session,
    DateTimeAttribute row, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DateTimeAttribute>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DateTimeAttribute>> deleteWhere(
    _i2.DatabaseSession session, {
    required _i2.WhereExpressionBuilder<DateTimeAttributeTable> where,
    _i2.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DateTimeAttribute>(
      where: where(DateTimeAttribute.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<DateTimeAttributeTable>? where,
    int? limit,
    _i2.Transaction? transaction,
  }) async {
    return session.db.count<DateTimeAttribute>(
      where: where?.call(DateTimeAttribute.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DateTimeAttribute] rows matching the [where] expression.
  Future<void> lockRows(
    _i2.DatabaseSession session, {
    required _i2.WhereExpressionBuilder<DateTimeAttributeTable> where,
    required _i2.LockMode lockMode,
    required _i2.Transaction transaction,
    _i2.LockBehavior lockBehavior = _i2.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DateTimeAttribute>(
      where: where(DateTimeAttribute.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DateTimeAttributeAttachRowRepository {
  const DateTimeAttributeAttachRowRepository._();

  /// Creates a relation between the given [DateTimeAttribute] and [AccessLevel]
  /// by setting the [DateTimeAttribute]'s foreign key `accessLevelId` to refer to the [AccessLevel].
  Future<void> accessLevel(
    _i2.DatabaseSession session,
    DateTimeAttribute dateTimeAttribute,
    _i4.AccessLevel accessLevel, {
    _i2.Transaction? transaction,
  }) async {
    if (dateTimeAttribute.id == null) {
      throw ArgumentError.notNull('dateTimeAttribute.id');
    }
    if (accessLevel.id == null) {
      throw ArgumentError.notNull('accessLevel.id');
    }

    var $dateTimeAttribute = dateTimeAttribute.copyWith(
      accessLevelId: accessLevel.id,
    );
    await session.db.updateRow<DateTimeAttribute>(
      $dateTimeAttribute,
      columns: [DateTimeAttribute.t.accessLevelId],
      transaction: transaction,
    );
  }
}
