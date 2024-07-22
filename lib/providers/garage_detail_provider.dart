import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:bma_cars/models/garage_details.dart';
import 'package:bma_cars/screens/profile_details.dart';

class GarageDetailNotifier extends StateNotifier<GarageDetails>{
  GarageDetailNotifier() :super(GarageDetails(garageImage: '', information: '', numWorkers: '', selectedFacilityImageList: []));

  void updateGarage(GarageDetails garage){
    state = garage;
  }


  void updateImage(String path){
    state = state.copyWith(garageImage: path);

  }

  void updateWorkers(String numWorkers){
    state = state.copyWith(numWorkers: numWorkers);
  }

void updateInfo(String info){
  state = state.copyWith(information: info);
}


void updateFacilityList(List<Facility> list){
  state = state.copyWith(selectedFacilityImageList: list);
}

}




final garageDetailProvider = StateNotifierProvider<GarageDetailNotifier,GarageDetails>((ref) {
  return GarageDetailNotifier();
},);