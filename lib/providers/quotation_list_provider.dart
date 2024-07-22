import 'package:bma_cars/data/dummy_quotations.dart';
import 'package:bma_cars/models/quotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class QuotationListNotifier extends StateNotifier<List<Quotation>> {
  QuotationListNotifier(List<Quotation> quotationList) : super(quotationList);

  void addQuotation(Quotation quotation) {
    state = [...state, quotation];
  }

  void removeQuotation(Quotation quotation) {
    state = state.where((item) => item.id != quotation.id).toList();
  }
}

final quotationListProvider =
    StateNotifierProvider<QuotationListNotifier, List<Quotation>>(
  (ref) {
    return QuotationListNotifier(dummyQuotations);
  },
);