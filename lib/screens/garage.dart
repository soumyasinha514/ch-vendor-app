import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:bma_cars/widgets/mechanic_profile.dart';
import 'package:bma_cars/models/mechanic.dart';
import 'package:bma_cars/models/garage.dart';
import 'package:bma_cars/providers/bike_car_list_provider.dart';
import 'package:bma_cars/widgets/mechanic_profile.dart';

class GarageScreen extends ConsumerStatefulWidget {
  GarageScreen({super.key});

  @override
  ConsumerState<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends ConsumerState<GarageScreen> {
  bool _isSelected1 = false;
  bool _isSelected2 = false;

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
  Widget build(BuildContext context) {
    final _bikeList = ref.watch(bikeListProvider);
    final _carList = ref.watch(carListProvider);

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Garage',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back)),
            bottom: TabBar(
                onTap: (value) {
                  if (value == 0) {
                    setState(() {
                      _isSelected1 = true;
                      _isSelected2 = false;
                    });
                  } else {
                    setState(() {
                      _isSelected2 = true;
                      _isSelected1 = false;
                    });
                  }
                },
                indicatorColor: const Color.fromARGB(255, 239, 110, 49),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/r_bike.png'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Bike',
                          style: TextStyle(
                              color: _isSelected1
                                  ? const Color.fromARGB(255, 239, 110, 49)
                                  : Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/r_car.png'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Car',
                          style: TextStyle(
                              color: _isSelected2
                                  ? const Color.fromARGB(255, 239, 110, 49)
                                  : Colors.grey[600]),
                        )
                      ],
                    ),
                  )
                ]),
          ),
          body: TabBarView(
            children: [
              _buildBikeTab(_bikeList),
              _buildCarTab(_carList),
            ],
          ),
        ));
  }
}

Widget _buildBikeTab(List<Bike> bikeList) {
  return ListView(
    children: bikeList
        .map((bike) => SingleChildScrollView(
          child: Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                    Material(elevation: 4, child: buildBikeExpansionTile(bike)),
              ),
        ))
        .toList(),
  );
}

Widget _buildCarTab(List<Car> carList) {
  return ListView(
    children: carList
        .map((car) => SingleChildScrollView(
          child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Material(elevation: 4, child: _buildCarExpansionTile(car)),
              ),
        ))
        .toList(),
  );
}

Widget buildBikeExpansionTile(Bike bike) {
  _GarageScreenState garage = _GarageScreenState();
  return ExpansionTile(
    childrenPadding: EdgeInsets.all(15),
    shape: RoundedRectangleBorder(
        side: BorderSide(color: Color.fromARGB(151, 158, 158, 158)),
        borderRadius: BorderRadius.circular(12)),
    title: Text(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      bike.client.name,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 50,
        width: 50,
        child: Image.asset(bike.client.photoUrl),
      ),
    ),
    subtitle: Text(garage._formatDateTime(bike.dateTime)),
    children: [
      Container(
        width: double.infinity,
        height: 144,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              bike.bikeDamageUrl,
              fit: BoxFit.cover,
            )),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Bike Damage Image',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                bike.bikeModel,
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 32, 29, 0)),
              )
            ],
          ),
          Spacer(),
          Column(
            children: [
              Text(
                'Condition',
                style: TextStyle(
                    fontSize: 13, color: Color.fromARGB(255, 32, 29, 0)),
              ),
              Text(
                bike.condition,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      ListTile(
        title: Text(
          'About Task',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          softWrap: true,
        ),
        subtitle: Text(
          bike.taskDesc,
          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 32, 29, 0)),
        ),
      ),
      MechanicProfile(mechanic: bike.mechanic),
      SizedBox(
        height: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Required parts',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 362,
            height: 200,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              children: [
                for (final i in bike.requiredParts)
                  Card(
                    child: Image.asset(i),
                  )
              ],
            ),
          ),
        ],
      )
    ],
  );
}

Widget _buildCarExpansionTile(Car car) {
  _GarageScreenState garage = _GarageScreenState();
  return ExpansionTile(
    childrenPadding: EdgeInsets.all(15),
    shape: RoundedRectangleBorder(
        side: BorderSide(color: Color.fromARGB(151, 158, 158, 158)),
        borderRadius: BorderRadius.circular(12)),
    title: Text(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      car.client.name,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 50,
        width: 50,
        child: Image.asset(car.client.photoUrl),
      ),
    ),
    subtitle: Text(garage._formatDateTime(car.dateTime)),
    children: [
      Container(
        width: double.infinity,
        height: 144,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              car.carDamageUrl,
              fit: BoxFit.cover,
            )),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Car Damage Image',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                car.carModel,
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 32, 29, 0)),
              )
            ],
          ),
          Spacer(),
          Column(
            children: [
              Text(
                'Condition',
                style: TextStyle(
                    fontSize: 13, color: Color.fromARGB(255, 32, 29, 0)),
              ),
              Text(
                car.condition,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      ListTile(
        title: Text(
          'About Task',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          softWrap: true,
        ),
        subtitle: Text(
          car.taskDesc,
          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 32, 29, 0)),
        ),
      ),
       MechanicProfile(mechanic: car.mechanic),
      SizedBox(
        height: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Required parts',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 362,
            height: 200,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              children: [
                for (final i in car.requiredParts)
                  Card(
                    child: Image.asset(i),
                  )
              ],
            ),
          ),
        ],
      )
    ],
  );
}
