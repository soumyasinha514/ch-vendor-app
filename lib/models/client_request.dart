
import 'package:uuid/uuid.dart';
import'package:bma_cars/models/client.dart';
var uuid = Uuid();

enum VehicleType{ bike,car}

class Request {
 final String id;
 final VehicleType type;
 final DateTime receivedAt;
 final Client client;
 final String problem;
 final String aboutTask;
 final List<String> vehicleImages;

 Request({
  required this.type,
  required this.receivedAt,
  required this.client,
  required this.problem,
  required this.aboutTask,
  required this.vehicleImages
 }) : id= uuid.v4();

}