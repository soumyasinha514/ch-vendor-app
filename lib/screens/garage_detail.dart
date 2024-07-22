import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:bma_cars/models/garage_details.dart';
import 'package:bma_cars/providers/garage_detail_provider.dart';
import 'package:bma_cars/models/vendor.dart';
import 'package:bma_cars/providers/vendor_provider.dart';
import'package:bma_cars/screens/profile_details.dart';

class GarageDetailScreen extends ConsumerStatefulWidget {
  const GarageDetailScreen({super.key});

  @override
  ConsumerState<GarageDetailScreen> createState() => _GarageDetailScreenState();
}

class _GarageDetailScreenState extends ConsumerState<GarageDetailScreen> {
  File? _pickedGargePhoto;
  final _picker = ImagePicker();
  final TextEditingController _workerController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
   final Map<String, Facility> _facilityMap = {
    'assets/images/facilities/Frame 184.png': Facility.TyresAndWheelCare,
    'assets/images/facilities/Frame 185.png': Facility.Batteries,
    'assets/images/facilities/Frame 186.png': Facility.acServicesAndRepair,
    'assets/images/facilities/Frame 187.png': Facility.DentingAndPainting,
    'assets/images/facilities/Frame 188.png': Facility.SuspensionAndFitments,
    'assets/images/facilities/Frame 189.png': Facility.ClutchAndBodyparts
  };
  List<Facility> _selectedFacilities = [];

   void _toggleSelection(Facility facility) {
    setState(() {
      if (_selectedFacilities.contains(facility)) {
        _selectedFacilities.remove(facility);
      } else {
        _selectedFacilities.add(facility);
      }
    });
  }

  void _pickGaragePhoto() async {
    final pickedPhoto = await _picker.pickImage(source: ImageSource.camera);
    if (pickedPhoto != null) {
      setState(() {
        _pickedGargePhoto = File(pickedPhoto.path);
      });
     
    }
  }

  @override
  Widget build(BuildContext context) {
    final garageDetails = ref.watch(garageDetailProvider);
    final vendor = ref.watch(vendorProvider);
    final File _file = File(garageDetails.garageImage.toString());
    _workerController.text = garageDetails.numWorkers;
    _infoController.text = garageDetails.information;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Garage Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 144,
                  width: double.infinity,
                  child:  Image.file(
                    _file ,
                    fit: BoxFit.cover,
                  ) ,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '${vendor.workshop_name} Garage',
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        softWrap: true,
                        '${vendor.location}',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                      onPressed: _pickGaragePhoto, child: Text('Upload Photo'))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text('Workers'),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                      suffix: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: const Color.fromARGB(255, 239, 110, 49),
                    ),
                    onPressed: () {
                     _workerController.clear();
                    },
                  )),
                  controller: _workerController,
                  onChanged: (value) {
                    setState(() {
                      _workerController.text = value;
                      ref
                          .read(garageDetailProvider.notifier)
                          .updateWorkers(_workerController.text);
                    });
                  },
                ),
              ),
             
              SizedBox(
                height: 10,
              ),
              Text('Information'),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: TextFormField(
                   controller: _infoController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                      suffix: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: const Color.fromARGB(255, 239, 110, 49),
                    ),
                    onPressed: () {
                     _infoController.clear();
                    },
                  )),
                 
                  onChanged: (value) {
                    setState(() {
                      _infoController.text = value;
                      ref
                          .read(garageDetailProvider.notifier)
                          .updateInfo(_infoController.text);
                    });
                  },
                ),
              ),
               SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Select Facilities',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 362,
                      height: 200,
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        children: [
                          for (int i = 184; i <= 189; i++)
                            GestureDetector(
                              onTap: () {
                                _toggleSelection(_facilityMap[
                                    'assets/images/facilities/Frame ${i}.png']!);
                              },
                              child: Card(
                                color: _selectedFacilities.contains(_facilityMap[
                                        'assets/images/facilities/Frame ${i}.png'])
                                    ? Color.fromARGB(255, 243, 192, 168)
                                    : null,
                                child: Image.asset(
                                    'assets/images/facilities/Frame ${i}.png'),
                              ),
                            )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                     SizedBox(
                width: double.infinity,
                height: 49,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 239, 110, 49),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    ref.read(garageDetailProvider.notifier).updateGarage(
                      GarageDetails(garageImage: _pickedGargePhoto!.path,
                       information: _infoController.text,
                        numWorkers: _workerController.text,
                         selectedFacilityImageList: _selectedFacilities));

                         Navigator.of(context).pop();
                  
                  },
                  child: const Text(
                    'Update Details',
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
        ),
      ),
    );
  }
}
