import 'package:ai_customer_service_stock_management_system/screens/notifications.dart';
import 'package:ai_customer_service_stock_management_system/screens/profile.dart';
import 'package:ai_customer_service_stock_management_system/screens/stock_manegment.dart';
import 'package:flutter/material.dart';

class Stock extends StatelessWidget {
  const Stock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          "Stock Management / المخزن",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Notifications()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
          ),
          Icon(Icons.refresh, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Summary Cards
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem("1", "Out of stock", "نفدت الكمية"),
                _buildSummaryItem("3", "Low", "منخفض"),
                _buildSummaryItem("24", "Products", "المنتجات"),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search product / البحث عن منتج ...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Filters
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip("All", true),
                SizedBox(width: 10),
                _buildFilterChip("Stock", false),
              ],
            ),
          ),

          SizedBox(height: 12),

          // Products List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                StockProductCard(
                  name: "زعفران ملكي\nSaffron Royal Special",
                  stockStatus: "Low / منخفض",
                  quantity: "12 g / جرام",
                  percentage: "24%",
                  color: Colors.orange,
                ),
                SizedBox(height: 12),
                StockProductCard(
                  name: "بخور الأصالة\nAl-Asala Oud Bakhoor",
                  stockStatus: "Available / متوفر",
                  quantity: "85 units / وحدة",
                  percentage: "82%",
                  color: Colors.green,
                ),
                SizedBox(height: 12),
                StockProductCard(
                  name: "دهن عود\nOud Sayufi Oil",
                  stockStatus: "Low / منخفض",
                  quantity: "45 ml / مل",
                  percentage: "31%",
                  color: Colors.orange,
                ),
              ],
            ),
          ),

          // Update Stock Button
          Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StockManagement(
                        productName: "حذاء رياضي نايك - أحمر (مقاس 42)",
                        currentStock: 42,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Update Stock / تحديث المخزون",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.swap_horiz, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String number, String titleEn, String titleAr) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 26,

            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(titleEn, style: TextStyle(fontSize: 12, color: Colors.black)),
        Text(titleAr, style: TextStyle(fontSize: 11, color: Colors.black)),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class StockProductCard extends StatelessWidget {
  final String name;
  final String stockStatus;
  final String quantity;
  final String percentage;
  final Color color;

  const StockProductCard({
    super.key,
    required this.name,
    required this.stockStatus,
    required this.quantity,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  stockStatus,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "الحد الأدنى",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    quantity,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$percentage ممتلئ",
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor:
                          double.parse(percentage.replaceAll('%', '')) / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.remove_circle_outline, color: Colors.grey),
              ),
              SizedBox(width: 20),
              Icon(
                Icons.add_circle_outline,
                color: Color(0xFF1E3A8A),
                size: 32,
              ),
              SizedBox(width: 20),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
