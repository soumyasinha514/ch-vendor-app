import 'package:bma_cars/models/vendor.dart';
import 'package:bma_cars/screens/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bma_cars/providers/vendor_provider.dart';



class DetailScreen extends ConsumerStatefulWidget {
  DetailScreen({super.key});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isToggle1 = true;
  bool _isToggle2 = true;
  String? _selectedValue;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _workshopNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(''),),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Become a vendor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        textCapitalization:TextCapitalization.words ,
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please enter valid name!';
                          }
                          return null;
                        },
                        maxLength: 50,
                        decoration: const InputDecoration(
                          hintText: 'Enter Your Name*',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(150, 0, 0, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _workshopNameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please enter valid Workshop name!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter Workshop Name*',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(150, 0, 0, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color.fromARGB(167, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(4)),
                        title: const Text('Do you have an active GST no.'),
                        titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.black),
                        subtitle:
                            const Text('Lorem Ipsum is simply dummy text'),
                        subtitleTextStyle: const TextStyle(
                            color: Color.fromARGB(150, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 10),
                        trailing: Switch(
                          value: _isToggle1,
                          onChanged: (value) {
                            setState(() {
                              _isToggle1 = value;
                            });
                          },
                          activeColor: const Color.fromARGB(255, 239, 110, 49),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please enter valid GST Number!';
                          }
                          return null;
                          
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter GST Number*',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(150, 0, 0, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _locationController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please enter your location!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter Location*',
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(150, 0, 0, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                    Icons.location_searching_rounded))),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Documents*',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please enter valid PAN No.!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter PAN Card no.*',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(150, 0, 0, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: 'Upload front side of the PAN card*',
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(197, 0, 113, 194),
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.upload))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color.fromARGB(167, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(4)),
                        title: const Text('Are you any company garage'),
                        titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.black),
                        subtitle:
                            const Text('Lorem Ipsum is simply dummy text'),
                        subtitleTextStyle: const TextStyle(
                            color: Color.fromARGB(150, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 10),
                        trailing: Switch(
                          value: _isToggle2,
                          onChanged: (value) {
                            setState(() {
                              _isToggle2 = value;
                            });
                          },
                          activeColor: const Color.fromARGB(255, 239, 110, 49),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'please select your company!';
                          }
                          return null;
                        },
                        value: _selectedValue,
                        decoration: const InputDecoration(
                            hintText: 'Select Your Company*',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(150, 0, 0, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                            border: OutlineInputBorder()),
                        items: <String>['option1', 'option2', 'option3']
                            .map((String item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: 'Upload Documents*',
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(197, 0, 113, 194),
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.upload))),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 339,
                height: 49,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 239, 110, 49),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref.read(vendorProvider.notifier).updateVendor(Vendor(
                          name: _nameController.text.toUpperCase(),
                          workshop_name: _workshopNameController.text,
                          location: _locationController.text));
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return ProfileDetailScreen();
                        },
                      ));
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
