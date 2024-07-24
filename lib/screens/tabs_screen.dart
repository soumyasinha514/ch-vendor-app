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
  late PageController _pageController;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        children: [
          HomeScreen(),
          QuotationScreen(),
          NotificationScreen(),
          ProfileScreen(),
        ],
      ),
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
        )






    );
  }
}