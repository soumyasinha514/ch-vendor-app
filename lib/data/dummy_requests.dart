import 'package:bma_cars/models/client_request.dart';
import 'package:bma_cars/models/client.dart';

List<Request> dummyRequests = [
  Request(
      client: Client.charlie(),
      type: VehicleType.bike,
      receivedAt: DateTime.now(),
      aboutTask:
          'Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.',
      problem: 'Flat tire and suspension problem',
      vehicleImages: [
        'assets/images/vehicle_images/vehicle1.png',
        'assets/images/vehicle_images/vehicle2.png',
        'assets/images/vehicle_images/vehicle3.png',
        'assets/images/vehicle_images/vehicle4.png'
      ]),

       Request(
      client: Client.charlie(),
      type: VehicleType.car,
      receivedAt: DateTime.now(),
      aboutTask:
          'Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.',
      problem: 'The car engine is making strange noises.',
      vehicleImages: [
        'assets/images/vehicle_images/vehicle1.png',
        'assets/images/vehicle_images/vehicle2.png',
        'assets/images/vehicle_images/vehicle3.png',
        'assets/images/vehicle_images/vehicle4.png'
      ]),
      Request(
      client: Client.charlie(),
      type: VehicleType.car,
      receivedAt: DateTime.now(),
      aboutTask:
          'Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.',
      problem: 'The car engine is making strange noises.',
      vehicleImages: [
        'assets/images/vehicle_images/vehicle1.png',
        'assets/images/vehicle_images/vehicle2.png',
        'assets/images/vehicle_images/vehicle3.png',
        'assets/images/vehicle_images/vehicle4.png'
      ]),
      Request(
      client: Client.charlie(),
      type: VehicleType.car,
      receivedAt: DateTime.now(),
      aboutTask:
          'Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.Repair the flat tire and check the brakes.',
      problem: 'The car engine is making strange noises.',
      vehicleImages: [
        'assets/images/vehicle_images/vehicle1.png',
        'assets/images/vehicle_images/vehicle2.png',
        'assets/images/vehicle_images/vehicle3.png',
        'assets/images/vehicle_images/vehicle4.png'
      ])
];
