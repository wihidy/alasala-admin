import 'package:ai_customer_service_stock_management_system/screens/chats.dart';
import 'package:ai_customer_service_stock_management_system/screens/home.dart';
import 'package:ai_customer_service_stock_management_system/screens/login.dart';
import 'package:ai_customer_service_stock_management_system/screens/orders.dart';
import 'package:ai_customer_service_stock_management_system/screens/reports.dart';
import 'package:ai_customer_service_stock_management_system/screens/stock.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alasala Admin',

      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Login(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainScreenState();
}

class _MainScreenState extends State<Main> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    Orders(),
    const Stock(),
    Chats(),
    const Reports(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[900],
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined),
            label: "Stock",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: "Reports",
          ),
        ],
      ),
    );
  }
}
