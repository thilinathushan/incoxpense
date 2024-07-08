// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../app_style.dart';
import '../../pages/add_transaction_page.dart';
import '../../pages/charts_page.dart';
import '../../pages/home_page.dart';
import '../../pages/listing_page.dart';
import '../../pages/transaction_page.dart';
import '../../providers/user_widget_provider.dart';
import '../app_drawer.dart';
import '../custom_appbar.dart';

class MainLayout extends StatefulWidget {
  int? selectedIndex;

  MainLayout({this.selectedIndex, super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    UserWidgetProvider.of(context).setUserWidget(null);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.selectedIndex != null) {
      setState(() {
        _selectedIndex = widget.selectedIndex!;
      });
    }
    super.initState();
  }

  final pages = [
    const HomePage(),
    const TransactionPage(),
    ChartsPage(),
    const ListingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final userWidget = UserWidgetProvider.of(context).userWidget;
    // print('Building MainLayout with content: ${userWidget}');

    final bottomNavBar = BottomNavigationBar(
      selectedLabelStyle: const TextStyle(
        color: kPrimaryMenuSelectedColor,
        // fontSize: 15,
      ),
      unselectedLabelStyle: const TextStyle(
        color: kPrimaryMenuColor,
        // fontSize: 15,
      ),
      currentIndex: _selectedIndex,
      onTap: _navigateBottomBar,
      type: BottomNavigationBarType.fixed,
      useLegacyColorScheme: false,
      items: [
        BottomNavigationBarItem(
            icon: Image.asset('assets/menu/home.png',
                height: 30,
                color: _selectedIndex == 0
                    ? kPrimaryMenuSelectedColor
                    : kPrimaryMenuColor),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Image.asset('assets/menu/transaction.png',
                height: 30,
                color: _selectedIndex == 1
                    ? kPrimaryMenuSelectedColor
                    : kPrimaryMenuColor),
            label: "Transactions"),
        BottomNavigationBarItem(
          icon: Image.asset('assets/menu/chart.png',
              height: 30,
              color: _selectedIndex == 2
                  ? kPrimaryMenuSelectedColor
                  : kPrimaryMenuColor),
          label: "Charts",
        ),
        BottomNavigationBarItem(
            icon: Image.asset('assets/menu/listing.png',
                height: 30,
                color: _selectedIndex == 3
                    ? kPrimaryMenuSelectedColor
                    : kPrimaryMenuColor),
            label: "Listing"),
      ],
    );

    return PopScope(
      canPop: false,
      child: Container(
        color: kPrimaryWhite,
        child: Scaffold(
          appBar: const CustomAppBar(),
          drawer: AppDrawer(),
          body: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: userWidget ?? pages[_selectedIndex],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTransactionPage(),
                ),
              );
            },
            backgroundColor: kPrimaryMenuSelectedColor,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: const Icon(
              Icons.add,
              color: kDarkWhiteColor,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: bottomNavBar,
        ),
      ),
    );
  }
}
