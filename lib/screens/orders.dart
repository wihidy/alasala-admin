import 'package:ai_customer_service_stock_management_system/screens/notifications.dart';
import 'package:ai_customer_service_stock_management_system/screens/profile.dart';
import 'package:ai_customer_service_stock_management_system/screens/order_details.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(Icons.person_outline, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Notifications()),
              );
            },
          ),
          SizedBox(width: 20),
        ],
        title: Text(
          "Orders",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(18),
            child: Row(
              children: [
                _buildTab("Confirmed", false),
                SizedBox(width: 8),
                _buildTab("Pending", false),
                const SizedBox(width: 8),
                _buildTab("Canceled", false),
                SizedBox(width: 8),
                _buildTab("All", true),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: "Search by order number or customer name",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                OrderCard(
                  orderId: "ORD-001#",
                  name: "Ahmed Mohammed Al-Amoudi\n(Al-Amoudi)",
                  time: "2 HOURS AGO",
                  status: "PENDING",
                  amount: "1,250",
                ),
                SizedBox(height: 12),
                OrderCard(
                  orderId: "ORD-002#",
                  name: "Sarah Abdullah\n(Sarah Abdullah)",
                  time: "4 HOURS AGO",
                  status: "CONFIRMED",
                  amount: "3,400",
                ),
                SizedBox(height: 12),
                OrderCard(
                  orderId: "ORD-003#",
                  name: "Yassin Al-Otaibi\n(Otaibi)",
                  time: "YESTERDAY",
                  status: "CANCELED",
                  amount: "2,750",
                ),
                SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Load More..",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderId, name, time, status, amount;
  const OrderCard({
    super.key,
    required this.orderId,
    required this.name,
    required this.time,
    required this.status,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrderDetails()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(time, style: TextStyle(color: Colors.grey, fontSize: 13)),
              Text(orderId, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (status.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: _getTextColor(status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Text(
                "$amount SAR",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

  Color _getTextColor(String s) => s == "PENDING"
      ? Colors.orange[700]!
      : s == "CONFIRMED"
      ? Colors.green[700]!
      : Colors.red[700]!;
  Color _getBackgroundColor(String s) => s == "PENDING"
      ? Colors.orange[50]!
      : s == "CONFIRMED"
      ? Colors.green[50]!
      : Colors.red[50]!;
}
