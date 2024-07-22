import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bma_cars/screens/notification.dart';

final notificationListProvider = Provider<List<Notification>>((ref) {
  return nList;
},);