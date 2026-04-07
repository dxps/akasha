import 'package:akasha_client/akasha_client.dart';

class AccessLevelsState {
  List<AccessLevel> items = [];
  bool isLoading = false;

  AccessLevelsState();
  AccessLevelsState.initial();
  AccessLevelsState.loaded({required this.items}) {
    isLoading = false;
  }
}

class AccessLevelLoadingState extends AccessLevelsState {
  AccessLevelLoadingState() : super() {
    isLoading = true;
  }
}

class AccessLevelLoadedState extends AccessLevelsState {
  AccessLevelLoadedState(List<AccessLevel> items) : super.loaded(items: items);
}

class AccessLevelLoadErrorState extends AccessLevelsState {
  final String errorMessage;

  AccessLevelLoadErrorState({required this.errorMessage}) {
    isLoading = false;
  }
}

class AccessLevelsStateOpenModalFor extends AccessLevelsState {
  final AccessLevel forItem;

  AccessLevelsStateOpenModalFor({required this.forItem});
}
