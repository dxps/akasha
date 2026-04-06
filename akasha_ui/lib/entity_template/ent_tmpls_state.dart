import 'package:akasha_client/akasha_client.dart';

class EntityTemplatesState {
  List<EntityTmpl> items = [];
  bool? isLoading;

  EntityTemplatesState();
  EntityTemplatesState.initial();

  (EntityTmpl? item, bool isEmpty) getItemById(UuidValue id) {
    final item = items.firstWhere((ent) => ent.id == id, orElse: () => EntityTmpl(name: ''));
    return (isEntityTmplEmpty(item) ? (null, true) : (item, false));
  }
}

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

  EntityTemplatesStateError({required this.errorMessage}) : super() {
    isLoading = false;
  }
}

/// Tells if the given entity template is "empty", meaning it has no attributes or links fetched from the backend.
/// Used to determine if we can return a cached version of the entity template or if we need to fetch it completely from the server.
bool isEntityTmplEmpty(EntityTmpl item) {
  return item.attributes?.isEmpty ?? true;
}
