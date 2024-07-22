import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bma_cars/models/mechanic.dart';

class MechanicProfile extends StatelessWidget {
  MechanicProfile({super.key, required this.mechanic});

  final Mechanic mechanic;

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(decoration: BoxDecoration(color: Colors.black,),
                height: 50, width: 50, child: Image.asset(mechanic.photoUrl)),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      mechanic.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _formatDateTime(mechanic.dateTime),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      mechanic.status,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 3, 149, 8),
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
