import 'package:akasha_client/akasha_client.dart';
import 'package:equatable/equatable.dart';

sealed class EntityTemplatesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EntityTemplatesStateInitial extends EntityTemplatesState {}

class EntityTemplatesStateOpenModalFor extends EntityTemplatesState {
  final UuidValue id;

  EntityTemplatesStateOpenModalFor({required this.id});
}
