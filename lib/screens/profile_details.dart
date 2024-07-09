import 'package:bma_cars/screens/home.dart';
import 'package:bma_cars/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bma_cars/providers/vendor_provider.dart';
import 'dart:io';
import 'package:bma_cars/models/vendor.dart';

enum Gender { male, female, other }

enum Facility {
  acServicesAndRepair,
  TyresAndWheelCare,
  Batteries,
  DentingAndPainting,
  SuspensionAndFitments,
  ClutchAndBodyparts
}

class ProfileDetailScreen extends ConsumerStatefulWidget {
  ProfileDetailScreen({super.key});

  @override
  ConsumerState<ProfileDetailScreen> createState() =>
      _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends ConsumerState<ProfileDetailScreen> {
  final TextEditingController _dateController = TextEditingController();

  final formatter = DateFormat.yMd();
  Gender? _selectedGender;
  final _picker = ImagePicker();
  File? _pickedGargePhoto;
  final Map<String, Facility> _facilityMap = {
    'assets/images/facilities/Frame 184.png': Facility.TyresAndWheelCare,
    'assets/images/facilities/Frame 185.png': Facility.Batteries,
    'assets/images/facilities/Frame 186.png': Facility.acServicesAndRepair,
    'assets/images/facilities/Frame 187.png': Facility.DentingAndPainting,
    'assets/images/facilities/Frame 188.png': Facility.SuspensionAndFitments,
    'assets/images/facilities/Frame 189.png': Facility.ClutchAndBodyparts
  };
  List<Facility> _selectedFacilities = [];
  final _formKey = GlobalKey<FormState>();

  void _toggleSelection(Facility facility) {
    setState(() {
      if (_selectedFacilities.contains(facility)) {
        _selectedFacilities.remove(facility);
      } else {
        _selectedFacilities.add(facility);
      }
    });
  }

  Future _pickDate() async {
    final pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime.now());
    setState(() {
      _dateController.text = formatter.format(pickedDate!);
    });
  }

  void _pickProfilePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      ref.read(vendorProvider.notifier).updateProfilePhoto(file);
    }
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
    final Vendor vendor = ref.watch(vendorProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Your Profile',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        UserProfile(),
                       // Spacer(),
                        ElevatedButton(
                            onPressed: _pickProfilePhoto,
                            child: Text('Upload Photo'))
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Personal Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.trim().contains('.com')) {
                          return 'please enter valid email!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter Email*',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(150, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length > 10) {
                          return 'please enter a 10-digit phone No. ';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Enter additional phone no.',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(150, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _dateController,
                      validator: (value) {
                        if (_dateController.text == '') {
                          return 'please select your DOB';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter Date-Of-Birth',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(150, 0, 0, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.calendar_month_rounded,
                              color: const Color.fromARGB(255, 239, 110, 49),
                            ),
                            onPressed: () {
                              _pickDate();
                            },
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormField(
                      validator: (value) {
                        if (value == null) {
                          return 'please choose your gender!';
                        }
                        return null;
                      },
                      builder: (FormFieldState<Gender> state) {
                        return Container(
                          padding: EdgeInsets.all(2),
                          width: 362,
                          height: 102,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: const Color.fromARGB(126, 0, 0, 0))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '   Select Gender*',
                                style: TextStyle(
                                    color: Color.fromARGB(150, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor:
                                            Color.fromARGB(255, 239, 110, 49),
                                        value: Gender.male,
                                        groupValue: _selectedGender,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedGender = value!;
                                          });
                                        },
                                      ),
                                      Text('Male'),
                                      Radio(
                                        activeColor:
                                            Color.fromARGB(255, 239, 110, 49),
                                        value: Gender.female,
                                        groupValue: _selectedGender,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedGender = value!;
                                          });
                                        },
                                      ),
                                      Text('Female'),
                                      Radio(
                                        activeColor:
                                            Color.fromARGB(255, 239, 110, 49),
                                        value: Gender.other,
                                        groupValue: _selectedGender,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedGender = value!;
                                          });
                                        },
                                      ),
                                      Text('Other')
                                    ],
                                  ),
                                  if (state.hasError)
                                    Text(
                                      state.errorText!,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 205, 20, 6),
                                          fontSize: 12),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Garage Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormField(
                      validator: (value) {
                        if (value == null) {
                          return 'please upload your garage photo!';
                        }
                        return null;
                      },
                      builder: (FormFieldState state) {
                        return Column(
                          children: [
                            Container(
                                width: 362,
                                height: 134,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            126, 0, 0, 0))),
                                child: _pickedGargePhoto == null
                                    ? Column(
                                        children: [
                                          Icon(
                                            Icons.house_siding_rounded,
                                            size: 100,
                                            color: const Color.fromARGB(
                                                126, 0, 0, 0),
                                          ),
                                          Text('Upload Garage Photo')
                                        ],
                                      )
                                    : Image.file(
                                        _pickedGargePhoto!,
                                        fit: BoxFit.cover,
                                      )),
                            if (state.hasError)
                              Text(
                                state.errorText!,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 205, 20, 6),
                                    fontSize: 12),
                              ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text('${vendor.workshop_name} Garage',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            Text('${vendor.location}',style: TextStyle(fontSize: 11),)
                          ],
                        ),
                        Spacer(),
                        ElevatedButton(
                            onPressed: _pickGaragePhoto,
                            child: Text('Upload Photo'))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter workers!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter Workers*',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(150, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Add Additional Information',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(150, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        border: OutlineInputBorder(),
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
                    Container(
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
                  ],
                ),
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}