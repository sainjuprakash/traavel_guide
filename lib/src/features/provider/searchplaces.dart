import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../authentication/models/auto_complete_results.dart';

final palceResultsProvider = ChangeNotifierProvider<PlaceResults>((ref) {
  return PlaceResults();
});

final searchToggleProvider = ChangeNotifierProvider((ref) {
  return SearchToggle();
});

class PlaceResults extends ChangeNotifier {
  List<AutoCompleteResult> allreturnedplaces = [];

  void setPlaces(allplaces) {
    allreturnedplaces = allplaces;
    notifyListeners();
  }
}

class SearchToggle extends ChangeNotifier {
  bool searchToggle = false;

  void toggleSearch() {
    searchToggle = !searchToggle;
    notifyListeners();
  }
}
