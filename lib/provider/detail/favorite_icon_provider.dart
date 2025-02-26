import 'package:flutter/widgets.dart';

class FavoriteIconProvider extends ChangeNotifier {
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  set isFavorited(bool value) {
    _isFavorite = value;
    notifyListeners();
  }
}
