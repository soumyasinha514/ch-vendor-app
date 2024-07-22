import 'package:flutter/material.dart';
import 'package:bma_cars/models/vendor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bma_cars/providers/vendor_provider.dart';

class UserProfile extends ConsumerWidget {
  UserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Vendor vendor = ref.watch(vendorProvider);
    return Expanded(
      child: Row(
        children: [CircleAvatar(radius: 23,
          backgroundImage:  vendor.profilePhoto == null
                  ? AssetImage('assets/images/placeholder.png')
                  : FileImage(vendor.profilePhoto!),)
          ,
         
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  vendor.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ID: ${vendor.id}',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
