import 'package:ai_customer_service_stock_management_system/screens/home.dart';
import 'package:ai_customer_service_stock_management_system/screens/login.dart';
import 'package:ai_customer_service_stock_management_system/screens/orders.dart';
import 'package:ai_customer_service_stock_management_system/screens/reports.dart';
import 'package:ai_customer_service_stock_management_system/screens/settings.dart';
import 'package:ai_customer_service_stock_management_system/screens/stock.dart';
import 'package:ai_customer_service_stock_management_system/supabase_config.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
    );
    debugPrint("✅ Supabase Initialized Successfully");
  } catch (e) {
    debugPrint("❌ Supabase Initialization Error: $e");
  }  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LanguageManager.localeNotifier,
      builder: (_, Locale currentLocale, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Alasala Admin',
          locale: currentLocale,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
          ),
          home: const Login(),
        );
      },
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
    const Reports(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LanguageManager.localeNotifier,
      builder: (context, locale, child) {
        bool isArabic = locale.languageCode == 'ar';
        return Scaffold(
          body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xFF1A3365),
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: (index) => setState(() => _currentIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: isArabic ? "الرئيسية" : "Home",
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart_outlined),
                label: isArabic ? "الطلبات" : "Orders",
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.store_outlined),
                label: isArabic ? "المخزن" : "Stock",
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.bar_chart_outlined),
                label: isArabic ? "التقارير" : "Reports",
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings_outlined),
                label: isArabic ? "الإعدادات" : "Settings",
              ),
            ],
          ),
        );
      },
    );
  }
}