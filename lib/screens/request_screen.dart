import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bma_cars/providers/request_list_provider.dart';
import 'package:bma_cars/widgets/request_tile.dart';


class RequestScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(requestListProvider);

    return Scaffold(
      appBar: AppBar(
        title:Text('Requests',style: TextStyle(fontWeight: FontWeight.bold),),
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RequestTile(request: request),
            );
          },
        ),
      ),
    );
  }
}