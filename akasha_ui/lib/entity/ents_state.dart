import 'package:akasha_client/akasha_client.dart';
import 'package:equatable/equatable.dart';

enum EntitiesStatus { initial, loading, success, failure }

class EntitiesState extends Equatable {
  final EntitiesStatus status;
  final List<Entity> entities;

  const EntitiesState({
    this.status = EntitiesStatus.initial,
    this.entities = const [],
  });

  EntitiesState copyWith({
    EntitiesStatus? status,
    List<Entity>? entities,
  }) {
    return EntitiesState(
      status: status ?? this.status,
      entities: entities ?? this.entities,
    );
  }

  @override
  List<Object> get props => [status, entities];
}
