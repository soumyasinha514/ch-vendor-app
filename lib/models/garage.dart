
import'package:bma_cars/models/client.dart';
import 'package:bma_cars/models/mechanic.dart';

class Bike{
  final Client client;
  final DateTime dateTime;
  final String bikeDamageUrl;
  final String bikeModel;
  final String condition;
  final String taskDesc;
  final Mechanic mechanic;
  final List<String> requiredParts;

   Bike({required this.bikeDamageUrl,required this.bikeModel,required this.client,
   required this.condition,required this.dateTime,required this.mechanic,
   required this.requiredParts,required this.taskDesc});
}

class Car{
  final Client client;
  final DateTime dateTime;
  final String carDamageUrl;
  final String carModel;
  final String condition;
  final String taskDesc;
  final Mechanic mechanic;
  final List<String> requiredParts;

   Car({required this.carDamageUrl,required this.carModel,required this.client,
   required this.condition,required this.dateTime,required this.mechanic,
   required this.requiredParts,required this.taskDesc});
}


