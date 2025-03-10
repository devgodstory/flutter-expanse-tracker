import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/src/pages/account/account_page.dart';
import 'package:flutter_expense_tracker/src/pages/home/home_page.dart';
import 'package:flutter_expense_tracker/src/pages/overview/overview_page.dart';
import 'package:flutter_expense_tracker/src/pages/transaction/transaction_page.dart';
import 'package:flutter_expense_tracker/src/pages/home/widgets/add_transaction.dart';
import 'package:flutter_expense_tracker/src/pages/home/widgets/icon_button_with_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(title: 'Home'),
    TransactionPage(),
    OverviewPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openAddTransactionPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTransactionPage()), // เมื่อกดปุ่ม + เปิด AddTransactionPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Expense Tracker'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              spreadRadius: 2,
              offset: Offset(0, -3), // เงาอยู่ด้านบน
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 1.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: IconButtonWithText(
                  icon: Icons.home,
                  label: 'หน้าหลัก',
                  onTap: () {
                    _onItemTapped(0);
                  },
                ),
              ),
              Expanded(
                child: IconButtonWithText(
                  icon: Icons.business,
                  label: 'ธุรกรรม',
                  onTap: () {
                    _onItemTapped(1);
                  },
                ),
              ),
              Spacer(),
              Expanded(
                child: IconButtonWithText(
                  icon: Icons.dashboard,
                  label: 'ภาพรวม',
                  onTap: () {
                    _onItemTapped(2);
                  },
                ),
              ),
              Expanded(
                child: IconButtonWithText(
                  icon: Icons.account_box,
                  label: 'บัญชี',
                  onTap: () {
                    _onItemTapped(3);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: _openAddTransactionPage,
          backgroundColor: Colors.red,
          shape: CircleBorder(),
          elevation: 8.0,
          child: Icon(Icons.add, size: 45, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
