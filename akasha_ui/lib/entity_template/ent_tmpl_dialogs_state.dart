import 'package:akasha_client/akasha_client.dart';

sealed class EntityTemplatesState {
  List<EntityTmpl> items = [];
  bool? isLoading;
}

class EntityTemplatesStateInitial extends EntityTemplatesState {}

class EntityTemplatesStateOpenModalFor extends EntityTemplatesState {
  final EntityTmpl forItem;

  EntityTemplatesStateOpenModalFor({required this.forItem});
}

class EntityTemplatesStateLoading extends EntityTemplatesState {
  EntityTemplatesStateLoading() : super() {
    isLoading = true;
  }
}

class EntityTemplatesStateLoaded extends EntityTemplatesState {
  EntityTemplatesStateLoaded(List<EntityTmpl> items) : super() {
    this.items = items;
    isLoading = false;
  }
}

class EntityTemplatesStateError extends EntityTemplatesState {
  final String errorMessage;

  EntityTemplatesStateError({required this.errorMessage});
}
