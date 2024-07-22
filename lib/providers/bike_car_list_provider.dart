import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bma_cars/models/garage.dart';
import 'package:bma_cars/data/dummy_garage.dart';

class BikeListNotifier extends StateNotifier<List<Bike>> {
  BikeListNotifier(List<Bike> bikeList) : super(bikeList);

  void addBike(Bike bike) {
    state = [...state, bike];
  }
}

final bikeListProvider = StateNotifierProvider<BikeListNotifier, List<Bike>>(
  (ref) {
   return BikeListNotifier(dummyBikes);
  },
);


class CarListNotifier extends StateNotifier<List<Car>> {
  CarListNotifier(List<Car> carList) : super(carList);

  void addCar(Car car) {
    state = [...state, car];
  }
}

final carListProvider = StateNotifierProvider<CarListNotifier, List<Car>>(
  (ref) {
   return CarListNotifier(dummyCars);
  },
);
