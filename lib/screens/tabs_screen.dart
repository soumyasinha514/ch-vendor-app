import 'package:bma_cars/screens/home.dart';
import 'package:bma_cars/screens/profile.dart';
import 'package:bma_cars/screens/quotation_screen.dart';
import 'package:bma_cars/screens/notification.dart';
import 'package:flutter/material.dart';



class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  var _selectedPageIndex = 0;

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = HomeScreen();

    if (_selectedPageIndex == 1) {
      activeScreen = QuotationScreen();
    }
    if (_selectedPageIndex == 2) {
      activeScreen = NotificationScreen();
    }
    if (_selectedPageIndex == 3) {
      activeScreen = ProfileScreen();
    }

    return Scaffold(
        body: activeScreen,
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: _selectPage,
          selectedIndex: _selectedPageIndex,
          destinations:  [
            NavigationDestination(
              selectedIcon: const Icon(
                  Icons.house_siding_rounded,
                  color:  Color.fromARGB(255, 239, 110, 49),
                ),
                icon: Icon(
                  Icons.house_siding_rounded,
                  color: Colors.grey[600],
                ),
                label: 'Home'),
            NavigationDestination(
               selectedIcon: const Icon(
                   Icons.mark_chat_unread_outlined,
                  color:  Color.fromARGB(255, 239, 110, 49),
                ),
                icon: Icon(
                  Icons.mark_chat_unread_outlined,
                  color:  Colors.grey[600],
                ),
                label: 'Quotations'),
            NavigationDestination(
               selectedIcon: const Icon(
                   Icons.notifications_none_outlined,
                  color:  Color.fromARGB(255, 239, 110, 49),
                ),
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color:  Colors.grey[600],
                ),
                label: 'Notifications'),
            NavigationDestination(
               selectedIcon: const Icon(
                   Icons.person,
                  color:  Color.fromARGB(255, 239, 110, 49),
                ),
                icon: Icon(
                  Icons.person,
                  color:  Colors.grey[600],
                ),
                label: 'Profile')
          ],
        ));
  }
}
