import 'package:bma_cars/screens/garage_detail.dart';
import 'package:bma_cars/screens/profile_details.dart';
import 'package:flutter/material.dart';

import 'package:bma_cars/widgets/user_profile.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                UserProfile(),
             
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return GarageDetailScreen();
                        },
                      ),
                    );
                  },
                  label: const Text(
                    'Garage',
                    style: TextStyle(
                      color: Color.fromARGB(255, 239, 110, 49),
                    ),
                  ),
                  icon: const Icon(
                    Icons.house_siding,
                    color: Color.fromARGB(255, 239, 110, 49),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.person_2_outlined,
                color: const Color.fromARGB(255, 239, 110, 49),
              ),
              title: Text('Profile'),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ProfileDetailScreen();
                      },
                    ));
                  },
                  icon: Icon(Icons.arrow_forward_ios_sharp)),
            )
          ],
        ),
      ),
    );
  }
}
