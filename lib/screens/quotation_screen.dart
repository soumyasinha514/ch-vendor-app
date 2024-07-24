import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bma_cars/providers/quotation_list_provider.dart';
import 'package:bma_cars/widgets/quotation_tile.dart';

class QuotationScreen extends ConsumerWidget {
  QuotationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotations = ref.watch(quotationListProvider);

    return Scaffold(
     /* appBar: AppBar(
        title: Text(
          'Quotations',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      
      ),*/
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Padding(
                        padding: const EdgeInsets.only(top: 30,bottom: 10,left: 8),
                        child: Text(
                          'Quotations',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
            Expanded(
              child: ListView.builder(
                itemCount: quotations.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuotationTile(quotation: quotations[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
