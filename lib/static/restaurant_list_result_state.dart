import 'package:flutter/material.dart';

import '../data/model/endpoint/restaurant.dart';

sealed class TourismListResultState {}

class TourismListNoneState extends TourismListResultState {}

class TourismListLoadingState extends TourismListResultState {}

class TourismListErrorState extends TourismListResultState {
  final String error;

  TourismListErrorState(this.error);
}

class TourismListLoadedState extends TourismListResultState {
  final List<Restaurant> data;

  TourismListLoadedState(this.data);
}
