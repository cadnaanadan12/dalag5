import 'package:flutter/foundation.dart';

import '../models/city.dart';

class CityProvider extends ChangeNotifier {
  City _currentCity = availableCities.first;

  City get currentCity => _currentCity;

  void setCity(City city) {
    if (_currentCity.id == city.id) return;
    _currentCity = city;
    notifyListeners();
  }
}
