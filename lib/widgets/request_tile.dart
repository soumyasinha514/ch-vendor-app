import 'package:bma_cars/widgets/client_profile.dart';
import 'package:flutter/material.dart';
import 'package:bma_cars/models/client_request.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bma_cars/providers/request_list_provider.dart';

class RequestTile extends ConsumerWidget {
  final Request request;

  RequestTile({required this.request});

  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dt.year, dt.month, dt.day);

    if (date == today) {
      return 'Today,${DateFormat('hh:mm a').format(dt)}';
    } else {
      return DateFormat('dd-MM-yy ,hh:mm a').format(dt);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      elevation: 4,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(151, 158, 158, 158)),
            borderRadius: BorderRadius.circular(12)),
        leading: Image.asset(
          request.type == VehicleType.bike
              ? 'assets/images/r_bike.png'
              : 'assets/images/r_car.png',
          width: 40,
          height: 40,
        ),
        title: Text(
          'Request for ${request.type == VehicleType.bike ? 'Bike' : 'Car'} Repair',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(_formatDateTime(request.receivedAt)),
        children: [
          ClientProfile(client: request.client),
          ListTile(
            title: Text(
              'Problem',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(request.problem),
          ),
          ListTile(
            title: Text(
              'About Task',
              style: TextStyle(fontWeight: FontWeight.w600),
              softWrap: true,
            ),
            subtitle: Text(
              request.aboutTask,
            ),
          ),
          ListTile(
            title: Text(
              'Vehicle Images',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: request.vehicleImages.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(request.vehicleImages[index]),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 38,
                width: 148,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 128, 128, 128),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    ref
                        .read(requestListProvider.notifier)
                        .removeRequest(request);
                  },
                  child: const Text(
                    'Reject',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 38,
                width: 148,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 239, 110, 49),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    // accept logic
                  },
                  child: const Text(
                    'Accept',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
