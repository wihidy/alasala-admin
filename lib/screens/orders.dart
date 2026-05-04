import 'package:ai_customer_service_stock_management_system/screens/notifications.dart';
import 'package:ai_customer_service_stock_management_system/screens/profile.dart';
import 'package:ai_customer_service_stock_management_system/screens/order_details.dart';
import 'package:ai_customer_service_stock_management_system/supabase_helper.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final SupabaseHelper _supabaseHelper = SupabaseHelper();
  bool _isLoading = true;
  List<Map<String, dynamic>> _allOrders = [];
  List<Map<String, dynamic>> _filteredOrders = [];
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final orders = await _supabaseHelper.getOrders();
      setState(() {
        _allOrders = orders;
        _filteredOrders = orders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('Error fetching orders: $e');
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredOrders = _allOrders.where((order) {
        final matchesStatus = _selectedFilter == 'All' || 
            order['status']?.toString().toUpperCase() == _selectedFilter.toUpperCase();
        
        final query = _searchController.text.toLowerCase();
        final matchesSearch =( order['customer_name']?.toString().toLowerCase().contains(query) ?? false ) ||
           ( order['custom_id']?.toString().toLowerCase().contains(query) ?? false );
            
        return matchesStatus && matchesSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Color(0xFF1A3365))),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3365),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Notifications()),
            );
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF1A3365)),
            ),
          ),
          const SizedBox(width: 16),
        ],
        centerTitle: true,
        title: Column(
          children: const [
            Text(
              "الطلبات",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "ORDERS",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                _buildTab("Confirmed", _selectedFilter == "Confirmed"),
                const SizedBox(width: 8),
                _buildTab("Pending", _selectedFilter == "Pending"),
                const SizedBox(width: 8),
                _buildTab("Canceled", _selectedFilter == "Canceled"),
                const SizedBox(width: 8),
                _buildTab("All", _selectedFilter == "All"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => _applyFilters(),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredOrders.length,
              itemBuilder: (context, index) {
                final order = _filteredOrders[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OrderCard(
                    orderId: order['custom_id'] ?? 'ORD-${order['id']}#',
                    name: order['customer_name'] ?? 'بدون اسم',
                    time: order['created_at']?.toString().split('T')[0] ?? 'N/A',
                    status: order['status']?.toString().toUpperCase() ?? 'PENDING',
                    amount: "${order['total_amount']}",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = title;
            _applyFilters();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 12,
              ),
            ),
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