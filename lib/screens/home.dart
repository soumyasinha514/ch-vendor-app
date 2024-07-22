import 'package:bma_cars/providers/bike_car_list_provider.dart';
import 'package:bma_cars/providers/quotation_list_provider.dart';
import 'package:bma_cars/screens/garage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:bma_cars/widgets/user_profile.dart';
import 'package:bma_cars/screens/profile.dart';
import 'package:bma_cars/providers/request_list_provider.dart';
import 'package:bma_cars/models/client_request.dart';
import 'package:bma_cars/screens/request_screen.dart';
import 'package:bma_cars/screens/garage.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final now = DateTime.now();
  late String formattedDate;

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

  Future _pickDate() async {
    final pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime.now());
    if (pickedDate != null) {
      final date = DateFormat('dd-MMM-yyyy').format(pickedDate!);
      setState(() {
        formattedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GarageScreen garage = GarageScreen();
   
    formattedDate = DateFormat('dd-MMM-yyyy').format(now);
    final _requestList = ref.watch(requestListProvider);
    final request = _requestList[0];
    final _carsInGarage = ref.watch(carListProvider);
    final _bikesInGarage = ref.watch(bikeListProvider);
    final _pendingQuotations = ref.watch(quotationListProvider);
    final _requests = ref.watch(requestListProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ProfileScreen();
                    },
                  ));
                },
                child: Row(children: [
                  UserProfile(),
                ]),
              ),
              SizedBox(
                height: 25,
              ),
              Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 3,
                child: ListTile(
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
                  trailing: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return RequestScreen();
                          },
                        ));
                      },
                      child: Text(
                        'View',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w600),
                      )),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Text(
                    'Your Dashboard',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Spacer(),
                  Material(
                    elevation: 2,
                    child: Container(
                      height: 30,
                      width: 140,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Row(
                            children: [
                              Text(formattedDate),
                              Spacer(),
                              IconButton(
                                  padding: EdgeInsets.only(bottom: 8),
                                  onPressed: _pickDate,
                                  icon: Icon(
                                    Icons.calendar_month,
                                    color:
                                        const Color.fromARGB(255, 239, 110, 49),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 300,
                width: 350,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  children: [
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 110,
                          width: 170,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/r_car.png'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Cars in Garage',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '${_carsInGarage.length} Cars',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 110,
                          width: 170,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/r_bike.png'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Bikes in Garage',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text('${_bikesInGarage.length} Bikes',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 110,
                          width: 170,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.notifications_none,
                                    color:
                                        const Color.fromARGB(255, 239, 110, 49),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Requests',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text('${_requests.length} Requests',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          height: 110,
                          width: 170,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.mark_chat_unread_outlined,
                                    color:
                                        const Color.fromARGB(255, 239, 110, 49),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Pending Quotations',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text('${_pendingQuotations.length} Quotations',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Today's Tasks",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return GarageScreen();
                        }));
                      },
                      child: Text("See All",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 239, 110, 49))))
                ],
              ),
              SizedBox(
                width: 400,
                height: 500,
                child: ListView(
                    children: _bikesInGarage
                        .map((bike) => Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child:
                                              Material(elevation: 4, child:buildBikeExpansionTile(bike)),
                                        ))
                        .toList(),
                  ),
              ),
          
          
            ],
          ),
        ),
      ),
    );
  }
}
