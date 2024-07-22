import 'dart:io';
import 'package:bma_cars/screens/profile_details.dart';



class GarageDetails {
  final String garageImage;
  final String numWorkers;
  final String information;
  final List<Facility> selectedFacilityImageList;

  GarageDetails(
      {required this.garageImage,
      required this.information,
      required this.numWorkers,
      required this.selectedFacilityImageList});

     GarageDetails copyWith({String? garageImage, String? numWorkers, String? information, List<Facility>? selectedFacilityImageList}){
      return GarageDetails(garageImage: garageImage ?? this.garageImage,
       information: information ?? this.information, 
       numWorkers: numWorkers ?? this.numWorkers, 
       selectedFacilityImageList: selectedFacilityImageList?? this.selectedFacilityImageList);
     }
}
