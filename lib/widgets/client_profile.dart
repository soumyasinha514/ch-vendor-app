import 'package:flutter/material.dart';
import 'package:bma_cars/models/client.dart';

class ClientProfile extends StatelessWidget {
  const ClientProfile({super.key, required this.client});

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
              radius: 23, backgroundImage: AssetImage(client.photoUrl)),
         const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  client.name,
                  style:const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  client.address,
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
