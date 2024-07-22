import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bma_cars/providers/notification_list_provider.dart';

class Notification {
  final String text;
  final String icon;

  Notification({required this.text}) : icon = 'assets/images/carhome.png';
}

List<Notification> nList = [
  Notification(
      text:
          'You have got a quotation approval.Please open quotations in app to approve the quotation'),
  Notification(
      text:
          'You have got a quotation approval.Please open quotations in app to approve the quotation'),
  Notification(
      text:
          'You have got a quotation approval.Please open quotations in app to approve the quotation'),
  Notification(
      text:
          'You have got a quotation approval.Please open quotations in app to approve the quotation'),
  Notification(
      text:
          'You have got a quotation approval.Please open quotations in app to approve the quotation'),
  Notification(
      text:
          'You have got a quotation approval.Please open quotations in app to approve the quotation'),
  Notification(
      text:
          'You have got a quotation approval.Please open quotations in app to approve the quotation'),
];

class NotificationScreen extends ConsumerWidget {
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _list = ref.watch(notificationListProvider);
    return Scaffold(appBar: AppBar(title: Text('Notifications',style: TextStyle(fontWeight: FontWeight.bold),),),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return Material(elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/images/carhome.png'),
                ),
                subtitle: Text(_list[index].text,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14),
                softWrap: true,),
              ),
            ),
          );
        },
      ),
    ),);
  }
}
