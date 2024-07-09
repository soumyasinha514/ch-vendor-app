import 'package:bma_cars/data/dummy_requests.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bma_cars/models/client_request.dart';

class RequestListNotifier extends StateNotifier<List<Request>> {
  RequestListNotifier(List<Request> requestList) : super(requestList);

  void addRequest(Request request) {
    state = [...state, request];
  }

  void removeRequest(Request request) {
    state = state.where((item) => item.id != request.id).toList();
  }
}

final requestListProvider =
    StateNotifierProvider<RequestListNotifier, List<Request>>(
  (ref) {
    return RequestListNotifier(dummyRequests);
  },
);
