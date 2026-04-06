import 'package:akasha_client/akasha_client.dart';

class AttributeTemplatesState {
  List<AttributeTmpl> items = [];
  bool isLoading = false;

  AttributeTemplatesState();
  AttributeTemplatesState.initial();
}

class AttributeTemplatesLoadingState extends AttributeTemplatesState {
  AttributeTemplatesLoadingState() : super() {
    isLoading = true;
  }
}

class AttributeTemplatesLoadedState extends AttributeTemplatesState {
  AttributeTemplatesLoadedState(List<AttributeTmpl> items) {
    this.items = items;
    isLoading = false;
  }
}

class AttributeTemplatesLoadErrorState extends AttributeTemplatesState {
  final String errorMessage;

  AttributeTemplatesLoadErrorState({required this.errorMessage}) {
    isLoading = false;
  }
}

class AttributeTemplatesStateOpenModalFor extends AttributeTemplatesState {
  final AttributeTmpl forItem;

  AttributeTemplatesStateOpenModalFor({required this.forItem});
}
