import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bma_cars/models/vendor.dart';
import 'dart:io';

class VendorNotifier extends StateNotifier<Vendor>{
  VendorNotifier() :super(Vendor(name: '', profilePhoto: null,location: '',workshop_name: ''));

  void updateVendor(Vendor vendor){
    state = vendor;
  }

  void updateProfilePhoto(File photo){
    state = state.copyWith(profilePhoto: photo);
  }
}

final vendorProvider = StateNotifierProvider<VendorNotifier,Vendor>((ref) {
  return VendorNotifier();
},);