import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  int _counter = 0;

  Map<String, bool> _favorites = {};

  bool isFavorite(String productId) {
    return _favorites[productId] ?? false;
  }



  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
  void toggleFavorite(String productId) {
    _favorites[productId] = !_favorites[productId]!;
    notifyListeners();
  }
}
