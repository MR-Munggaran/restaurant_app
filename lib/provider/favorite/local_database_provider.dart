import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_detail.dart';
import 'package:restaurant_app/data/sql/local_database_service.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  LocalDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<RestaurantDetail>? _restaurantList;
  List<RestaurantDetail>? get restaurantList => _restaurantList;

  RestaurantDetail? _restaurant;
  RestaurantDetail? get restaurant => _restaurant;

  Future<void> saveRestaurantValue(RestaurantDetail value) async {
    try {
      final id = await _service.insertItem(value);
      if (id == '-1') {
        _message = "Failed to save your data";
      } else {
        _message = "Your data is saved";
      }
      notifyListeners();
    } catch (e) {
      _message = "Failed to save your data: ${e.toString()}";
      notifyListeners();
    }
  }

  Future<void> loadAllRestaurantValue() async {
    try {
      _restaurantList = await _service.getAllItems();
      _message = "All of your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your all data: ${e.toString()}";
      notifyListeners();
    }
  }

  Future<void> loadRestaurantValueById(String id) async {
    try {
      _restaurant = await _service.getItemById(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your data: ${e.toString()}";
      notifyListeners();
    }
  }

  Future<void> removeRestaurantValueById(String id) async {
    try {
      await _service.removeItem(id);
      _message = "Your data is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your data: ${e.toString()}";
      notifyListeners();
    }
  }
}
